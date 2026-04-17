# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=4.0.1
FROM ghcr.io/rails/devcontainer/images/ruby:$RUBY_VERSION

# Define build args so the 'Create non-root user' section actually works
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000

# ---- SWITCH TO ROOT TO INSTALL EVERYTHING ----
USER root

# Ensure binding is always 0.0.0.0
ENV BINDING="0.0.0.0"

# ---- System dependencies ----
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential git curl wget unzip \
    libsqlite3-dev sqlite3 \
    libvips \
    chromium \
    fonts-liberation fonts-noto-color-emoji \
    libnss3 libatk-bridge2.0-0 libdrm2 \
    libxkbcommon0 libgbm1 libasound2 \
    ripgrep fd-find fzf bat tmux jq \
    ninja-build gettext cmake \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ---- Install Neovim (latest stable) ----
RUN curl -fLo /tmp/nvim.tar.gz https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz \
    && tar -xzf /tmp/nvim.tar.gz -C /opt \
    && ln -s /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim \
    && rm /tmp/nvim.tar.gz

# ---- Install Node 20 ----
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ---- Install lazygit ----
RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | jq -r '.tag_name' | sed 's/v//') \
    && curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" \
    && tar -xzf lazygit.tar.gz lazygit \
    && install lazygit /usr/local/bin \
    && rm lazygit lazygit.tar.gz

# ---- Create/Fix non-root user ----
RUN if ! id -u ${USERNAME} > /dev/null 2>&1; then \
        groupadd --gid ${USER_GID} ${USERNAME} && \
        useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} -s /bin/bash; \
    fi \
    && mkdir -p /home/${USERNAME}/.local/share \
    && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

# ---- Chromium / Grover env ----
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV GROVER_NO_SANDBOX=true

# ==========================================
# Pre-create ALL named volume mount points and give ownership to vscode
RUN mkdir -p /workspace/node_modules \
             /home/${USERNAME}/.config/nvim \
             /home/${USERNAME}/.local/share/nvim \
             /home/${USERNAME}/.bash_history_vol \
    && chown -R ${USERNAME}:${USERNAME} /workspace /home/${USERNAME}

# ==========================================

# ---- Switch to dev user ----
USER ${USERNAME}
WORKDIR /workspace

# Force the mise shims into the PATH so Docker can find `ruby` and `gem`
ENV PATH="/home/${USERNAME}/.local/share/mise/shims:/home/${USERNAME}/.local/bin:/usr/local/share/mise/shims:${PATH}"
# ==========================================

# ---- Install Ruby dev gems ----
# No need for bash -l -c anymore, the PATH is permanently fixed!
RUN gem install bundler solargraph ruby-lsp rubocop rubocop-rails

# ---- Set editor ----
ENV EDITOR=nvim
ENV VISUAL=nvim
ENV LANG=C.UTF-8

# ---- Shell config ----
RUN echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc \
    && echo 'alias vim="nvim"' >> ~/.bashrc \
    && echo 'alias vi="nvim"' >> ~/.bashrc \
    && echo 'alias lg="lazygit"' >> ~/.bashrc \
    && echo 'alias rs="bin/rails server -b 0.0.0.0"' >> ~/.bashrc
