
# Required packages
PRODUCT_PACKAGES += \
    Aperture \
    DocumentsUI \
    DocumentsUIOverlay \
    LatinIME \
    Launcher3QuickStep \
    messaging \
    NetworkStackOverlay \
    Stk \
    ThemePicker \
    ThemesStub

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += \
    vendor/linevall/overlay \
    vendor/linevall/overlay/no-rro

PRODUCT_PACKAGE_OVERLAYS += \
    vendor/linevall/overlay/common \
    vendor/linevall/overlay/no-rro


# Include LineVall LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/linevall/overlay/dictionaries
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/linevall/overlay/dictionaries

# Charger
PRODUCT_PACKAGES += \
    product_charger_res_images

# Extra tools
PRODUCT_PACKAGES += \
    7z \
    bash \
    curl \
    getcap \
    htop \
    lib7z \
    nano \
    pigz \
    setcap \
    unrar \
    vim \
    zip

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/curl \
    system/bin/getcap \
    system/bin/setcap

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.ntfs \
    mkfs.ntfs \
    mount.ntfs

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/fsck.ntfs \
    system/bin/mkfs.ntfs \
    system/bin/mount.ntfs \
    system/%/libfuse-lite.so \
    system/%/libntfs-3g.so

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/procmem
endif

# World APN list
PRODUCT_PACKAGES += \
    apns-conf.xml

# Sensitive Phone Numbers list
PRODUCT_COPY_FILES += \
    vendor/prebuilts/common/etc/sensitive_pn.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sensitive_pn.xml