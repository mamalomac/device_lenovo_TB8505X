# OrangeFox device tree – Lenovo Tab M8 HD LTE (TB-8505X)

| | |
|---|---|
| Codename | `akita_row_call` (tree name `TB8505X`) |
| SoC | MediaTek MT6761 / MT8766 (Helio A22) |
| Stock firmware | `TB-8505X_S301129_230914_BMP`, Android 10, patch 2023-08-05 |
| Kernel | Prebuilt stock 4.9.190 (`Image.gz`) + separate `dtb` + recovery `dtbo` |
| Boot image | Header v2, page 2048, base `0x40078000`, gzip ramdisk only |
| Partitions | Non-A/B, no `super` (plain system/vendor), recovery = 32 MB |
| Display / touch | 800×1280; FocalTech + Novatek touch drivers are built into the kernel |
| OrangeFox branch | `fox_12.1` |

## Build

### Option A – GitHub Actions (no Linux PC needed)
1. Create a new GitHub repo and push the **contents** of this folder to it
   (including the hidden `.github` folder).
2. Open the **Actions** tab → *Build OrangeFox (TB-8505X)* → **Run workflow**.
3. When it finishes (~2 h), download the `OrangeFox-TB8505X` artifact.

### Option B – Linux PC (Ubuntu 22.04+/Debian, ~100 GB free disk, 16 GB RAM)
```bash
git clone https://gitlab.com/OrangeFox/sync.git ~/fox_sync
cd ~/fox_sync
./orangefox_sync.sh --branch 12.1 --path ~/fox_12.1

# put this tree in place
mkdir -p ~/fox_12.1/device/lenovo
cp -r /path/to/device_lenovo_TB8505X ~/fox_12.1/device/lenovo/TB8505X

cd ~/fox_12.1
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export FOX_BUILD_DEVICE=TB8505X
lunch twrp_TB8505X-eng
mka adbd recoveryimage
```
The output is `out/target/product/TB8505X/OrangeFox-*.img`.

If the build stops with *"recovery.img too large"*: the stock kernel can only
unpack a **gzip** ramdisk, so the image must fit in 32 MB without LZMA. Remove
more features in `orangefox.mk` / `BoardConfig.mk` (for example
`TWRP_INCLUDE_LOGCAT`, `TW_EXTRA_LANGUAGES`).

## Flash

> Unlocking the bootloader **erases everything** on the tablet.

1. Settings → About tablet → tap *Build number* 7× → Developer options →
   enable **OEM unlocking** and **USB debugging**.
2. `adb reboot bootloader`
3. `fastboot flashing unlock` → confirm with Volume Up on the tablet.
4. Flash the patched vbmeta (from this package):
   ```
   fastboot flash vbmeta vbmeta_disabled.img
   ```
   or, using the stock vbmeta:
   `fastboot --disable-verity --disable-verification flash vbmeta vbmeta.img`
   (`vbmeta_blank.img` is a last-resort alternative if the patched one is refused.)
5. `fastboot flash recovery OrangeFox-xxx.img`
6. **Boot straight into recovery** – don't let Android start first, or stock
   Android may restore the stock recovery:
   `fastboot reboot` and immediately hold **Power + Volume Up**, then pick
   *Recovery* in the menu that appears.
7. In OrangeFox, **back up NVRAM, NVDATA, NVCFG, Protect_f/s, Persist and
   Proinfo** to an SD card or PC. These hold your IMEI/radio calibration.

## Known limitations
- **No decryption.** Stock uses FDE with the Microtrust TEE; the vendor
  keymaster blobs aren't in this tree. If `/data` won't mount, use
  *Wipe → Format Data* (type `yes`). After the unlock wipe there's nothing
  to lose.
- MicroSD and USB-OTG entries assume `mmcblk1p1` / `sda1`.
- First build is untested on hardware: if the screen stays black but `adb`
  works, run `adb pull /tmp/recovery.log` and check the graphics lines.

## Files
```
BoardConfig.mk          board, kernel offsets, partitions, TWRP flags
orangefox.mk            OrangeFox build vars (included from BoardConfig)
vendorsetup.sh          same OrangeFox vars as env exports
device.mk               product config
twrp_TB8505X.mk         product makefile (lunch target)
AndroidProducts.mk / Android.mk
prebuilt/               stock kernel, dtb and recovery dtbo
recovery/root/          recovery.fstab and init.recovery rc files
.github/workflows/      GitHub Actions build
```
