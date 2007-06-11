Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2007 14:09:04 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:44704 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20024012AbXFKNJA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Jun 2007 14:09:00 +0100
Received: by ug-out-1314.google.com with SMTP id m3so1568811ugc
        for <linux-mips@linux-mips.org>; Mon, 11 Jun 2007 06:08:59 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=W4+nFUhmEMuJbcQEZgbIPq1iH1+uUaDdBqDGWsY6h/TtYKS/j52wzAvkwnGedp4bNJT1pkukSO3JEYfK7WIy4Fcrj/W2ujSWHAqVr8JIq7dZUF/aQanvE361fym5EJ9vzTByX/Di5YgYSTVXecUyoANfRk8JacZwYMzAj3DHuic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=SsZakm/z6DJwgOZbYOhtvrU7unVz/w2vxIqLxzu9kcz8hrRqhnyhZm1E+Qyg75EDuVNa4HU5t9Y+kW3W9Hb78JyvuNYGGglqeLNEqxrb/LeUOmcmGjMtZzMH4ZQr3j2jbcv6wGHaPuwEEH/ssxY7wcLnQMD0KiB4li8fqn4zn74=
Received: by 10.82.126.5 with SMTP id y5mr10840158buc.1181567339164;
        Mon, 11 Jun 2007 06:08:59 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id z34sm13865042ikz.2007.06.11.06.08.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jun 2007 06:08:54 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 4F77323F770; Mon, 11 Jun 2007 15:08:56 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 2/3] Remove MIPS SEAD support
Date:	Mon, 11 Jun 2007 15:08:54 +0200
Message-Id: <11815673362011-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11815673353523-git-send-email-fbuihuu@gmail.com>
References: <11815673353523-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

Mips Sead support is deprecated and scheduled for removal
since September 2006.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/Kconfig                       |   19 -
 arch/mips/Makefile                      |   11 -
 arch/mips/configs/sead_defconfig        |  651 -------------------------------
 arch/mips/mips-boards/generic/console.c |   13 -
 arch/mips/mips-boards/generic/init.c    |    5 +-
 arch/mips/mips-boards/generic/reset.c   |    2 -
 arch/mips/mips-boards/generic/time.c    |   11 +-
 arch/mips/mips-boards/sead/Makefile     |   26 --
 arch/mips/mips-boards/sead/sead_int.c   |  117 ------
 arch/mips/mips-boards/sead/sead_setup.c |   81 ----
 include/asm-mips/mips-boards/generic.h  |   10 +-
 include/asm-mips/mips-boards/sead.h     |   36 --
 include/asm-mips/mips-boards/seadint.h  |   35 --
 include/asm-mips/war.h                  |    4 +-
 14 files changed, 5 insertions(+), 1016 deletions(-)
 delete mode 100644 arch/mips/configs/sead_defconfig
 delete mode 100644 arch/mips/mips-boards/sead/Makefile
 delete mode 100644 arch/mips/mips-boards/sead/sead_int.c
 delete mode 100644 arch/mips/mips-boards/sead/sead_setup.c
 delete mode 100644 include/asm-mips/mips-boards/sead.h
 delete mode 100644 include/asm-mips/mips-boards/seadint.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3e1de55..731b438 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -172,25 +172,6 @@ config MIPS_MALTA
 	  This enables support for the MIPS Technologies Malta evaluation
 	  board.
 
-config MIPS_SEAD
-	bool "MIPS SEAD board (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	select IRQ_CPU
-	select DMA_NONCOHERENT
-	select SYS_HAS_EARLY_PRINTK
-	select MIPS_BOARDS_GEN
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_HAS_CPU_MIPS32_R2
-	select SYS_HAS_CPU_MIPS64_R1
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_SMARTMIPS
-	help
-	  This enables support for the MIPS Technologies SEAD evaluation
-	  board.
-
 config WR_PPMC
 	bool "Wind River PPMC board"
 	select IRQ_CPU
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 8ce1075..1f0fb74 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -310,13 +310,6 @@ cflags-$(CONFIG_MIPS_MALTA)	+= -Iinclude/asm-mips/mach-mips
 load-$(CONFIG_MIPS_MALTA)	+= 0xffffffff80100000
 
 #
-# MIPS SEAD board
-#
-core-$(CONFIG_MIPS_SEAD)	+= arch/mips/mips-boards/sead/
-cflags-$(CONFIG_MIPS_SEAD)	+= -Iinclude/asm-mips/mach-mips
-load-$(CONFIG_MIPS_SEAD)	+= 0xffffffff80100000
-
-#
 # MIPS SIM
 #
 core-$(CONFIG_MIPS_SIM)		+= arch/mips/mips-boards/sim/
@@ -666,10 +659,6 @@ ifdef CONFIG_MIPS_MALTA
 all:	vmlinux.srec
 endif
 
