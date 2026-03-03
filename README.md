# PabloLerma.github.io

Blog personal de [Pablo Lerma](https://pablolerma.github.io) — construido con [Jekyll](https://jekyllrb.com) y publicado en GitHub Pages.

## Requisitos

- macOS con [Homebrew](https://brew.sh)
- El script `setup.sh` se encarga del resto

## Instalación

```bash
./setup.sh
```

Esto instala automáticamente: Homebrew, rbenv, Ruby 3.2.0 y las dependencias del proyecto.

## Lanzar en local

```bash
bundle exec jekyll serve --watch
```

La web estará disponible en http://localhost:4000.

## Estructura

```
_posts/       # Entradas del blog
_layouts/     # Plantillas HTML
_includes/    # Fragmentos reutilizables
_sass/        # Estilos
images/       # Imágenes
```

## Publicar

Los cambios pusheados a `main` se publican automáticamente en GitHub Pages.
