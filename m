Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2006 16:44:59 +0100 (BST)
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:17116 "EHLO
	ch-smtp02.sth.basefarm.net") by ftp.linux-mips.org with ESMTP
	id S20039415AbWJXPox (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Oct 2006 16:44:53 +0100
Received: from c83-250-8-219.bredband.comhem.se ([83.250.8.219]:46677 helo=mail.ferretporn.se)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <creideiki+linux-mips@ferretporn.se>)
	id 1GcOSL-0004Hy-86; Tue, 24 Oct 2006 17:44:46 +0200
Received: from www.ferretporn.se (unknown [192.168.0.3])
	by mail.ferretporn.se (Postfix) with ESMTP id 84A81D24A;
	Tue, 24 Oct 2006 17:44:41 +0200 (CEST)
Received: from 136.163.203.3
        (SquirrelMail authenticated user creideiki)
        by www.ferretporn.se with HTTP;
        Tue, 24 Oct 2006 17:44:41 +0200 (CEST)
Message-ID: <6285.136.163.203.3.1161704681.squirrel@www.ferretporn.se>
In-Reply-To: <20061024140614.GB27800@linux-mips.org>
References: <200610212159.04965.creideiki+linux-mips@ferretporn.se>
    <20061022232316.GA19127@linux-mips.org>
    <20061023001947.GA10853@linux-mips.org>
    <200610232330.23498.creideiki+linux-mips@ferretporn.se>
    <20061023224318.GA1732@linux-mips.org>
    <53979.136.163.203.3.1161698036.squirrel@www.ferretporn.se>
    <20061024140614.GB27800@linux-mips.org>
Date:	Tue, 24 Oct 2006 17:44:41 +0200 (CEST)
Subject: Re: Extreme system overhead on large IP27
From:	"Karl-Johan Karlsson" <creideiki+linux-mips@ferretporn.se>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.8
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Scan-Result: No virus found in message 1GcOSL-0004Hy-86.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1GcOSL-0004Hy-86 08bfb2c52c73bebdbb38b7e32e51f658
Return-Path: <creideiki+linux-mips@ferretporn.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: creideiki+linux-mips@ferretporn.se
Precedence: bulk
X-list: linux-mips