-ifdef CONFIG_MIPS_SEAD
-all:	vmlinux.srec
-endif
-
 ifdef CONFIG_QEMU
 all:	vmlinux.bin
 endif
diff --git a/arch/mips/configs/sead_defconfig b/arch/mips/configs/sead_defconfig
deleted file mode 100644
index 988b9cd..0000000
--- a/arch/mips/configs/sead_defconfig
+++ /dev/null
@@ -1,651 +0,0 @@
-#
-# Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Sun Feb 18 21:28:10 2007
-#
-CONFIG_MIPS=y
-
-#
-# Machine selection
-#
-CONFIG_ZONE_DMA=y
-# CONFIG_MIPS_MTX1 is not set
-# CONFIG_MIPS_BOSPORUS is not set
-# CONFIG_MIPS_PB1000 is not set
-# CONFIG_MIPS_PB1100 is not set
-# CONFIG_MIPS_PB1500 is not set
-# CONFIG_MIPS_PB1550 is not set
-# CONFIG_MIPS_PB1200 is not set
-# CONFIG_MIPS_DB1000 is not set
-# CONFIG_MIPS_DB1100 is not set
-# CONFIG_MIPS_DB1500 is not set
-# CONFIG_MIPS_DB1550 is not set
-# CONFIG_MIPS_DB1200 is not set
-# CONFIG_MIPS_MIRAGE is not set
-# CONFIG_BASLER_EXCITE is not set
-# CONFIG_MIPS_COBALT is not set
-# CONFIG_MACH_DECSTATION is not set
-# CONFIG_MIPS_EV64120 is not set
-# CONFIG_MACH_JAZZ is not set
-# CONFIG_LASAT is not set
-# CONFIG_MIPS_ATLAS is not set
-# CONFIG_MIPS_MALTA is not set
-CONFIG_MIPS_SEAD=y
-# CONFIG_WR_PPMC is not set
-# CONFIG_MIPS_SIM is not set
-# CONFIG_MOMENCO_JAGUAR_ATX is not set
-# CONFIG_MOMENCO_OCELOT is not set
-# CONFIG_MOMENCO_OCELOT_3 is not set
-# CONFIG_MOMENCO_OCELOT_C is not set
-# CONFIG_MOMENCO_OCELOT_G is not set
-# CONFIG_MIPS_XXS1500 is not set
-# CONFIG_PNX8550_JBS is not set
-# CONFIG_PNX8550_STB810 is not set
-# CONFIG_DDB5477 is not set
-# CONFIG_MACH_VR41XX is not set
-# CONFIG_PMC_YOSEMITE is not set
-# CONFIG_QEMU is not set
-# CONFIG_MARKEINS is not set
-# CONFIG_SGI_IP22 is not set
-# CONFIG_SGI_IP27 is not set
-# CONFIG_SGI_IP32 is not set
-# CONFIG_SIBYTE_BIGSUR is not set
-# CONFIG_SIBYTE_SWARM is not set
-# CONFIG_SIBYTE_SENTOSA is not set
-# CONFIG_SIBYTE_RHONE is not set
-# CONFIG_SIBYTE_CARMEL is not set
-# CONFIG_SIBYTE_PTSWARM is not set
-# CONFIG_SIBYTE_LITTLESUR is not set
-# CONFIG_SIBYTE_CRHINE is not set
-# CONFIG_SIBYTE_CRHONE is not set
-# CONFIG_SNI_RM is not set
-# CONFIG_TOSHIBA_JMR3927 is not set
-# CONFIG_TOSHIBA_RBTX4927 is not set
-# CONFIG_TOSHIBA_RBTX4938 is not set
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_ARCH_HAS_ILOG2_U32 is not set
-# CONFIG_ARCH_HAS_ILOG2_U64 is not set
-CONFIG_GENERIC_FIND_NEXT_BIT=y
-CONFIG_GENERIC_HWEIGHT=y
-CONFIG_GENERIC_CALIBRATE_DELAY=y
-CONFIG_GENERIC_TIME=y
-CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-# CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
-CONFIG_DMA_NONCOHERENT=y
-CONFIG_DMA_NEED_PCI_MAP_STATE=y
-# CONFIG_CPU_BIG_ENDIAN is not set
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
-CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
-CONFIG_IRQ_CPU=y
-CONFIG_MIPS_BOARDS_GEN=y
-CONFIG_MIPS_L1_CACHE_SHIFT=5
-
-#
-# CPU selection
-#
-CONFIG_CPU_MIPS32_R1=y
-# CONFIG_CPU_MIPS32_R2 is not set
-# CONFIG_CPU_MIPS64_R1 is not set
-# CONFIG_CPU_MIPS64_R2 is not set
-# CONFIG_CPU_R3000 is not set
-# CONFIG_CPU_TX39XX is not set
-# CONFIG_CPU_VR41XX is not set
-# CONFIG_CPU_R4300 is not set
-# CONFIG_CPU_R4X00 is not set
-# CONFIG_CPU_TX49XX is not set
-# CONFIG_CPU_R5000 is not set
-# CONFIG_CPU_R5432 is not set
-# CONFIG_CPU_R6000 is not set
-# CONFIG_CPU_NEVADA is not set
-# CONFIG_CPU_R8000 is not set
-# CONFIG_CPU_R10000 is not set
-# CONFIG_CPU_RM7000 is not set
-# CONFIG_CPU_RM9000 is not set
-# CONFIG_CPU_SB1 is not set
-CONFIG_SYS_HAS_CPU_MIPS32_R1=y
-CONFIG_SYS_HAS_CPU_MIPS32_R2=y
-CONFIG_SYS_HAS_CPU_MIPS64_R1=y
-CONFIG_CPU_MIPS32=y
-CONFIG_CPU_MIPSR1=y
-CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
-CONFIG_SYS_SUPPORTS_64BIT_KERNEL=y
-CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
-
-#
-# Kernel type
-#
-CONFIG_32BIT=y
-# CONFIG_64BIT is not set
-CONFIG_PAGE_SIZE_4KB=y
-# CONFIG_PAGE_SIZE_8KB is not set
-# CONFIG_PAGE_SIZE_16KB is not set
-# CONFIG_PAGE_SIZE_64KB is not set
-CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
-# CONFIG_MIPS_MT_SMP is not set
-# CONFIG_MIPS_MT_SMTC is not set
-# CONFIG_MIPS_VPE_LOADER is not set
-# CONFIG_64BIT_PHYS_ADDR is not set
-CONFIG_CPU_HAS_LLSC=y
-# CONFIG_CPU_HAS_SMARTMIPS is not set
-CONFIG_CPU_HAS_SYNC=y
-CONFIG_GENERIC_HARDIRQS=y
-CONFIG_GENERIC_IRQ_PROBE=y
-CONFIG_CPU_SUPPORTS_HIGHMEM=y
-CONFIG_SYS_SUPPORTS_SMARTMIPS=y
-CONFIG_ARCH_FLATMEM_ENABLE=y
-CONFIG_SELECT_MEMORY_MODEL=y
-CONFIG_FLATMEM_MANUAL=y
-# CONFIG_DISCONTIGMEM_MANUAL is not set
-# CONFIG_SPARSEMEM_MANUAL is not set
-CONFIG_FLATMEM=y
-CONFIG_FLAT_NODE_MEM_MAP=y
-# CONFIG_SPARSEMEM_STATIC is not set
-CONFIG_SPLIT_PTLOCK_CPUS=4
-# CONFIG_RESOURCES_64BIT is not set
-CONFIG_ZONE_DMA_FLAG=1
-# CONFIG_HZ_48 is not set
-# CONFIG_HZ_100 is not set
-# CONFIG_HZ_128 is not set
-# CONFIG_HZ_250 is not set
-# CONFIG_HZ_256 is not set
-CONFIG_HZ_1000=y
-# CONFIG_HZ_1024 is not set
-CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
-CONFIG_HZ=1000
-CONFIG_PREEMPT_NONE=y
-# CONFIG_PREEMPT_VOLUNTARY is not set
-# CONFIG_PREEMPT is not set
-# CONFIG_KEXEC is not set
-CONFIG_LOCKDEP_SUPPORT=y
-CONFIG_STACKTRACE_SUPPORT=y
-CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
-
-#
-# Code maturity level options
-#
-CONFIG_EXPERIMENTAL=y
-CONFIG_BROKEN_ON_SMP=y
-CONFIG_INIT_ENV_ARG_LIMIT=32
-
-#
-# General setup
-#
-CONFIG_LOCALVERSION=""
-CONFIG_LOCALVERSION_AUTO=y
-# CONFIG_SWAP is not set
-CONFIG_SYSVIPC=y
-# CONFIG_IPC_NS is not set
-CONFIG_SYSVIPC_SYSCTL=y
-# CONFIG_BSD_PROCESS_ACCT is not set
-# CONFIG_UTS_NS is not set
-# CONFIG_IKCONFIG is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_RELAY=y
-CONFIG_INITRAMFS_SOURCE=""
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-CONFIG_SYSCTL=y
-CONFIG_EMBEDDED=y
-CONFIG_SYSCTL_SYSCALL=y
-CONFIG_KALLSYMS=y
-# CONFIG_KALLSYMS_EXTRA_PASS is not set
-# CONFIG_HOTPLUG is not set
-CONFIG_PRINTK=y
-CONFIG_BUG=y
-CONFIG_ELF_CORE=y
-CONFIG_BASE_FULL=y
-CONFIG_FUTEX=y
-CONFIG_EPOLL=y
-CONFIG_SHMEM=y
-CONFIG_SLAB=y
-CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_RT_MUTEXES=y
-# CONFIG_TINY_SHMEM is not set
-CONFIG_BASE_SMALL=0
-# CONFIG_SLOB is not set
-
-#
-# Loadable module support
-#
-# CONFIG_MODULES is not set
-
-#
-# Block layer
-#
-CONFIG_BLOCK=y
-# CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
-
-#
-# IO Schedulers
-#
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
-CONFIG_DEFAULT_AS=y
-# CONFIG_DEFAULT_DEADLINE is not set
-# CONFIG_DEFAULT_CFQ is not set
-# CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="anticipatory"
-
-#
-# Bus options (PCI, PCMCIA, EISA, ISA, TC)
-#
-CONFIG_MMU=y
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
-
-#
-# PCI Hotplug Support
-#
-
-#
-# Executable file formats
-#
-CONFIG_BINFMT_ELF=y
-# CONFIG_BINFMT_MISC is not set
-CONFIG_TRAD_SIGNALS=y
-
-#
-# Power management options
-#
-CONFIG_PM=y
-# CONFIG_PM_LEGACY is not set
-# CONFIG_PM_DEBUG is not set
-# CONFIG_PM_SYSFS_DEPRECATED is not set
-
-#
-# Networking
-#
-# CONFIG_NET is not set
-
-#
-# Device Drivers
-#
-
-#
-# Generic Driver Options
-#
-CONFIG_STANDALONE=y
-CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
-
-#
-# Memory Technology Devices (MTD)
-#
-# CONFIG_MTD is not set
-
-#
-# Parallel port support
-#
-# CONFIG_PARPORT is not set
-
-#
-# Plug and Play support
-#
-
-#
-# Block devices
-#
-# CONFIG_BLK_DEV_COW_COMMON is not set
-CONFIG_BLK_DEV_LOOP=y
-# CONFIG_BLK_DEV_CRYPTOLOOP is not set
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_COUNT=16
-CONFIG_BLK_DEV_RAM_SIZE=18432
-CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CDROM_PKTCDVD is not set
-
-#
-# Misc devices
-#
-
-#
-# ATA/ATAPI/MFM/RLL support
-#
-# CONFIG_IDE is not set
-
-#
-# SCSI device support
-#
-CONFIG_RAID_ATTRS=y
-# CONFIG_SCSI is not set
-# CONFIG_SCSI_NETLINK is not set
-
-#
-# Serial ATA (prod) and Parallel ATA (experimental) drivers
-#
-# CONFIG_ATA is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
-# CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
-# CONFIG_FUSION is not set
-
-#
-# IEEE 1394 (FireWire) support
-#
-
-#
-# I2O device support
-#
-
-#
-# ISDN subsystem
-#
-
-#
-# Telephony Support
-#
-# CONFIG_PHONE is not set
-
-#
-# Input device support
-#
-# CONFIG_INPUT is not set
-
-#
-# Hardware I/O ports
-#
-# CONFIG_SERIO is not set
-# CONFIG_GAMEPORT is not set
-
-#
-# Character devices
-#
-# CONFIG_VT is not set
-# CONFIG_SERIAL_NONSTANDARD is not set
-
-#
-# Serial drivers
-#
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
-CONFIG_SERIAL_8250_RUNTIME_UARTS=4
-# CONFIG_SERIAL_8250_EXTENDED is not set
-
-#
-# Non-8250 serial port support
-#
-CONFIG_SERIAL_CORE=y
-CONFIG_SERIAL_CORE_CONSOLE=y
-CONFIG_UNIX98_PTYS=y
-CONFIG_LEGACY_PTYS=y
-CONFIG_LEGACY_PTY_COUNT=256
-
-#
-# IPMI
-#
-# CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
-# CONFIG_WATCHDOG is not set
-# CONFIG_HW_RANDOM is not set
-# CONFIG_RTC is not set
-# CONFIG_GEN_RTC is not set
-# CONFIG_DTLK is not set
-# CONFIG_R3964 is not set
-# CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
-# CONFIG_TCG_TPM is not set
-
-#
-# I2C support
-#
-# CONFIG_I2C is not set
-
-#
-# SPI support
-#
-# CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
-
-#
-# Dallas's 1-wire bus
-#
-# CONFIG_W1 is not set
-
-#
-# Hardware Monitoring support
-#
-# CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
-
-#
-# Multimedia devices
-#
-# CONFIG_VIDEO_DEV is not set
-
-#
-# Digital Video Broadcasting Devices
-#
-
-#
-# Graphics support
-#
-# CONFIG_FIRMWARE_EDID is not set
-# CONFIG_FB is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
-
-#
-# Sound
-#
-# CONFIG_SOUND is not set
-
-#
-# USB support
-#
-# CONFIG_USB_ARCH_HAS_HCD is not set
-# CONFIG_USB_ARCH_HAS_OHCI is not set
-# CONFIG_USB_ARCH_HAS_EHCI is not set
-
-#
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
-#
-
-#
-# USB Gadget Support
-#
-# CONFIG_USB_GADGET is not set
-
-#
-# MMC/SD Card support
-#
-# CONFIG_MMC is not set
-
-#
-# LED devices
-#
-# CONFIG_NEW_LEDS is not set
-
-#
-# LED drivers
-#
-
-#
-# LED Triggers
-#
-
-#
-# InfiniBand support
-#
-
-#
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
-#
-
-#
-# Real Time Clock
-#
-# CONFIG_RTC_CLASS is not set
-
-#
-# DMA Engine support
-#
-# CONFIG_DMA_ENGINE is not set
-
-#
-# DMA Clients
-#
-
-#
-# DMA Devices
-#
-
-#
-# Auxiliary Display support
-#
-
-#
-# Virtualization
-#
-
-#
-# File systems
-#
-CONFIG_EXT2_FS=y
-# CONFIG_EXT2_FS_XATTR is not set
-# CONFIG_EXT2_FS_XIP is not set
-# CONFIG_EXT3_FS is not set
-# CONFIG_EXT4DEV_FS is not set
-# CONFIG_REISERFS_FS is not set
-# CONFIG_JFS_FS is not set
-# CONFIG_FS_POSIX_ACL is not set
-# CONFIG_XFS_FS is not set
-# CONFIG_GFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
-CONFIG_INOTIFY=y
-CONFIG_INOTIFY_USER=y
-# CONFIG_QUOTA is not set
-CONFIG_DNOTIFY=y
-# CONFIG_AUTOFS_FS is not set
-# CONFIG_AUTOFS4_FS is not set
-CONFIG_FUSE_FS=y
-
-#
-# CD-ROM/DVD Filesystems
-#
-# CONFIG_ISO9660_FS is not set
-# CONFIG_UDF_FS is not set
-
-#
-# DOS/FAT/NT Filesystems
-#
-# CONFIG_MSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
-# CONFIG_NTFS_FS is not set
-
-#
-# Pseudo filesystems
-#
-CONFIG_PROC_FS=y
-CONFIG_PROC_KCORE=y
-CONFIG_PROC_SYSCTL=y
-CONFIG_SYSFS=y
-# CONFIG_TMPFS is not set
-# CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
-# CONFIG_CONFIGFS_FS is not set
-
-#
-# Miscellaneous filesystems
-#
-# CONFIG_ADFS_FS is not set
-# CONFIG_AFFS_FS is not set
-# CONFIG_HFS_FS is not set
-# CONFIG_HFSPLUS_FS is not set
-# CONFIG_BEFS_FS is not set
-# CONFIG_BFS_FS is not set
-# CONFIG_EFS_FS is not set
-# CONFIG_CRAMFS is not set
-# CONFIG_VXFS_FS is not set
-# CONFIG_HPFS_FS is not set
-# CONFIG_QNX4FS_FS is not set
-# CONFIG_SYSV_FS is not set
-# CONFIG_UFS_FS is not set
-
-#
-# Partition Types
-#
-CONFIG_PARTITION_ADVANCED=y
-# CONFIG_ACORN_PARTITION is not set
-# CONFIG_OSF_PARTITION is not set
-# CONFIG_AMIGA_PARTITION is not set
-# CONFIG_ATARI_PARTITION is not set
-# CONFIG_MAC_PARTITION is not set
-# CONFIG_MSDOS_PARTITION is not set
-# CONFIG_LDM_PARTITION is not set
-# CONFIG_SGI_PARTITION is not set
-# CONFIG_ULTRIX_PARTITION is not set
-# CONFIG_SUN_PARTITION is not set
-# CONFIG_KARMA_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
-
-#
-# Native Language Support
-#
-# CONFIG_NLS is not set
-
-#
-# Profiling support
-#
-# CONFIG_PROFILING is not set
-
-#
-# Kernel hacking
-#
-CONFIG_TRACE_IRQFLAGS_SUPPORT=y
-# CONFIG_PRINTK_TIME is not set
-CONFIG_ENABLE_MUST_CHECK=y
-# CONFIG_MAGIC_SYSRQ is not set
-# CONFIG_UNUSED_SYMBOLS is not set
-# CONFIG_DEBUG_FS is not set
-# CONFIG_HEADERS_CHECK is not set
-# CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_CROSSCOMPILE=y
-CONFIG_CMDLINE=""
-
-#
-# Security options
-#
-# CONFIG_KEYS is not set
-# CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
-# CONFIG_CRYPTO is not set
-
-#
-# Library routines
-#
-# CONFIG_CRC_CCITT is not set
-CONFIG_CRC16=y
-# CONFIG_CRC32 is not set
-# CONFIG_LIBCRC32C is not set
-CONFIG_PLIST=y
-CONFIG_HAS_IOMEM=y
-CONFIG_HAS_IOPORT=y
diff --git a/arch/mips/mips-boards/generic/console.c b/arch/mips/mips-boards/generic/console.c
index 202fcee..17a2a0a 100644
--- a/arch/mips/mips-boards/generic/console.c
+++ b/arch/mips/mips-boards/generic/console.c
@@ -22,21 +22,8 @@
 #include <linux/serial_reg.h>
 #include <asm/io.h>
 
