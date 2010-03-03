Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 11:11:38 +0100 (CET)
Received: from kuber.nabble.com ([216.139.236.158]:47126 "EHLO
        kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491836Ab0CCKLe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 11:11:34 +0100
Received: from isper.nabble.com ([192.168.236.156])
        by kuber.nabble.com with esmtp (Exim 4.63)
        (envelope-from <lists@nabble.com>)
        id 1NmlYB-0000tD-V1
        for linux-mips@linux-mips.org; Wed, 03 Mar 2010 02:11:31 -0800
Message-ID: <27766331.post@talk.nabble.com>
Date:   Wed, 3 Mar 2010 02:11:31 -0800 (PST)
From:   Dea_RU <dryukovz@mail.ru>
To:     linux-mips@linux-mips.org
Subject: TI AR7 7200 - no boot
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Nabble-From: dryukovz@mail.ru
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dryukovz@mail.ru
Precedence: bulk
X-list: linux-mips


I build kernel 2.6.33 for TI AR7 cpu 7200 version.

boot halt on console init stage/

gcc 4.3.3
==============================
linwork:/opt/mipsel32/usr/bin# ./mipsel-linux-gcc-4.3.3 -v
Using built-in specs.
Target: mipsel-uclibc-linux
Configured with:
/Acorp/buildroot-2010.02-rc1/output/toolchain/gcc-4.3.3/configure
--prefix=/usr --build=i386-cross-linux-uclibc --host=i386-cross-linux-uclibc
--target=mipsel-uclibc-linux --enable-languages=c,c++
--with-sysroot=/opt/mipsel32/
--with-build-time-tools=/opt/mipsel32//usr/mipsel-uclibc-linux/bin
--disable-__cxa_atexit --enable-target-optspace --with-gnu-ld
--disable-libssp --enable-tls --enable-shared
--with-gmp=/Acorp/buildroot-2010.02-rc1/output/toolchain/gmp
--with-mpfr=/Acorp/buildroot-2010.02-rc1/output/toolchain/mpfr --disable-nls
--enable-threads --disable-multilib --disable-decimal-float --with-abi=32
--with-tune=mips1 --disable-largefile --with-endian=little,big
--with-pkgversion='Buildroot 2010.02-rc1'
--with-bugurl=http://bugs.buildroot.net/ : (reconfigured)
/Acorp/buildroot-2010.02-rc1/output/toolchain/gcc-4.3.3/configure
--prefix=/usr --build=i386-cross-linux-uclibc --host=i386-cross-linux-uclibc
--target=mipsel-uclibc-linux --enable-languages=c,c++
--with-sysroot=/opt/mipsel32/
--with-build-time-tools=/opt/mipsel32//usr/mipsel-uclibc-linux/bin
--disable-__cxa_atexit --enable-target-optspace --with-gnu-ld
--disable-libssp --enable-tls --enable-shared
--with-gmp=/Acorp/buildroot-2010.02-rc1/output/toolchain/gmp
--with-mpfr=/Acorp/buildroot-2010.02-rc1/output/toolchain/mpfr --disable-nls
--enable-threads --disable-multilib --disable-decimal-float --with-abi=32
--with-tune=mips1 --disable-largefile --with-pkgversion='Buildroot
2010.02-rc1' --with-bugurl=http://bugs.buildroot.net/
Thread model: posix
gcc version 4.3.3 (Buildroot 2010.02-rc1)
===========
kernel cfg

CONFIG_MIPS=y

CONFIG_AR7=y
CONFIG_LOONGSON_UART_BASE=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_ARCH_SUPPORTS_OPROFILE=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
CONFIG_BOOT_RAW=y
CONFIG_CEVT_R4K_LIB=y
CONFIG_CEVT_R4K=y
CONFIG_CSRC_R4K_LIB=y
CONFIG_CSRC_R4K=y
CONFIG_DMA_NONCOHERENT=y
CONFIG_DMA_NEED_PCI_MAP_STATE=y
CONFIG_SYS_HAS_EARLY_PRINTK=y
CONFIG_GENERIC_GPIO=y
CONFIG_CPU_LITTLE_ENDIAN=y
CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
CONFIG_IRQ_CPU=y
CONFIG_NO_EXCEPT_FILL=y
CONFIG_SWAP_IO_SPACE=y
CONFIG_MIPS_L1_CACHE_SHIFT=5

CONFIG_CPU_MIPS32_R1=y
CONFIG_SYS_SUPPORTS_ZBOOT=y
CONFIG_SYS_SUPPORTS_ZBOOT_UART16550=y
CONFIG_SYS_HAS_CPU_MIPS32_R1=y
CONFIG_CPU_MIPS32=y
CONFIG_CPU_MIPSR1=y
CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
CONFIG_HARDWARE_WATCHPOINTS=y

CONFIG_32BIT=y
CONFIG_PAGE_SIZE_4KB=y
CONFIG_CPU_HAS_PREFETCH=y
CONFIG_MIPS_MT_DISABLED=y
CONFIG_CPU_HAS_SYNC=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_CPU_SUPPORTS_HIGHMEM=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ZONE_DMA_FLAG=0
CONFIG_VIRT_TO_BUS=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
CONFIG_HZ_250=y
CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
CONFIG_HZ=250
CONFIG_PREEMPT_NONE=y
CONFIG_SECCOMP=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_CONSTRUCTORS=y

# General setup
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_KERNEL_LZMA=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y

# RCU Subsystem
CONFIG_TINY_RCU=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_GROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_USER_SCHED=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_EMBEDDED=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y

# Kernel Performance Events And Counters
CONFIG_SLAB=y
CONFIG_HAVE_OPROFILE=y

# GCOV-based kernel profiling
CONFIG_SLOW_WORK=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_INLINE_SPIN_UNLOCK=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y

# Bus options (PCI, PCMCIA, EISA, ISA, TC)
CONFIG_MMU=y

# Executable file formats
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_TRAD_SIGNALS=y

# Power management options
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y

# Device Drivers

# Generic Driver Options
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_MTD=y
CONFIG_MTD_DEBUG=y
CONFIG_MTD_DEBUG_VERBOSE=0
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_CONCAT is not set
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_AR7_PARTS=y

# RAM/ROM/Flash chip drivers
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y

# Input device support
CONFIG_INPUT=y

# Character devices
CONFIG_VT=y
CONFIG_HW_CONSOLE=y

# Serial drivers
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=2
CONFIG_SERIAL_8250_RUNTIME_UARTS=2


# Non-8250 serial port support
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

# PPS support
CONFIG_PPS=y
CONFIG_PPS_DEBUG=y
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_NOWAYOUT=y

# Watchdog Device Drivers
CONFIG_AR7_WDT=y
CONFIG_SSB_POSSIBLE=y

# Console display driver support
CONFIG_DUMMY_CONSOLE=y
CONFIG_ACCESSIBILITY=y
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_DEBUG=y

# RTC interfaces
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
CONFIG_RTC_DRV_TEST=y


# on-CPU RTC drivers
CONFIG_AUXDISPLAY=y
CONFIG_UIO=y

# TI VLYNQ
CONFIG_VLYNQ=y
CONFIG_STAGING=y
CONFIG_STAGING_EXCLUDE_BUILD=y

# File systems
CONFIG_FILE_LOCKING=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y

# Caches
CONFIG_FSCACHE=y
CONFIG_FSCACHE_DEBUG=y

# Pseudo filesystems
CONFIG_PROC_FS=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_SYSFS=y

# Kernel hacking
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_SUPPORT=y
CONFIG_HAVE_ARCH_KGDB=y
CONFIG_EARLY_PRINTK=y
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="earlyprintk=ttyS0,9600n,keep"

# Security options
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=y

# Crypto core or helper
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_PCOMP=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_WORKQUEUE=y

# Hash modes
CONFIG_CRYPTO_HMAC=y

# Digest
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y

# Ciphers
CONFIG_CRYPTO_AES=y

# Compression
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_ZLIB=y
CONFIG_CRYPTO_LZO=y

# Library routines
CONFIG_BITREVERSE=y
CONFIG_GENERIC_FIND_LAST_BIT=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y
CONFIG_NLATTR=y
===========

booting process:

===========
(psbl) 

Booting...
Linux version 2.6.33 (root@linwork) (gcc version 4.3.3 (Buildroot
2010.02-rc1) ) #1 Wed Mar 3 15:31:18 OMST 2010
bootconsole [early0] enabled
CPU revision is: 00018448 (MIPS 4KEc)
TI AR7 (TNETD7200), ID: 0x002b, Revision: 0x11
Determined physical RAM map:
 memory: 01000000 @ 14000000 (usable)
Zone PFN ranges:
  Normal   0x00014000 -> 0x00015000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00014000 -> 0x00015000
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line:  console=ttyS0,9600n8 earlyprintk=ttyS0,9600
PID hash table entries: 64 (order: -4, 256 bytes)
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Primary instruction cache 16kB, VIPT, 4-way, linesize 16 bytes.
Primary data cache 8kB, 4-way, VIPT, no aliases, linesize 16 bytes
Memory: 13164k/16384k available (1325k kernel code, 3220k reserved, 408k
data, 120k init, 0k highmem)
NR_IRQS:256
Console: colour dummy device 80x25

==============

stop booting...

what wrong ????

kernels from open-wrt booting with log:
==============================
(psbl) 

Booting...
Linux version 2.6.26.8 (agb@arrakis) (gcc version 4.1.2) #1 Wed Dec 2
15:14:35 UTC 2009
console [early0] enabled
CPU revision is: 00018448 (MIPS 4KEc)
Clocks: Sync 2:1 mode
Clocks: Setting CPU clock
Adjusted requested frequency 211000000 to 211968000
Clocks: base = 35328000, frequency = 211968000, prediv = 1, postdiv = 1,
postdiv2 = -1, mul = 6
Clocks: Setting DSP clock
Clocks: base = 25000000, frequency = 105984000, prediv = 1, postdiv = 2,
postdiv2 = 1, mul = 10
Clocks: Setting USB clock
Adjusted requested frequency 48000000 to 47863741
Clocks: base = 105984000, frequency = 48000000, prediv = 1, postdiv = 31,
postdiv2 = -1, mul = 14
TI AR7 (TNETD7200), ID: 0x002b, Revision: 0x11
Determined physical RAM map:
 memory: 01000000 @ 14000000 (usable)
Initrd not found or empty - disabling initrd
Zone PFN ranges:
  Normal      81920 ->    86016
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:    81920 ->    86016
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line: init=/etc/preinit rootfstype=squashfs,jffs2,
console=ttyS0,9600n8
Primary instruction cache 16kB, VIPT, 4-way, linesize 16 bytes.
Primary data cache 8kB, 4-way, VIPT, no aliases, linesize 16 bytes
PID hash table entries: 64 (order: 6, 256 bytes)
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 12560k/16384k available (2001k kernel code, 3824k reserved, 417k
data, 124k init, 0k highmem)
SLUB: Genslabs=6, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Mount-cache hash table entries: 512
net_namespace: 644 bytes
NET: Registered protocol family 16
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 512 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 512 bind 512)
TCP reno registered
NET: Registered protocol family 1
squashfs: version 3.0 (2006/03/15) Phillip Lougher
Registering mini_fo version $Id$
JFFS2 version 2.2. (NAND) (SUMMARY)  Â© 2001-2006 Red Hat, Inc.
msgmni has been set to 24
io scheduler noop registered
io scheduler deadline registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0x8610e00 (irq = 15) is a TI-AR7
-- 
View this message in context: http://old.nabble.com/TI-AR7-7200---no-boot-tp27766331p27766331.html
Sent from the linux-mips main mailing list archive at Nabble.com.