On Tue, October 24, 2006 16:06, Ralf Baechle wrote:
> On Tue, Oct 24, 2006 at 03:53:56PM +0200, Karl-Johan Karlsson wrote:
>> This is still on the Gentoo 2.6.17.10 kernel, by the way (which is a
>> mips-git snapshot from 2006-06-18 plus extra patches from e.g.
>> <URL:http://ftp.du.se/pub/os/gentoo/distfiles/mips-sources-generic_patches-1.25.tar.bz2>).
>> I tried a git snapshot from earlier today, but the only thing that
>> kernel
>> did was print the NUMA-link topology and then hang.
>
> To use the linux-mips.org git kernel you also need my IP27 patchset
> available from /pub/linux/mips/people/ralf/ip27/ on ftp.linux-mips.org.

That at least made it boot. Problems:

1. System overhead is still there, still 20-30% per CPU when building a
kernel with "make -j4" with 4 CPU:s enabled.

2. Timekeeping is broken. The clock in /proc/driver/rtc seems correct, but
the system clock advances at about 1/16 of real time.

   # zcat /proc/config.gz | grep HZ | grep -v ^#
   CONFIG_HZ_250=y
   CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
   CONFIG_HZ=250
   # zcat /proc/config.gz | grep RTC | grep -v ^#
   CONFIG_RTC=y
   CONFIG_SGI_IP27_RTC=y

3. When booting, the kernel started, did a bit of initialization,
restarted, and did everything all over again, this time going all the way.

   Loading dksc(0,1,8)/vmlinux...
   Reading 3659336 bytes... OK.
   Entering kernel.
   [17179569.184000] Linux version 2.6.19-rc3 (root@viggen) (gcc version
4.1.1 (Gentoo 4.1.1)) #2 SMP Tue Oct 24 16:49:51 CEST 2006
   [17179569.184000] ARCH: SGI-IP27
   [17179569.184000] PROMLIB: ARC firmware Version 64 Revision 0
   [17179569.184000] Discovered 8 cpus on 4 nodes
   [17179569.184000] ************** Topology ********************
   [17179569.184000]     00 01 02 03
   [17179569.184000] 00   0  1  2  2
   [17179569.184000] 01   1  0  2  2
   [17179569.184000] 02   2  2  0  1
   [17179569.184000] 03   2  2  1  0
   [17179569.184000] Router 0: 1 0 r
   [17179569.184000] Router 1: 3 2 r
   [17179569.184000] CPU revision is: 00000e23
   [17179569.184000] FPU revision is: 00000900
   [17179569.184000] IP27: Running on node 0.
   [17179569.184000] Node 0 has a primary CPU, CPU is running.
   [17179569.184000] Node 0 has a secondary CPU, CPU is running.
   [17179569.184000] Machine is in M mode.
   [17179569.184000] Cpu 0, Nasid 0x0: partnum 0x0 is is xbow
   [17179569.184000] Cpu 0, Nasid 0x0, widget 0x8 (partnum 0xc002) is a
bridge
   [17179569.184000] Bridge SSRAM size 1kB
   [17179569.184000] b_even_resp: 0000ba98
   [17179569.184000] b_odd_resp: 0000ba98
   [17179569.184000] Cpu 0, Nasid 0x0, widget 0xe (partnum 0xc002) is a
bridge
   [17179569.184000] Bridge SSRAM size 1kB
   [17179569.184000] b_even_resp: 0000ba98
   [17179569.184000] b_odd_resp: 0000ba98
   [17179569.184000] CPU 0 clock is 300MHz.
   [17179569.184000] Determined physical RAM map:
   [17179569.184000] REPLICATION: ON nasid 0, ktext from nasid 0, kdata
from nasid 0
   [17179569.184000] REPLICATION: ON nasid 1, ktext from nasid 0, kdata
from nasid 0
   [17179569.184000] REPLICATION: ON nasid 2, ktext from nasid 0, kdata
from nasid 0
   [17179569.184000] REPLICATION: ON nasid 3, ktext from nasid 0, kdata
from nasid 0
   [17179569.184000] Built 4 zonelists.  Total pages: 1551360
   [17179569.184000] Kernel command line: root=/dev/md2 append console=ttyS0
   [17179569.184000] Primary instruction cache 32kB, physically tagged,
2-way, linesize 64 bytes.
   [17179569.184000] Primary data cache 32kB, 2-way, linesize 32 bytes.
   [17179569.184000] Unified secondary cache 8192kB 2-way, linesize 128
bytes.
   [17179569.184000] Virtual address space probed at 44 bits
   [17179569.184000] Physical address space probed at 40 bits
   [17179569.184000] Synthesized TLB refill handler (41 instructions).
   [17179569.184000] Synthesized TLB load handler fastpath (55 instructions).
   [17179569.184000] Synthesized TLB store handler fastpath (55
instructions).
   [17179569.184000] Synthesized TLB modify handler fastpath (54
instructions).
   [17179569.184000] PID hash table entries: 4096 (order: 12, 32768 bytes)
   [17179569.184000] Using 1.250 MHz high precision timer.
   [17179569.184000] Linux version 2.6.19-rc3 (root@viggen) (gcc version
4.1.1 (Gentoo 4.1.1)) #2 SMP Tue Oct 24 16:49:51 CEST 2006
   [17179569.184000] ARCH: SGI-IP27
   [17179569.184000] PROMLIB: ARC firmware Version 64 Revision 0
   [17179569.184000] Discovered 8 cpus on 4 nodes
   [17179569.184000] ************** Topology ********************
   [17179569.184000]     00 01 02 03
   [17179569.184000] 00   0  1  2  2
   [17179569.184000] 01   1  0  2  2
   [17179569.184000] 02   2  2  0  1
   [17179569.184000] 03   2  2  1  0
   [17179569.184000] Router 0: 1 0 r
   [17179569.184000] Router 1: 3 2 r
   [17179569.184000] CPU revision is: 00000e23
   [17179569.184000] FPU revision is: 00000900
   [17179569.184000] IP27: Running on node 0.
   [17179569.184000] Node 0 has a primary CPU, CPU is running.
   [17179569.184000] Node 0 has a secondary CPU, CPU is running.
   [17179569.184000] Machine is in M mode.
   [17179569.184000] Cpu 0, Nasid 0x0: partnum 0x0 is is xbow
   [17179569.184000] Cpu 0, Nasid 0x0, widget 0x8 (partnum 0xc002) is a
bridge
   [17179569.184000] Bridge SSRAM size 1kB
   [17179569.184000] b_even_resp: 0000ba98
   [17179569.184000] b_odd_resp: 0000ba98
   [17179569.184000] Cpu 0, Nasid 0x0, widget 0xe (partnum 0xc002) is a
bridge
   [17179569.184000] Bridge SSRAM size 1kB
   [17179569.184000] b_even_resp: 0000ba98
   [17179569.184000] b_odd_resp: 0000ba98
   [17179569.184000] CPU 0 clock is 300MHz.
   [17179569.184000] Determined physical RAM map:
   [17179569.184000] REPLICATION: ON nasid 0, ktext from nasid 0, kdata
from nasid 0
   [17179569.184000] REPLICATION: ON nasid 1, ktext from nasid 0, kdata
from nasid 0
   [17179569.184000] REPLICATION: ON nasid 2, ktext from nasid 0, kdata
from nasid 0
   [17179569.184000] REPLICATION: ON nasid 3, ktext from nasid 0, kdata
from nasid 0
   [17179569.184000] Built 4 zonelists.  Total pages: 1551360
   [17179569.184000] Kernel command line: root=/dev/md2 append console=ttyS0
   [17179569.184000] Primary instruction cache 32kB, physically tagged,
2-way, linesize 64 bytes.
   [17179569.184000] Primary data cache 32kB, 2-way, linesize 32 bytes.
   [17179569.184000] Unified secondary cache 8192kB 2-way, linesize 128
bytes.
   [17179569.184000] Virtual address space probed at 44 bits
   [17179569.184000] Physical address space probed at 40 bits
   [17179569.184000] Synthesized TLB refill handler (41 instructions).
   [17179569.184000] Synthesized TLB load handler fastpath (55 instructions).
   [17179569.184000] Synthesized TLB store handler fastpath (55
instructions).
   [17179569.184000] Synthesized TLB modify handler fastpath (54
instructions).
   [17179569.184000] PID hash table entries: 4096 (order: 12, 32768 bytes)
   [17179569.184000] Using 1.250 MHz high precision timer.
   [17179569.260000] Dentry cache hash table entries: 1048576 (order: 11,
8388608 bytes)
   [17179569.332000] Inode-cache hash table entries: 524288 (order: 10,
4194304 bytes)
   [17179571.216000] Memory: 4091192k/4194304k available (2492k kernel
code, 103112k reserved, 850k data, 232k init, 0k highmem)
   [...]


# zcat /proc/config.gz | grep -v ^# | grep .
CONFIG_MIPS=y
CONFIG_SGI_IP27=y
CONFIG_SGI_SN_M_MODE=y
CONFIG_EARLY_PRINTK=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_TIME=y
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
CONFIG_ARC=y
CONFIG_DMA_IP27=y
CONFIG_CPU_BIG_ENDIAN=y
CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
CONFIG_MIPS_L1_CACHE_SHIFT=7
CONFIG_ARC64=y
CONFIG_BOOT_ELF64=y
CONFIG_CPU_R10000=y
CONFIG_SYS_HAS_CPU_R10000=y
CONFIG_SYS_SUPPORTS_64BIT_KERNEL=y
CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
CONFIG_64BIT=y
CONFIG_PAGE_SIZE_4KB=y
CONFIG_CPU_HAS_PREFETCH=y
CONFIG_MIPS_MT_DISABLED=y
CONFIG_CPU_HAS_LLSC=y
CONFIG_CPU_HAS_SYNC=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_IRQ_PER_CPU=y
CONFIG_CPU_SUPPORTS_HIGHMEM=y
CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
CONFIG_NUMA=y
CONFIG_SYS_SUPPORTS_NUMA=y
CONFIG_NODES_SHIFT=6
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_DISCONTIGMEM_MANUAL=y
CONFIG_DISCONTIGMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MIGRATION=y
CONFIG_RESOURCES_64BIT=y
CONFIG_SMP=y
CONFIG_SYS_SUPPORTS_SMP=y
CONFIG_NR_CPUS=4
CONFIG_HZ_250=y
CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
CONFIG_HZ=250
CONFIG_PREEMPT_NONE=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_CPUSETS=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y
CONFIG_BLOCK=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_DEFAULT_AS=y
CONFIG_DEFAULT_IOSCHED="anticipatory"
CONFIG_HW_HAS_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_MMU=y
CONFIG_BINFMT_ELF=y
CONFIG_BUILD_ELF64=y
CONFIG_MIPS32_COMPAT=y
CONFIG_COMPAT=y
CONFIG_MIPS32_O32=y
CONFIG_BINFMT_ELF32=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_FIB_HASH=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_QLOGIC_1280=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID1=y
CONFIG_NETDEVICES=y
CONFIG_PHYLIB=y
CONFIG_MARVELL_PHY=y
CONFIG_DAVICOM_PHY=y
CONFIG_QSEMI_PHY=y
CONFIG_LXT_PHY=y
CONFIG_CICADA_PHY=y
CONFIG_VITESSE_PHY=y
CONFIG_SMSC_PHY=y
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_SGI_IOC3_ETH=y
CONFIG_SERIO=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_HW_RANDOM=y
CONFIG_RTC=y
CONFIG_SGI_IP27_RTC=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_FS_POSIX_ACL=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_AUTOFS4_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SGI_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=y
CONFIG_PROFILING=y
CONFIG_OPROFILE=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_PRINTK_TIME=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DEBUG_INFO=y
CONFIG_CMDLINE=""
CONFIG_CRC32=y
CONFIG_PLIST=y

-- 
Karl-Johan Karlsson
