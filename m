Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2006 22:12:34 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:10149 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S20038556AbWJLVMc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Oct 2006 22:12:32 +0100
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1GY7qu-0004Xe-Bw
	for linux-mips@linux-mips.org; Thu, 12 Oct 2006 17:12:28 -0400
Date:	Thu, 12 Oct 2006 17:12:28 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	linux-mips@linux-mips.org
Subject: qemu initrd and ide support
Message-ID: <20061012211228.GA17383@nevyn.them.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These patches for qemu let IDE and initrd work in the defconfig.
It seems to function - I was able to get as far as partitioning
the drive in the debian installer and the next time I started qemu
the new partitions were found.  But the installer hangs up trying
to format swap.

Of course, what would be really nice would be a PCI controller.
I'm not brave enough to try.

I'm not going to submit the qemu change until I have some better
evidence that it all works right (or someone else does).

-- 
Daniel Jacobowitz
CodeSourcery

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mips-qemu-ide-and-initrd.patch"

--- Makefile.target	(revision 151367)
+++ Makefile.target	(local)
@@ -350,8 +350,8 @@ VL_OBJS+= grackle_pci.o prep_pci.o unin_
 DEFINES += -DHAS_AUDIO
 endif
 ifeq ($(TARGET_ARCH), mips)
-VL_OBJS+= mips_r4k.o dma.o vga.o serial.o i8254.o i8259.o
-#VL_OBJS+= #ide.o pckbd.o fdc.o m48t59.o
+VL_OBJS+= mips_r4k.o dma.o vga.o serial.o i8254.o i8259.o ide.o
+#VL_OBJS+= #pckbd.o fdc.o m48t59.o
 endif
 ifeq ($(TARGET_BASE_ARCH), sparc)
 ifeq ($(TARGET_ARCH), sparc64)
--- hw/mips_r4k.c	(revision 151367)
+++ hw/mips_r4k.c	(local)
@@ -7,6 +7,10 @@
 
 #define VIRT_TO_PHYS_ADDEND (-0x80000000LL)
 
+static const int ide_iobase[2] = { 0x1f0, 0x170 };
+static const int ide_iobase2[2] = { 0x3f6, 0x376 };
+static const int ide_irq[2] = { 14, 15 };
+
 extern FILE *logfile;
 
 static PITState *pit;
@@ -117,7 +121,8 @@ void mips_r4k_init (int ram_size, int vg
     unsigned long bios_offset;
     int ret;
     CPUState *env;
-    long kernel_size;
+    long kernel_size, initrd_size;
+    int i;
 
     env = cpu_init();
     register_savevm("cpu", 0, 3, cpu_save, cpu_load, env);
@@ -158,21 +163,29 @@ void mips_r4k_init (int ram_size, int vg
 	}
 
         /* load initrd */
+        initrd_size = 0;
         if (initrd_filename) {
-            if (load_image(initrd_filename,
-			   phys_ram_base + INITRD_LOAD_ADDR + VIRT_TO_PHYS_ADDEND)
-		== (target_ulong) -1) {
+            initrd_size = load_image(initrd_filename,
+                                     phys_ram_base + INITRD_LOAD_ADDR + VIRT_TO_PHYS_ADDEND);
+            if (initrd_size == (target_ulong) -1) {
                 fprintf(stderr, "qemu: could not load initial ram disk '%s'\n", 
                         initrd_filename);
                 exit(1);
             }
         }
 
-	/* Store command line.  */
+        /* Store command line.  */
         strcpy (phys_ram_base + (16 << 20) - 256, kernel_cmdline);
         /* FIXME: little endian support */
-        *(int *)(phys_ram_base + (16 << 20) - 260) = tswap32 (0x12345678);
-        *(int *)(phys_ram_base + (16 << 20) - 264) = tswap32 (ram_size);
+        if (initrd_size > 0) {
+            *(int *)(phys_ram_base + (16 << 20) - 260) = tswap32 (0x12345679);
+            *(int *)(phys_ram_base + (16 << 20) - 264) = tswap32 (ram_size);
+            *(int *)(phys_ram_base + (16 << 20) - 268) = tswap32 (INITRD_LOAD_ADDR);
+            *(int *)(phys_ram_base + (16 << 20) - 272) = tswap32 (initrd_size);
+        } else {
+            *(int *)(phys_ram_base + (16 << 20) - 260) = tswap32 (0x12345678);
+            *(int *)(phys_ram_base + (16 << 20) - 264) = tswap32 (ram_size);
+        }
     }
 
     /* Init internal devices */
@@ -198,6 +211,10 @@ void mips_r4k_init (int ram_size, int vg
             exit (1);
         }
     }
