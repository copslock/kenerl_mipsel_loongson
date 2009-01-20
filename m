Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2009 03:39:52 +0000 (GMT)
Received: from el-out-1112.google.com ([209.85.162.180]:23469 "EHLO
	el-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S21365093AbZATDjt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Jan 2009 03:39:49 +0000
Received: by el-out-1112.google.com with SMTP id o28so856880ele.7
        for <multiple recipients>; Mon, 19 Jan 2009 19:39:47 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject:cc
         :message-id:from:date;
        bh=NURPsoG8Zmxtuf5W5nQudBA7vRsKrz+2RyHjDPqXk00=;
        b=oAq7cuuKW241vAlOewkGnFqUlS0V9Ez24DP7f5joqd7Mjv9h8Cr2PHzucWDIjf67N7
         qVG05SfBK9k4t9l/4AJRXJUf4RUOScFL/ZvZ1Quc1GZmwHq1G4Ayvv06DXCh7u20kTPz
         xQkcGmlisa5gZGDEyWzWgPIsyAvrQ98fWaeck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:cc:message-id:from:date;
        b=wQzfjhFOp+pbrD0XZ+flE20jgXvWQJ/nruG3aMgx1C+bhItUh4UeSXqXlZx8VD35Is
         qERuNrp4QWXKQJJidnweVrL0GHjOAybQdoBOWME2PAmpRoBQJ7Ot+ZEljayHwyAUo8Hi
         J7hFFt2L7Z+H6ykVahUYIXWKJE6P1b0zh2oAA=
Received: by 10.64.232.9 with SMTP id e9mr3106381qbh.13.1232422787534;
        Mon, 19 Jan 2009 19:39:47 -0800 (PST)
Received: from localhost (207-47-250-91.sktn.hsdb.sasknet.sk.ca [207.47.250.91])
        by mx.google.com with ESMTPS id 25sm11438415qbw.23.2009.01.19.19.39.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jan 2009 19:39:46 -0800 (PST)
Received: from shane by localhost with local (Exim 4.63)
	(envelope-from <shane@localhost>)
	id 1LP7Sp-0000fM-IR; Mon, 19 Jan 2009 21:39:43 -0600
To:	linux-mips@linux-mips.org
Subject: Panic on boot on RM7035C-based board with 2.6.29-rc2
Cc:	ralf@linux-mips.org
Message-Id: <E1LP7Sp-0000fM-IR@localhost>
From:	Shane McDonald <mcdonald.shane@gmail.com>
Date:	Mon, 19 Jan 2009 21:39:43 -0600
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

This past weekend, I updated my RM7035C-based board to 2.6.29-rc2,
and it now panics on boot.  It ran fine on 2.6.29-rc1.

My board is a PMC-Sierra Xiao Hu thin-client board
(http://www.linuxjournal.com/article/7854).  This board is not
currently supported in the mainline kernel, although I am slowly trying
to clean up the code to submit it for inclusion.  This board is based on
the ITE 8172 eval board, which was supported in kernels up
to and including 2.6.18.  The Xiao Hu board also serves as the
base of the Linksys NSS4000 NAS device.  My code was originally
based on the NSS4000 2.6.18-based BSP available on the Linksys website,
but has been stripped down and slightly cleaned up.

After running a git bisect, I found the panic was introduced in
commit a29b1ad4f45ce0db1d6ece289f334fe9528ae47b,
MIPS: Avoid destructive invalidation on partial cachelines.
Reversing the patch on 2.6.29-rc2 clears up the problem.

I'm not quite sure how to proceed with this, or if there's
a patch required to arch/mips/mm/c-r4k.c.  Any insights would be
appreciated.  I have included the output of my boot up to the point
of the panic.  I have also attached the start of my config, hopefully
including all relevant parts.

I thank you for any assistance I receive!

Shane McDonald
--
Board reset!..............rl0: address is 00:e0:04:00:20:ab

PMON version 1.2.3 [PMC,EL,FP,NET]
Algorithmics Ltd. Aug  8 2005 19:05:58
This is free software, and comes with ABSOLUTELY NO WARRANTY,
you are welcome to redistribute it without restriction.

CPLD id FFFFh, type FFh, ver FFh
Flash mfg 01h, id 7E2301h
CPU type RM7065.  Rev 5.3.  600 MHz/100 MHz.
Memory size 128 MB.
Icache size  16 KB, 32/line (4 way)
Dcache size  16 KB, 32/line (4 way)
Scache size 256 KB, 32/line (4 way)


PMON> boot 192.168.0.105:/shane/vmlinux-attempt29rc2
Loading file: 192.168.0.105:/shane/vmlinux-attempt29rc2 (elf)
0x80100000/5345172 + 0x80618f94/120892 
Entry address is 801043e0
PMON> g -- root=/dev/hda1 cca=3
Linux version 2.6.29-rc2-attempt-1 (shane@xiaohu) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 Sun Jan 18 08:26:04 CST 2009
memsize: 128
Memory size: 128MB
CPU revision is: 00002753 (RM7000)
FPU revision is: 00002750
Determined physical RAM map:
 memory: 08000000 @ 00000000 (usable)
Zone PFN ranges:
  DMA      0x00000000 -> 0x00001000
  Normal   0x00001000 -> 0x00008000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00008000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: mtdparts=phys_mapped_flash:128k(bootenv),11264k(linux),2048k(linuxrtconfig),-(rootfs) jffs2_orphaned_inodes=delete root=/dev/hda1 cca=3 console=ttyS0,115200
Primary instruction cache 16kB, VIPT, 4-way, linesize 32 bytes.
Primary data cache 16kB, 4-way, VIPT, no aliases, linesize 32 bytes
Secondary cache size 256K, linesize 32 bytes.
PID hash table entries: 512 (order: 9, 2048 bytes)
calculating r4koff... 00124f7f(1199999)
CPU frequency 600.00 MHz
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 123400k/131072k available (4067k kernel code, 7492k reserved, 997k data, 152k init, 0k highmem)
Calibrating delay loop... 598.01 BogoMIPS (lpj=1196032)
Mount-cache hash table entries: 512
net_namespace: 672 bytes
xor: measuring software checksum speed
   8regs     :   565.000 MB/sec
   8regs_prefetch:   504.000 MB/sec
   32regs    :   716.000 MB/sec
   32regs_prefetch:   621.000 MB/sec
xor: using function: 32regs (716.000 MB/sec)
NET: Registered protocol family 16
registering PCI controller with io_map_base unset
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
it8172 fixup: Resetting IDE adapter 0000:00:01.5
pci 0000:00:13.0: PME# supported from D1 D3hot
pci 0000:00:13.0: PME# disabled
pci 0000:00:13.1: PME# supported from D1 D3hot
pci 0000:00:13.1: PME# disabled
pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:13.2: PME# disabled
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
NET: Registered protocol family 1
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.29 [Flags: R/O].
SGI XFS with ACLs, security attributes, large block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
msgmni has been set to 241
alg: No test for stdrng (krng)
async_tx: api initialized (sync-only)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
it8172 fixup: Configuring IDE adapter 0000:00:01.5
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at I/O 0x14011800 (irq = 23) is a 16550A
console [ttyS0] enabled
loop: module loaded
8139too Fast Ethernet driver 0.9.28
eth0: RealTek RTL8139 at 0xb0105000, 00:e0:04:00:20:ab, IRQ 39
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Uniform Multi-Platform E-IDE driver
IT8172 0000:00:01.5: IDE controller (0x1283:0x8172 rev 0x01)
IT8172 0000:00:01.5: 100% native mode on irq 34
    ide0: BM-DMA at 0x14018cc0-0x14018cc7
hda: Maxtor 5T030H3, ATA DISK drive
hda: UDMA/33 mode selected
ide0 at 0x140179f0-0x140179f7,0x14017bf6 on irq 34
ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
ide_generic: I/O resource 0x1F0-0x1F7 not free.
ide_generic: I/O resource 0x170-0x177 not free.
ide-gd driver 1.18
hda: max request size: 128KiB
hda: 60030432 sectors (30735 MB) w/2048KiB Cache, CHS=59554/16/63
hda: cache flushes not supported
 hda:Unhandled kernel unaligned access or invalid instruction[#1]:
Cpu 0
$ 0   : 00000000 9004fc01 87975fff 00020000
$ 4   : 87975000 00001000 00000001 00000002
$ 8   : 00000001 00000000 00000008 0000c840
$12   : 3e007e00 00000020 8799a660 00000020
$16   : 87975000 00001000 00000002 00000000
$20   : 00000001 8798ec00 87985a00 878a1000
$24   : 00000000 803a068c                  
$28   : 8781e000 8781fa18 00000000 801156b8
Hi    : 0000012b
Lo    : 020f8000
epc   : 801184bc r4k_dma_cache_inv+0xcc/0x12c
    Not tainted
ra    : 801156b8 dma_map_sg+0xbc/0x110
Status: 9004fc03    KERNEL EXL IE 
Cause : 00000010
BadVA : 87975fff
PrId  : 00002753 (RM7000)
Process swapper (pid: 1, threadinfo=8781e000, task=8781da78, tls=00000000)
Stack : 87985a00 878a1000 00000000 8039da7c 87975000 8781b000 801156b8 878bb400
        87985a00 803a87e8 00000000 805e5220 a7984000 878a1000 00000002 878a1000
        00000000 803a8bc4 00000000 87985a00 8799b5f4 8798a980 00000008 87985a00
        00000002 878a1000 8798ec00 00000001 803a8df0 8799b5f4 8799b5f4 80354f88
        00001000 00000000 8798ec00 878a1000 8781fb00 8051af40 8051b230 803a5184
        ...
Call Trace:
[<801184bc>] r4k_dma_cache_inv+0xcc/0x12c
[<801156b8>] dma_map_sg+0xbc/0x110
[<803a8bc4>] ide_build_dmatable+0x3c/0x184
[<803a8df0>] ide_dma_setup+0x44/0x104
[<803a5184>] do_rw_taskfile+0x254/0x2a0
[<803ac4f8>] ide_do_rw_disk+0x29c/0x320
[<8039e95c>] do_ide_request+0x5c4/0x934
[<80349140>] generic_unplug_device+0x3c/0x64
[<8015bc88>] sync_page+0x58/0x70
[<8010a9d8>] __wait_on_bit_lock+0x7c/0x164
[<8015bbfc>] __lock_page+0x6c/0x80
[<8015c644>] read_cache_page_async+0x184/0x220
[<8015c6f4>] read_cache_page+0x14/0x74
[<801e573c>] read_dev_sector+0x44/0xbc
[<801e6424>] msdos_partition+0x80/0x6f0
[<801e60f8>] rescan_partitions+0x184/0x400
[<801bd754>] __blkdev_get+0x258/0x31c
[<801e5e9c>] register_disk+0xd4/0x160
[<8034f468>] add_disk+0xf0/0x154
[<803aaf44>] ide_gd_probe+0x148/0x19c
[<803918b4>] driver_probe_device+0x168/0x298
[<80391a54>] __driver_attach+0x70/0xa8
[<80390acc>] bus_for_each_dev+0x60/0xac
[<80391190>] bus_add_driver+0xcc/0x254
[<80391ca8>] driver_register+0xb4/0x158
[<8010c9fc>] __kprobes_text_end+0x64/0x1e0
[<805f35f0>] kernel_init+0x8c/0xfc
[<8010eb2c>] kernel_thread_helper+0x10/0x18


Code: bc950000  00851021  2442ffff <bc550000> 3c038062  90649157  00041823  00431024  02031824 
Kernel panic - not syncing: Attempted to kill init!

--
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.29-rc2
# Sun Jan 18 07:14:02 2009
#
CONFIG_MIPS=y

#
# Machine selection
#
CONFIG_ZONE_DMA=y
# CONFIG_MACH_ALCHEMY is not set
# CONFIG_BASLER_EXCITE is not set
# CONFIG_BCM47XX is not set
# CONFIG_MIPS_COBALT is not set
# CONFIG_MACH_DECSTATION is not set
# CONFIG_MACH_JAZZ is not set
# CONFIG_LASAT is not set
# CONFIG_LEMOTE_FULONG is not set
# CONFIG_MIPS_MALTA is not set
# CONFIG_MIPS_SIM is not set
# CONFIG_MACH_EMMA is not set
# CONFIG_MACH_VR41XX is not set
# CONFIG_NXP_STB220 is not set
# CONFIG_NXP_STB225 is not set
# CONFIG_PNX8550_JBS is not set
# CONFIG_PNX8550_STB810 is not set
# CONFIG_PMC_MSP is not set
CONFIG_PMC_XIAOHU=y
# CONFIG_PMC_YOSEMITE is not set
# CONFIG_SGI_IP22 is not set
# CONFIG_SGI_IP27 is not set
# CONFIG_SGI_IP28 is not set
# CONFIG_SGI_IP32 is not set
# CONFIG_SIBYTE_CRHINE is not set
# CONFIG_SIBYTE_CARMEL is not set
# CONFIG_SIBYTE_CRHONE is not set
# CONFIG_SIBYTE_RHONE is not set
# CONFIG_SIBYTE_SWARM is not set
# CONFIG_SIBYTE_LITTLESUR is not set
# CONFIG_SIBYTE_SENTOSA is not set
# CONFIG_SIBYTE_BIGSUR is not set
# CONFIG_SNI_RM is not set
# CONFIG_MACH_TX39XX is not set
# CONFIG_MACH_TX49XX is not set
# CONFIG_MIKROTIK_RB532 is not set
# CONFIG_WR_PPMC is not set
# CONFIG_CAVIUM_OCTEON_SIMULATOR is not set
# CONFIG_CAVIUM_OCTEON_REFERENCE_BOARD is not set
CONFIG_RWSEM_GENERIC_SPINLOCK=y
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_ARCH_SUPPORTS_OPROFILE=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
# CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
CONFIG_CEVT_R4K_LIB=y
CONFIG_CEVT_R4K=y
CONFIG_CSRC_R4K_LIB=y
CONFIG_CSRC_R4K=y
CONFIG_DMA_NONCOHERENT=y
CONFIG_DMA_NEED_PCI_MAP_STATE=y
# CONFIG_HOTPLUG_CPU is not set
# CONFIG_NO_IOPORT is not set
CONFIG_GENERIC_ISA_DMA=y
# CONFIG_CPU_BIG_ENDIAN is not set
CONFIG_CPU_LITTLE_ENDIAN=y
CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
CONFIG_IRQ_CPU=y
CONFIG_MIPS_L1_CACHE_SHIFT=5

#
# CPU selection
#
# CONFIG_CPU_LOONGSON2 is not set
# CONFIG_CPU_MIPS32_R1 is not set
# CONFIG_CPU_MIPS32_R2 is not set
# CONFIG_CPU_MIPS64_R1 is not set
# CONFIG_CPU_MIPS64_R2 is not set
# CONFIG_CPU_R3000 is not set
# CONFIG_CPU_TX39XX is not set
# CONFIG_CPU_VR41XX is not set
# CONFIG_CPU_R4300 is not set
# CONFIG_CPU_R4X00 is not set
# CONFIG_CPU_TX49XX is not set
# CONFIG_CPU_R5000 is not set
# CONFIG_CPU_R5432 is not set
# CONFIG_CPU_R5500 is not set
# CONFIG_CPU_R6000 is not set
# CONFIG_CPU_NEVADA is not set
# CONFIG_CPU_R8000 is not set
# CONFIG_CPU_R10000 is not set
CONFIG_CPU_RM7000=y
# CONFIG_CPU_RM9000 is not set
# CONFIG_CPU_SB1 is not set
# CONFIG_CPU_CAVIUM_OCTEON is not set
CONFIG_SYS_HAS_CPU_RM7000=y
CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
CONFIG_SYS_SUPPORTS_64BIT_KERNEL=y
CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y

#
# Kernel type
#
CONFIG_32BIT=y
# CONFIG_64BIT is not set
CONFIG_PAGE_SIZE_4KB=y
# CONFIG_PAGE_SIZE_8KB is not set
# CONFIG_PAGE_SIZE_16KB is not set
# CONFIG_PAGE_SIZE_64KB is not set
CONFIG_BOARD_SCACHE=y
CONFIG_RM7000_CPU_SCACHE=y
CONFIG_CPU_HAS_PREFETCH=y
CONFIG_MIPS_MT_DISABLED=y
# CONFIG_MIPS_MT_SMP is not set
# CONFIG_MIPS_MT_SMTC is not set
CONFIG_CPU_HAS_LLSC=y
CONFIG_CPU_HAS_SYNC=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_CPU_SUPPORTS_HIGHMEM=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_UNEVICTABLE_LRU=y
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
# CONFIG_HZ_48 is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_128 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_256 is not set
# CONFIG_HZ_1000 is not set
# CONFIG_HZ_1024 is not set
CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
CONFIG_HZ=250
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
# CONFIG_KEXEC is not set
CONFIG_SECCOMP=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