-#ifdef CONFIG_MIPS_SEAD
-
-#include <asm/mips-boards/sead.h>
-
-#ifdef CONFIG_CPU_LITTLE_ENDIAN
-#define PORT(offset) (SEAD_UART0_REGS_BASE     + ((offset)<<3))
-#else
-#define PORT(offset) (SEAD_UART0_REGS_BASE + 3 + ((offset)<<3))
-#endif
-
-#else
-
 #define PORT(offset) (0x3f8 + (offset))
 
-#endif
 
 static inline unsigned int serial_in(int offset)
 {
diff --git a/arch/mips/mips-boards/generic/init.c b/arch/mips/mips-boards/generic/init.c
index d6436a6..c110490 100644
--- a/arch/mips/mips-boards/generic/init.c
+++ b/arch/mips/mips-boards/generic/init.c
@@ -249,9 +249,6 @@ void __init prom_init(void)
 
 	mips_display_message("LINUX");
 
-#ifdef CONFIG_MIPS_SEAD
-	set_io_port_base(KSEG1);
-#else
 	/*
 	 * early setup of _pcictrl_bonito so that we can determine
 	 * the system controller on a CORE_EMUL board
@@ -396,7 +393,7 @@ void __init prom_init(void)
 		mips_display_message("SC Error");
 		while (1);   /* We die here... */
 	}
