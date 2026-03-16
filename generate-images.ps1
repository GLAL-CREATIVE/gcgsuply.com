# Product Image Generator for GCG SUPPLY
# This script creates SVG placeholder images for all products

$products = @{
    "memory/samsung" = @(
        @{name="ddr5-rdimm"; title="Samsung DDR5 ECC RDIMM"; spec="16GB - 128GB | 4800MHz"; chips=4},
        @{name="ddr5-lrdimm"; title="Samsung DDR5 LRDIMM"; spec="64GB - 256GB | 4800MHz | Load-Reduced"; chips=5},
        @{name="ddr4-rdimm"; title="Samsung DDR4 ECC RDIMM"; spec="16GB - 64GB | 3200MHz"; chips=4}
    )
    "memory/skhynix" = @(
        @{name="ddr5-rdimm"; title="SK Hynix DDR5 ECC RDIMM"; spec="16GB - 128GB | 4800MHz"; chips=4},
        @{name="ddr5-lrdimm"; title="SK Hynix DDR5 LRDIMM"; spec="64GB - 256GB | 4800MHz | Load-Reduced"; chips=5},
        @{name="ddr4-rdimm"; title="SK Hynix DDR4 ECC RDIMM"; spec="16GB - 64GB | 3200MHz"; chips=4}
    )
    "storage/samsung" = @(
        @{name="pm893-sata"; title="Samsung PM893 SATA SSD"; spec="960GB - 30.72TB | SATA 6Gb/s | 1.3 DWPD"; type="ssd"},
        @{name="pm9a3-nvme"; title="Samsung PM9A3 NVMe SSD"; spec="960GB - 15.36TB | PCIe 4.0 x4 | U.2"; type="ssd"},
        @{name="pm1733-nvme"; title="Samsung PM1733 NVMe SSD"; spec="1.92TB - 15.36TB | PCIe 4.0 x4 | U.2"; type="ssd"}
    )
    "storage/seagate" = @(
        @{name="exos-x20"; title="Seagate Exos X20"; spec="20TB | 7200 RPM | SATA 6Gb/s"; type="hdd"},
        @{name="exos-x18"; title="Seagate Exos X18"; spec="18TB | 7200 RPM | SATA 6Gb/s"; type="hdd"},
        @{name="exos-x16"; title="Seagate Exos X16"; spec="16TB | 7200 RPM | SATA 6Gb/s"; type="hdd"}
    )
    "storage/wd" = @(
        @{name="ultrastar-hc560"; title="WD Ultrastar DC HC560"; spec="20TB | 7200 RPM | SATA 6Gb/s"; type="hdd"},
        @{name="ultrastar-hc550"; title="WD Ultrastar DC HC550"; spec="18TB | 7200 RPM | SATA 6Gb/s"; type="hdd"},
        @{name="ultrastar-hc520"; title="WD Ultrastar DC HC520"; spec="12TB | 7200 RPM | SATA 6Gb/s"; type="hdd"}
    )
    "gpu/nvidia" = @(
        @{name="h100-sxm5"; title="NVIDIA H100 Tensor Core"; spec="80GB HBM3 | SXM5 | 700W"; type="gpu"},
        @{name="h100-pcie"; title="NVIDIA H100 Tensor Core"; spec="80GB HBM3 | PCIe | 350W"; type="gpu"},
        @{name="h200-sxm5"; title="NVIDIA H200 Tensor Core"; spec="141GB HBM3e | SXM5 | 700W"; type="gpu"},
        @{name="a100-sxm4"; title="NVIDIA A100 Tensor Core"; spec="80GB HBM2e | SXM4 | 400W"; type="gpu"},
        @{name="a100-pcie"; title="NVIDIA A100 Tensor Core"; spec="80GB HBM2e | PCIe | 300W"; type="gpu"}
    )
}

$brandColors = @{
    "samsung" = "#1428A0"
    "skhynix" = "#E31837"
    "seagate" = "#6EBE44"
    "wd" = "#000000"
    "nvidia" = "#76B900"
}

$brandNames = @{
    "samsung" = "SAMSUNG"
    "skhynix" = "SK hynix"
    "seagate" = "SEAGATE"
    "wd" = "Western Digital"
    "nvidia" = "NVIDIA"
}

