#!/usr/bin/env bash

file="$1"
w="$2"
h="$3"
x="$4"
y="$5"

# Функция для очистки предыдущих изображений
clear_images() {
    kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
}

# Определяем MIME тип файла
filetype="$(file -Lb --mime-type "$file")"

# Обработка изображений
if [[ "$filetype" =~ ^image ]]; then
    # Очищаем предыдущие изображения
    clear_images
    
    # Показываем новое изображение
    kitty +kitten icat --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y}" "$file" < /dev/null > /dev/tty
    
    # Показываем метаданные изображения внизу
    echo
    if command -v exiftool >/dev/null 2>&1; then
        exiftool -S -ImageSize -FileType -ColorSpace -BitsPerSample -Megapixels -CreateDate "$file" 2>/dev/null | head -10
    else
        identify "$file" 2>/dev/null | head -3 || file "$file"
    fi
    
    exit 1
fi

# Обработка других типов файлов
case "$file" in
    *.pdf)
        if command -v pdftotext >/dev/null 2>&1; then
            pdftotext "$file" - | head -"$h"
        else
            echo "PDF file: $(basename "$file")"
        fi
        ;;
    *.zip)
        if command -v zipinfo >/dev/null 2>&1; then
            zipinfo "$file"
        else
            echo "ZIP archive: $(basename "$file")"
        fi
        ;;
    *.tar.gz) tar -ztvf "$file" 2>/dev/null || echo "TAR.GZ archive: $(basename "$file")" ;;
    *.tar.bz2) tar -jtvf "$file" 2>/dev/null || echo "TAR.BZ2 archive: $(basename "$file")" ;;
    *.tar) tar -tvf "$file" 2>/dev/null || echo "TAR archive: $(basename "$file")" ;;
    *)
        # Пытаемся использовать bat для подсветки синтаксиса
        if command -v bat >/dev/null 2>&1; then
            bat --color=always --style=numbers --line-range=":$h" "$file" 2>/dev/null
        # Если bat недоступен, используем обычный cat
        elif [[ "$filetype" =~ ^text ]] || file "$file" | grep -q text; then
            head -"$h" "$file"
        else
            # Для бинарных файлов показываем информацию
            echo "File: $(basename "$file")"
            echo "Type: $filetype"
            echo "Size: $(du -h "$file" | cut -f1)"
            echo
            file "$file"
        fi
        ;;
esac