-#endif
+
 	board_nmi_handler_setup = mips_nmi_setup;
 	board_ejtag_handler_setup = mips_ejtag_setup;
 
diff --git a/arch/mips/mips-boards/generic/reset.c b/arch/mips/mips-boards/generic/reset.c
index f9ae162..6a14da7 100644
--- a/arch/mips/mips-boards/generic/reset.c
+++ b/arch/mips/mips-boards/generic/reset.c
@@ -49,7 +49,5 @@ void mips_reboot_setup(void)
 {
 	_machine_restart = mips_machine_restart;
 	_machine_halt = mips_machine_halt;
-#if defined(CONFIG_MIPS_MALTA) || defined(CONFIG_MIPS_SEAD)
 	pm_power_off = mips_machine_halt;
-#endif
 }
diff --git a/arch/mips/mips-boards/generic/time.c b/arch/mips/mips-boards/generic/time.c
index d7fe97f..bd5021d 100644
--- a/arch/mips/mips-boards/generic/time.c
+++ b/arch/mips/mips-boards/generic/time.c
@@ -44,9 +44,6 @@
 #ifdef CONFIG_MIPS_MALTA
 #include <asm/mips-boards/maltaint.h>
 #endif
-#ifdef CONFIG_MIPS_SEAD
-#include <asm/mips-boards/seadint.h>
-#endif
 
 unsigned long cpu_khz;
 