function Create-MemorySVG($product, $brand, $folder) {
    $chips = $product.chips
    $chipWidth = if ($chips -eq 5) { 90 } else { 80 }
    $totalWidth = $chips * $chipWidth + ($chips - 1) * 20
    $startX = (800 - $totalWidth) / 2
    
    $chipRects = ""
    for ($i = 0; $i -lt $chips; $i++) {
        $x = $startX + $i * ($chipWidth + 20)
        $chipRects += "<rect x=`"$x`" y=`"240`" width=`"$chipWidth`" height=`"120`" rx=`"3`" fill=`"url(#chip)`"/>"
    }
    
    $svg = @"
<svg xmlns="http://www.w3.org/2000/svg" width="800" height="600" viewBox="0 0 800 600">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#f8fafc"/>
      <stop offset="100%" style="stop-color:#e2e8f0"/>
    </linearGradient>
    <linearGradient id="chip" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:$($brandColors[$brand])"/>
      <stop offset="100%" style="stop-color:darken"/>
    </linearGradient>
  </defs>
  <rect width="800" height="600" fill="url(#bg)"/>
  <rect x="100" y="200" width="600" height="200" rx="10" fill="#1e293b"/>
  <rect x="120" y="220" width="560" height="160" rx="5" fill="#0f172a"/>
  $chipRects
  <text x="400" y="460" text-anchor="middle" font-family="Arial, sans-serif" font-size="26" font-weight="600" fill="#0f172a">$($product.title)</text>
  <text x="400" y="500" text-anchor="middle" font-family="Arial, sans-serif" font-size="16" fill="#64748b">$($product.spec)</text>
  <text x="400" y="100" text-anchor="middle" font-family="Arial, sans-serif" font-size="44" font-weight="700" fill="$($brandColors[$brand])">$($brandNames[$brand])</text>
</svg>
"@
    
    $path = "D:\GLOBAL_CREATIVE_GROUP_Products\website\images\products\$folder\$($product.name).svg"
    $svg | Out-File -FilePath $path -Encoding UTF8
    Write-Host "Created: $path"
}

function Create-StorageSVG($product, $brand, $folder) {
    $svg = @"
<svg xmlns="http://www.w3.org/2000/svg" width="800" height="600" viewBox="0 0 800 600">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#f8fafc"/>
      <stop offset="100%" style="stop-color:#e2e8f0"/>
    </linearGradient>
    <linearGradient id="device" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#334155"/>
      <stop offset="100%" style="stop-color:#1e293b"/>
    </linearGradient>
  </defs>
  <rect width="800" height="600" fill="url(#bg)"/>
  <rect x="200" y="150" width="400" height="300" rx="15" fill="url(#device)" stroke="#475569" stroke-width="2"/>
  <rect x="220" y="170" width="360" height="260" rx="10" fill="#0f172a"/>
  <circle cx="400" cy="300" r="60" fill="none" stroke="$($brandColors[$brand])" stroke-width="4"/>
  <circle cx="400" cy="300" r="30" fill="$($brandColors[$brand])"/>
  <text x="400" y="460" text-anchor="middle" font-family="Arial, sans-serif" font-size="26" font-weight="600" fill="#0f172a">$($product.title)</text>
  <text x="400" y="500" text-anchor="middle" font-family="Arial, sans-serif" font-size="16" fill="#64748b">$($product.spec)</text>
  <text x="400" y="100" text-anchor="middle" font-family="Arial, sans-serif" font-size="44" font-weight="700" fill="$($brandColors[$brand])">$($brandNames[$brand])</text>
</svg>
"@
    
    $path = "D:\GLOBAL_CREATIVE_GROUP_Products\website\images\products\$folder\$($product.name).svg"
    $svg | Out-File -FilePath $path -Encoding UTF8
    Write-Host "Created: $path"
}

function Create-GPUSVG($product, $brand, $folder) {
    $svg = @"
<svg xmlns="http://www.w3.org/2000/svg" width="800" height="600" viewBox="0 0 800 600">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#f8fafc"/>
      <stop offset="100%" style="stop-color:#e2e8f0"/>
    </linearGradient>
    <linearGradient id="gpu" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#1e293b"/>
      <stop offset="100%" style="stop-color:#0f172a"/>
    </linearGradient>
  </defs>
  <rect width="800" height="600" fill="url(#bg)"/>
  <rect x="150" y="180" width="500" height="240" rx="10" fill="url(#gpu)"/>
  <rect x="170" y="200" width="460" height="200" rx="5" fill="#1e293b"/>
  <rect x="190" y="220" width="100" height="160" rx="5" fill="#334155"/>
  <rect x="310" y="220" width="100" height="160" rx="5" fill="#334155"/>
  <rect x="430" y="220" width="100" height="160" rx="5" fill="#334155"/>
  <rect x="550" y="220" width="60" height="160" rx="5" fill="$($brandColors[$brand])"/>
  <text x="400" y="460" text-anchor="middle" font-family="Arial, sans-serif" font-size="26" font-weight="600" fill="#0f172a">$($product.title)</text>
  <text x="400" y="500" text-anchor="middle" font-family="Arial, sans-serif" font-size="16" fill="#64748b">$($product.spec)</text>
  <text x="400" y="100" text-anchor="middle" font-family="Arial, sans-serif" font-size="44" font-weight="700" fill="$($brandColors[$brand])">$($brandNames[$brand])</text>
</svg>
"@
    
    $path = "D:\GLOBAL_CREATIVE_GROUP_Products\website\images\products\$folder\$($product.name).svg"
    $svg | Out-File -FilePath $path -Encoding UTF8
    Write-Host "Created: $path"
}

# Generate all images
foreach ($folder in $products.Keys) {
    $brand = $folder.Split('/')[1]
    foreach ($product in $products[$folder]) {
        if ($product.type -eq "ssd" -or $product.type -eq "hdd") {
            Create-StorageSVG $product $brand $folder
        } elseif ($product.type -eq "gpu") {
            Create-GPUSVG $product $brand $folder
        } else {
            Create-MemorySVG $product $brand $folder
        }
    }
}

Write-Host "`nAll product images generated successfully!"
