#!/usr/bin/env bash
set -euo pipefail

echo "📦 Удаляем старые Nix-приложения..."

NIX_APPS_HOME="$HOME/Applications/Nix Apps"
NIX_APPS_SYS="/Applications/Nix Apps"

if [ -d "$NIX_APPS_HOME" ]; then
    echo " - Чистим $NIX_APPS_HOME"
    rm -rf "$NIX_APPS_HOME"/*
fi

if [ -d "$NIX_APPS_SYS" ]; then
    echo " - Чистим $NIX_APPS_SYS"
    sudo rm -rf "$NIX_APPS_SYS"/*
fi

echo "🧹 Удаляем старые поколения профилей..."
home-manager expire-generations '-1 days' || true
nix-env --delete-generations old || true

echo "🗑 Запускаем сборку мусора..."
nix store gc

echo "🔄 Перезапускаем Finder..."
killall Finder || true

echo "🧼 Очищаем кэш Launchpad..."
defaults write com.apple.dock ResetLaunchPad -bool true
killall Dock || true

echo "✅ Готово! Все старые приложения и иконки удалены."