@@ -174,13 +171,7 @@ static unsigned int __init estimate_cpu_frequency(void)
 	unsigned int prid = read_c0_prid() & 0xffff00;
 	unsigned int count;
 
-#if defined(CONFIG_MIPS_SEAD) || defined(CONFIG_MIPS_SIM)
-	/*
-	 * The SEAD board doesn't have a real time clock, so we can't
-	 * really calculate the timer frequency
-	 * For now we hardwire the SEAD board frequency to 12MHz.
-	 */
-
+#if defined(CONFIG_MIPS_SIM)
 	if ((prid == (PRID_COMP_MIPS | PRID_IMP_20KC)) ||
 	    (prid == (PRID_COMP_MIPS | PRID_IMP_25KF)))
 		count = 12000000;
diff --git a/arch/mips/mips-boards/sead/Makefile b/arch/mips/mips-boards/sead/Makefile
deleted file mode 100644
index 224bb84..0000000
--- a/arch/mips/mips-boards/sead/Makefile
+++ /dev/null
@@ -1,26 +0,0 @@
-#
-# Carsten Langgaard, carstenl@mips.com
-# Copyright (C) 2002 MIPS Technologies, Inc.  All rights reserved.
-#
-# ########################################################################
-#
-# This program is free software; you can distribute it and/or modify it
-# under the terms of the GNU General Public License (Version 2) as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
-#
-# #######################################################################
-#
-# Makefile for the MIPS SEAD specific kernel interface routines
-# under Linux.
-#
-
-obj-y		:= sead_int.o sead_setup.o
diff --git a/arch/mips/mips-boards/sead/sead_int.c b/arch/mips/mips-boards/sead/sead_int.c
deleted file mode 100644
index c4b9de3..0000000
--- a/arch/mips/mips-boards/sead/sead_int.c
+++ /dev/null
@@ -1,117 +0,0 @@
-/*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2002 MIPS Technologies, Inc.  All rights reserved.
- * Copyright (C) 2003 Ralf Baechle (ralf@linux-mips.org)
- * Copyright (C) 2004  Maciej W. Rozycki
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * Routines for generic manipulation of the interrupts found on the MIPS
- * Sead board.
- */
-#include <linux/init.h>
-#include <linux/interrupt.h>
-
-#include <asm/irq_cpu.h>
-#include <asm/mipsregs.h>
-#include <asm/system.h>
-
-#include <asm/mips-boards/seadint.h>
-
-static inline int clz(unsigned long x)
-{
-	__asm__ (
-	"	.set	push					\n"
-	"	.set	mips32					\n"
-	"	clz	%0, %1					\n"
-	"	.set	pop					\n"
-	: "=r" (x)
-	: "r" (x));
-
-	return x;
-}
-
-/*
- * Version of ffs that only looks at bits 12..15.
- */
-static inline unsigned int irq_ffs(unsigned int pending)
-{
-#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
-	return -clz(pending) + 31 - CAUSEB_IP;
-#else
-	unsigned int a0 = 7;
-	unsigned int t0;
-
-	t0 = s0 & 0xf000;
-	t0 = t0 < 1;
-	t0 = t0 << 2;
-	a0 = a0 - t0;
-	s0 = s0 << t0;
-
-	t0 = s0 & 0xc000;
-	t0 = t0 < 1;
-	t0 = t0 << 1;
-	a0 = a0 - t0;
-	s0 = s0 << t0;
-
-	t0 = s0 & 0x8000;
-	t0 = t0 < 1;
-	//t0 = t0 << 2;
-	a0 = a0 - t0;
-	//s0 = s0 << t0;
-
-	return a0;
-#endif
-}
-
-/*
- * IRQs on the SEAD board look basically are combined together on hardware
- * interrupt 0 (MIPS IRQ 2)) like:
- *
- *	MIPS IRQ	Source
- *      --------        ------
- *             0	Software (ignored)
- *             1        Software (ignored)
- *             2        UART0 (hw0)
- *             3        UART1 (hw1)
- *             4        Hardware (ignored)
- *             5        Hardware (ignored)
- *             6        Hardware (ignored)
- *             7        R4k timer (what we use)
- *
- * We handle the IRQ according to _our_ priority which is:
- *
- * Highest ----     R4k Timer
- * Lowest  ----     Combined hardware interrupt
- *
- * then we just return, if multiple IRQs are pending then we will just take
- * another exception, big deal.
- */
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
-	int irq;
-
-	irq = irq_ffs(pending);
-
-	if (irq >= 0)
-		do_IRQ(MIPSCPU_INT_BASE + irq);
-	else
-		spurious_interrupt();
-}
-
-void __init arch_init_irq(void)
-{
-	mips_cpu_irq_init();
-}
diff --git a/arch/mips/mips-boards/sead/sead_setup.c b/arch/mips/mips-boards/sead/sead_setup.c
deleted file mode 100644
index 811aba1..0000000
--- a/arch/mips/mips-boards/sead/sead_setup.c
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2002 MIPS Technologies, Inc.  All rights reserved.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * SEAD specific setup.
- */
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/ioport.h>
-#include <linux/tty.h>
-#include <linux/serial.h>
-#include <linux/serial_core.h>
-
-#include <asm/cpu.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/mips-boards/generic.h>
-#include <asm/mips-boards/prom.h>
-#include <asm/mips-boards/sead.h>
-#include <asm/mips-boards/seadint.h>
-#include <asm/time.h>
-
-extern void mips_reboot_setup(void);
-extern void mips_time_init(void);
-
-static void __init serial_init(void);
-
-const char *get_system_type(void)
-{
-	return "MIPS SEAD";
-}
-
-const char display_string[] = "        LINUX ON SEAD       ";
-
-void __init plat_mem_setup(void)
-{
-	ioport_resource.end = 0x7fffffff;
-
-	serial_init ();
-
-	board_time_init = mips_time_init;
-
-	mips_reboot_setup();
-}
-
-static void __init serial_init(void)
-{
-#ifdef CONFIG_SERIAL_8250
-	struct uart_port s;
-
-	memset(&s, 0, sizeof(s));
-
-#ifdef CONFIG_CPU_LITTLE_ENDIAN
-	s.iobase = SEAD_UART0_REGS_BASE;
-#else
-	s.iobase = SEAD_UART0_REGS_BASE+3;
-#endif
-	s.irq = MIPSCPU_INT_BASE + MIPSCPU_INT_UART0;
-	s.uartclk = SEAD_BASE_BAUD * 16;
-	s.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_AUTO_IRQ;
-	s.iotype = UPIO_PORT;
-	s.regshift = 3;
-
-	if (early_serial_setup(&s) != 0) {
-		printk(KERN_ERR "Serial setup failed!\n");
-	}
-#endif
-}
diff --git a/include/asm-mips/mips-boards/generic.h b/include/asm-mips/mips-boards/generic.h
index c8ebcc3..ab88e8c 100644
--- a/include/asm-mips/mips-boards/generic.h
+++ b/include/asm-mips/mips-boards/generic.h
@@ -27,12 +27,8 @@
 /*
  * Display register base.
  */
