#!/usr/bin/env bash
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ok()   { echo -e "${GREEN}✓${NC} $1"; }
info() { echo -e "${YELLOW}→${NC} $1"; }
err()  { echo -e "${RED}✗${NC} $1"; exit 1; }

RUBY_VERSION=$(cat "$(dirname "$0")/.ruby-version")

# ── 1. Homebrew ──────────────────────────────────────────────────────────────
if command -v brew &>/dev/null; then
  ok "Homebrew ya instalado"
else
  info "Instalando Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Apple Silicon: añadir brew al PATH para esta sesión
  eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || true
  ok "Homebrew instalado"
fi

# ── 2. rbenv + ruby-build ────────────────────────────────────────────────────
if command -v rbenv &>/dev/null; then
  ok "rbenv ya instalado"
else
  info "Instalando rbenv y ruby-build..."
  brew install rbenv ruby-build
  ok "rbenv instalado"
fi

# Inicializar rbenv en esta sesión
eval "$(rbenv init - bash)"

# ── 3. Ruby ──────────────────────────────────────────────────────────────────
if rbenv versions --bare | grep -qx "$RUBY_VERSION"; then
  ok "Ruby $RUBY_VERSION ya instalado"
else
  info "Instalando Ruby $RUBY_VERSION (puede tardar unos minutos)..."
  rbenv install "$RUBY_VERSION"
  ok "Ruby $RUBY_VERSION instalado"
fi

rbenv local "$RUBY_VERSION"

# ── 4. Bundler ───────────────────────────────────────────────────────────────
if gem list bundler -i &>/dev/null; then
  ok "Bundler ya instalado"
else
  info "Instalando Bundler..."
  gem install bundler
  rbenv rehash
  ok "Bundler instalado"
fi

# ── 5. Dependencias del proyecto ─────────────────────────────────────────────
info "Instalando dependencias del proyecto..."
bundle install
ok "Dependencias instaladas"

echo ""
echo -e "${GREEN}Listo. Lanza el proyecto con:${NC}"
echo "  bundle exec jekyll serve --watch"
