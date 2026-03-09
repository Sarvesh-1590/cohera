<?php
$dirs = [
    'c:/cohera/packages/Webkul/Admin/src/Resources/views',
    'c:/cohera/packages/Webkul/Admin/src/Resources/lang/en',
    'c:/cohera/packages/Webkul/Installer/src/Resources/views',
    'c:/cohera/packages/Webkul/Installer/src/Resources/lang/en',
];

foreach ($dirs as $dir) {
    if (!is_dir($dir))
        continue;
    $iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($dir));
    foreach ($iterator as $file) {
        if ($file->isFile() && in_array($file->getExtension(), ['php'])) {
            $path = $file->getRealPath();
            $content = file_get_contents($path);

            $newContent = str_replace(
                ['Krayin', 'krayin', 'krayincrm.com'],
                ['Cohera', 'cohera', '#'],
                $content
            );

            if ($newContent !== $content) {
                file_put_contents($path, $newContent);
                echo "Updated: $path\n";
            }
        }
    }
}
echo "Done.\n";