-#ifdef CONFIG_MIPS_SEAD
-#define ASCII_DISPLAY_POS_BASE     0x1f0005c0
-#else
 #define ASCII_DISPLAY_WORD_BASE    0x1f000410
 #define ASCII_DISPLAY_POS_BASE     0x1f000418
-#endif
 
 
 /*
@@ -44,13 +40,9 @@
 /*
  * Reset register.
  */
-#ifdef CONFIG_MIPS_SEAD
-#define SOFTRES_REG       0x1e800050
-#define GORESET           0x4d
-#else
 #define SOFTRES_REG       0x1f000500
 #define GORESET           0x42
-#endif
+
 
 /*
  * Revision register.
diff --git a/include/asm-mips/mips-boards/sead.h b/include/asm-mips/mips-boards/sead.h
deleted file mode 100644
index 68c69de..0000000
--- a/include/asm-mips/mips-boards/sead.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2002 MIPS Technologies, Inc.  All rights reserved.
- *
- * ########################################################################
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * ########################################################################
- *
- * Defines of the SEAD board specific address-MAP, registers, etc.
- *
- */
-#ifndef _MIPS_SEAD_H
-#define _MIPS_SEAD_H
-
-#include <asm/addrspace.h>
-
-/*
- * SEAD UART register base.
- */
-#define SEAD_UART0_REGS_BASE    (0x1f000800)
-#define SEAD_BASE_BAUD ( 3686400 / 16 )
-
-#endif /* !(_MIPS_SEAD_H) */
diff --git a/include/asm-mips/mips-boards/seadint.h b/include/asm-mips/mips-boards/seadint.h
deleted file mode 100644
index 4f6a393..0000000
--- a/include/asm-mips/mips-boards/seadint.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2002 MIPS Technologies, Inc.  All rights reserved.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * Defines for the SEAD interrupt controller.
- */
-#ifndef _MIPS_SEADINT_H
-#define _MIPS_SEADINT_H
-
-#include <irq.h>
-
-/*
- * Interrupts 0..7 are used for SEAD CPU interrupts
- */
-#define MIPSCPU_INT_BASE	MIPS_CPU_IRQ_BASE
-
-#define MIPSCPU_INT_UART0	2
-#define MIPSCPU_INT_UART1	3
-
-#define MIPSCPU_INT_CPUCTR	7
-
-#endif /* !(_MIPS_SEADINT_H) */
diff --git a/include/asm-mips/war.h b/include/asm-mips/war.h
index a37a237..0a0d7b9 100644
--- a/include/asm-mips/war.h
+++ b/include/asm-mips/war.h
@@ -131,7 +131,7 @@
  * Affects:
  *  MIPS 4K		RTL revision <3.0, PRID revision <4
  */
-#if defined(CONFIG_MIPS_MALTA) || defined(CONFIG_MIPS_SEAD)
+#if defined(CONFIG_MIPS_MALTA)
 #define MIPS4K_ICACHE_REFILL_WAR 1
 #endif
 
@@ -150,7 +150,7 @@
  *   MIPS 5Kc,5Kf	RTL revision <2.3, PRID revision <8
  *   MIPS 20Kc		RTL revision <4.0, PRID revision <?
  */
-#if defined(CONFIG_MIPS_MALTA) || defined(CONFIG_MIPS_SEAD)
+#if defined(CONFIG_MIPS_MALTA)
 #define MIPS_CACHE_SYNC_WAR 1
 #endif
 
-- 
1.5.2.1