+
+    for(i = 0; i < 2; i++)
+        isa_ide_init(ide_iobase[i], ide_iobase2[i], ide_irq[i],
+                     bs_table[2 * i], bs_table[2 * i + 1]);
 }
 
 QEMUMachine mips_machine = {

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mips-qemu-initrd-kernel.patch"

Update QEmu configuration for IDE, initrd, and basic functionality.
Also recognize the location of an initrd as provided by qemu.

diff --git a/arch/mips/configs/qemu_defconfig b/arch/mips/configs/qemu_defconfig
index 9b0dab8..d15de9f 100644
--- a/arch/mips/configs/qemu_defconfig
+++ b/arch/mips/configs/qemu_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc1
-# Thu Jul  6 10:04:18 2006
+# Linux kernel version: 2.6.19-rc1
+# Thu Oct 12 16:25:39 2006
 #
 CONFIG_MIPS=y
 
@@ -25,8 +25,6 @@ # CONFIG_BASLER_EXCITE is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MIPS_EV64120 is not set
-# CONFIG_MIPS_IVR is not set
-# CONFIG_MIPS_ITE8172 is not set
 # CONFIG_MACH_JAZZ is not set
 # CONFIG_LASAT is not set
 # CONFIG_MIPS_ATLAS is not set
@@ -67,6 +65,7 @@ CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_TIME=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_COHERENT=y
 CONFIG_GENERIC_ISA_DMA=y
@@ -74,6 +73,7 @@ CONFIG_I8259=y
 CONFIG_CPU_BIG_ENDIAN=y
 # CONFIG_CPU_LITTLE_ENDIAN is not set
 CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
+CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
 CONFIG_SWAP_IO_SPACE=y
 CONFIG_MIPS_L1_CACHE_SHIFT=5
 CONFIG_HAVE_STD_PC_SERIAL_PORT=y
@@ -117,8 +117,8 @@ # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
 CONFIG_MIPS_MT_DISABLED=y
-# CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_MT_SMP is not set
+# CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
 # CONFIG_64BIT_PHYS_ADDR is not set
 CONFIG_CPU_HAS_LLSC=y
@@ -130,7 +130,7 @@ CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
-# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPARSEMEM_STATIC=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 # CONFIG_HZ_48 is not set
@@ -162,28 +162,33 @@ #
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 # CONFIG_SWAP is not set
-# CONFIG_SYSVIPC is not set
+CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
-CONFIG_SYSCTL=y
+# CONFIG_TASKSTATS is not set
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_RELAY=y
 CONFIG_INITRAMFS_SOURCE=""
+CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
+# CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
-# CONFIG_HOTPLUG is not set
+CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
-# CONFIG_BUG is not set
+CONFIG_BUG=y
 CONFIG_ELF_CORE=y
-# CONFIG_BASE_FULL is not set
-# CONFIG_FUTEX is not set
-# CONFIG_EPOLL is not set
-# CONFIG_SHMEM is not set
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SHMEM=y
 CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_TINY_SHMEM=y
-CONFIG_BASE_SMALL=1
+CONFIG_RT_MUTEXES=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
 
 #
@@ -194,6 +199,7 @@ # CONFIG_MODULES is not set
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
@@ -268,10 +274,12 @@ # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
@@ -335,23 +343,55 @@ #
 # Block devices
 #
 # CONFIG_BLK_DEV_COW_COMMON is not set
-# CONFIG_BLK_DEV_LOOP is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_RAM is not set
-# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
 #
-# CONFIG_IDE is not set
+CONFIG_IDE=y
+CONFIG_IDE_MAX_HWIFS=4
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_BLK_DEV_IDEDISK=y
+CONFIG_IDEDISK_MULTI_MODE=y
+CONFIG_BLK_DEV_IDECD=y
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_IDE_GENERIC=y
+# CONFIG_IDE_ARM is not set
+# CONFIG_IDE_CHIPSETS is not set
+# CONFIG_BLK_DEV_IDEDMA is not set
+# CONFIG_IDEDMA_AUTO is not set
+# CONFIG_BLK_DEV_HD is not set
 
 #
 # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
+# CONFIG_SCSI_NETLINK is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
 
 #
 # Old CD-ROM drivers (not SCSI, not IDE)
@@ -459,6 +499,7 @@ #
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -565,7 +606,6 @@ #
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -585,6 +625,7 @@ CONFIG_VGA_CONSOLE=y
 # CONFIG_VGACON_SOFT_SCROLLBACK is not set
 # CONFIG_MDA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -654,13 +695,20 @@ #
 # File systems
 #
 # CONFIG_EXT2_FS is not set
-# CONFIG_EXT3_FS is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+CONFIG_ROMFS_FS=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
@@ -687,8 +735,10 @@ # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 
@@ -696,7 +746,7 @@ #
 # Miscellaneous filesystems
 #
 # CONFIG_HFSPLUS_FS is not set
-# CONFIG_CRAMFS is not set
+CONFIG_CRAMFS=y
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
@@ -709,6 +759,7 @@ #
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
@@ -717,7 +768,6 @@ CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
-# CONFIG_CIFS_DEBUG2 is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 
@@ -737,12 +787,14 @@ # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_DEBUG_FS is not set
 # CONFIG_UNWIND_INFO is not set
+# CONFIG_HEADERS_CHECK is not set
 CONFIG_CROSSCOMPILE=y
 CONFIG_CMDLINE=""
 
@@ -758,13 +810,11 @@ #
 # CONFIG_CRYPTO is not set
 
 #
-# Hardware crypto devices
-#
-
-#
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_PLIST=y
diff --git a/arch/mips/qemu/q-firmware.c b/arch/mips/qemu/q-firmware.c
index fb2a867..e1e77aa 100644
--- a/arch/mips/qemu/q-firmware.c
+++ b/arch/mips/qemu/q-firmware.c
@@ -12,6 +12,13 @@ void __init prom_init(void)
 		if (*(char *)(cmdline + 1))
 			strcpy (arcs_cmdline, (char *)(cmdline + 1));
 		add_memory_region(0x0<<20, cmdline[-1], BOOT_MEM_RAM);
+	} else if (*cmdline == 0x12345679) {
+		extern unsigned long initrd_start, initrd_end;
+		if (*(char *)(cmdline + 1))
+			strcpy (arcs_cmdline, (char *)(cmdline + 1));
+		add_memory_region(0x0<<20, cmdline[-1], BOOT_MEM_RAM);
+		initrd_start = cmdline[-2];
+		initrd_end = initrd_start + cmdline[-3];
 	} else {
 		add_memory_region(0x0<<20, 0x10<<20, BOOT_MEM_RAM);
 	}

--PEIAKu/WMn1b1Hv9--
