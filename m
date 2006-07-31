Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jul 2006 03:01:33 +0100 (BST)
Received: from [202.99.27.194] ([202.99.27.194]:57063 "EHLO
	mail1.topsec.com.cn") by ftp.linux-mips.org with ESMTP
	id S8133918AbWGaCBX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Jul 2006 03:01:23 +0100
Received: from codingman ([192.168.83.211])
	by mail1.topsec.com.cn (MOS 3.7.3a-GA)
	with ESMTP id ASG16567 (AUTH wyb);
	Mon, 31 Jul 2006 09:51:12 +0800 (CST)
Message-ID: <000f01c6b444$e1e820e0$0100000a@codingman>
From:	<wyb@topsec.com.cn>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<macro@linux-mips.org>, <sskowron@ET.PUT.Poznan.PL>,
	<rsandifo@redhat.com>, <linux-mips@linux-mips.org>
References: <004001c6af95$14585900$0100000a@codingman> <20060725034424.GB22138@linux-mips.org>
Subject: Re: unmatched R_MIPS_HI16/LO16 on gcc 3.4.3
Date:	Mon, 31 Jul 2006 09:58:28 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000C_01C6B487.DF72B8A0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
X-Junkmail-Whitelist: YES (by domain whitelist at mail1.topsec.com.cn)
Return-Path: <wyb@topsec.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wyb@topsec.com.cn
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_000C_01C6B487.DF72B8A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Attachment is a testsuit. It costed me a week to make this testsuit.

If I added -mno-explicit-relocs -mno-split-addresses to makefile, this bug
disappeared. Is there any performance difference with and without these
flags ?

Thanks!

----- Original Message ----- 
From: "Ralf Baechle" <ralf@linux-mips.org>
To: <wyb@topsec.com.cn>
Cc: <macro@linux-mips.org>; <sskowron@ET.PUT.Poznan.PL>;
<rsandifo@redhat.com>; <linux-mips@linux-mips.org>
Sent: Tuesday, July 25, 2006 11:44 AM
Subject: Re: unmatched R_MIPS_HI16/LO16 on gcc 3.4.3


> On Tue, Jul 25, 2006 at 10:49:56AM +0800, wyb@topsec.com.cn wrote:
>
> > I met similar problem as Stanislaw Skowronek, but for gcc 3.4.3. I
created a
> > kernel module, when insmod, kernel reported "dangerous relocation". I
traced
> > the bug, found unmatched R_MIPS_HI16/LO16 in module's elf file, and
kernel
> > refused to relocate:
> > ...
> > 00015a5c  00039a05 R_MIPS_HI16       0000000c   tos_net_debug
> > 00015a68  00000204 R_MIPS_26         00000000   .text
> > 00015a64  00046005 R_MIPS_HI16       0006b598   arp_proxy_list
> > 00015a6c  00046006 R_MIPS_LO16       0006b598   arp_proxy_list
> > ...
> >
> > My problem arised when expression on tos_net_debug could be optimized
out,
> > it seemed like gcc optimized out the LO16, but left HI16.
> >
> > The original discussion on similar problem is at
> > http://www.linux-mips.org/archives/linux-mips/2005-05/msg00097.html
>
> Do you have a testcase, a kernel .config file to trigger this?
>
>   Ralf
>

------=_NextPart_000_000C_01C6B487.DF72B8A0
Content-Type: application/octet-stream;
	name="bug.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="bug.tgz"

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
dvT/pD8Bm3blsAAoAAA=

------=_NextPart_000_000C_01C6B487.DF72B8A0
Content-Type: application/octet-stream;
	name=".config"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename=".config"

#=0A=
# Automatically generated make config: don't edit=0A=
# Linux kernel version: 2.6.16.17=0A=
# Mon Jul 31 09:50:46 2006=0A=
#=0A=
CONFIG_MIPS=3Dy=0A=
=0A=
#=0A=
# Machine selection=0A=
#=0A=
# CONFIG_MIPS_MTX1 is not set=0A=
# CONFIG_MIPS_BOSPORUS is not set=0A=
# CONFIG_MIPS_PB1000 is not set=0A=
# CONFIG_MIPS_PB1100 is not set=0A=
# CONFIG_MIPS_PB1500 is not set=0A=
# CONFIG_MIPS_PB1550 is not set=0A=
# CONFIG_MIPS_PB1200 is not set=0A=
# CONFIG_MIPS_DB1000 is not set=0A=
# CONFIG_MIPS_DB1100 is not set=0A=
# CONFIG_MIPS_DB1500 is not set=0A=
# CONFIG_MIPS_DB1550 is not set=0A=
# CONFIG_MIPS_DB1200 is not set=0A=
# CONFIG_MIPS_MIRAGE is not set=0A=
# CONFIG_MIPS_COBALT is not set=0A=
# CONFIG_MACH_DECSTATION is not set=0A=
# CONFIG_MIPS_EV64120 is not set=0A=
# CONFIG_MIPS_EV96100 is not set=0A=
# CONFIG_MIPS_IVR is not set=0A=
# CONFIG_MIPS_ITE8172 is not set=0A=
# CONFIG_MACH_JAZZ is not set=0A=
# CONFIG_LASAT is not set=0A=
# CONFIG_MIPS_ATLAS is not set=0A=
# CONFIG_MIPS_MALTA is not set=0A=
# CONFIG_MIPS_SEAD is not set=0A=
# CONFIG_MIPS_SIM is not set=0A=
# CONFIG_MOMENCO_JAGUAR_ATX is not set=0A=
# CONFIG_MOMENCO_OCELOT is not set=0A=
# CONFIG_MOMENCO_OCELOT_3 is not set=0A=
# CONFIG_MOMENCO_OCELOT_C is not set=0A=
# CONFIG_MOMENCO_OCELOT_G is not set=0A=
# CONFIG_MIPS_XXS1500 is not set=0A=
# CONFIG_PNX8550_V2PCI is not set=0A=
# CONFIG_PNX8550_JBS is not set=0A=
# CONFIG_DDB5074 is not set=0A=
# CONFIG_DDB5476 is not set=0A=
# CONFIG_DDB5477 is not set=0A=
# CONFIG_MACH_VR41XX is not set=0A=
# CONFIG_PMC_YOSEMITE is not set=0A=
# CONFIG_QEMU is not set=0A=
# CONFIG_SGI_IP22 is not set=0A=
# CONFIG_SGI_IP27 is not set=0A=
# CONFIG_SGI_IP32 is not set=0A=
CONFIG_SIBYTE_BIGSUR=3Dy=0A=
# CONFIG_SIBYTE_SWARM is not set=0A=
# CONFIG_SIBYTE_SENTOSA is not set=0A=
# CONFIG_SIBYTE_RHONE is not set=0A=
# CONFIG_SIBYTE_CARMEL is not set=0A=
# CONFIG_SIBYTE_PTSWARM is not set=0A=
# CONFIG_SIBYTE_LITTLESUR is not set=0A=
# CONFIG_SIBYTE_CRHINE is not set=0A=
# CONFIG_SIBYTE_CRHONE is not set=0A=
# CONFIG_SNI_RM200_PCI is not set=0A=
# CONFIG_TOSHIBA_JMR3927 is not set=0A=
# CONFIG_TOSHIBA_RBTX4927 is not set=0A=
# CONFIG_TOSHIBA_RBTX4938 is not set=0A=
# CONFIG_RMI_PTR is not set=0A=
CONFIG_SIBYTE_BCM1x80=3Dy=0A=
CONFIG_SIBYTE_SB1xxx_SOC=3Dy=0A=
# CONFIG_CPU_SB1_PASS_1 is not set=0A=
# CONFIG_CPU_SB1_PASS_2_1250 is not set=0A=
# CONFIG_CPU_SB1_PASS_2_2 is not set=0A=
# CONFIG_CPU_SB1_PASS_4 is not set=0A=
# CONFIG_CPU_SB1_PASS_2_112x is not set=0A=
# CONFIG_CPU_SB1_PASS_3 is not set=0A=
# CONFIG_SIMULATION is not set=0A=
# CONFIG_SB1_CEX_ALWAYS_FATAL is not set=0A=
# CONFIG_SB1_CERR_STALL is not set=0A=
CONFIG_SIBYTE_CFE=3Dy=0A=
# CONFIG_SIBYTE_CFE_CONSOLE is not set=0A=
# CONFIG_SIBYTE_BUS_WATCHER is not set=0A=
# CONFIG_SIBYTE_SB1250_PROF is not set=0A=
# CONFIG_SIBYTE_TBPROF is not set=0A=
CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy=0A=
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy=0A=
CONFIG_DMA_COHERENT=3Dy=0A=
CONFIG_CPU_BIG_ENDIAN=3Dy=0A=
# CONFIG_CPU_LITTLE_ENDIAN is not set=0A=
CONFIG_SYS_SUPPORTS_BIG_ENDIAN=3Dy=0A=
CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=3Dy=0A=
CONFIG_SWAP_IO_SPACE=3Dy=0A=
CONFIG_BOOT_ELF32=3Dy=0A=
CONFIG_MIPS_L1_CACHE_SHIFT=3D5=0A=
=0A=
#=0A=
# CPU selection=0A=
#=0A=
# CONFIG_CPU_MIPS32_R1 is not set=0A=
# CONFIG_CPU_MIPS32_R2 is not set=0A=
# CONFIG_CPU_MIPS64_R1 is not set=0A=
# CONFIG_CPU_MIPS64_R2 is not set=0A=
# CONFIG_CPU_R3000 is not set=0A=
# CONFIG_CPU_TX39XX is not set=0A=
# CONFIG_CPU_VR41XX is not set=0A=
# CONFIG_CPU_R4300 is not set=0A=
# CONFIG_CPU_R4X00 is not set=0A=
# CONFIG_CPU_TX49XX is not set=0A=
# CONFIG_CPU_R5000 is not set=0A=
# CONFIG_CPU_R5432 is not set=0A=
# CONFIG_CPU_R6000 is not set=0A=
# CONFIG_CPU_NEVADA is not set=0A=
# CONFIG_CPU_R8000 is not set=0A=
# CONFIG_CPU_R10000 is not set=0A=
# CONFIG_CPU_RM7000 is not set=0A=
# CONFIG_CPU_RM9000 is not set=0A=
CONFIG_CPU_SB1=3Dy=0A=
# CONFIG_CPU_PHOENIX is not set=0A=
CONFIG_SYS_HAS_CPU_SB1=3Dy=0A=
CONFIG_SYS_SUPPORTS_32BIT_KERNEL=3Dy=0A=
CONFIG_SYS_SUPPORTS_64BIT_KERNEL=3Dy=0A=
CONFIG_CPU_SUPPORTS_32BIT_KERNEL=3Dy=0A=
CONFIG_CPU_SUPPORTS_64BIT_KERNEL=3Dy=0A=
=0A=
#=0A=
# Kernel type=0A=
#=0A=
CONFIG_32BIT=3Dy=0A=
# CONFIG_64BIT is not set=0A=
CONFIG_PAGE_SIZE_4KB=3Dy=0A=
# CONFIG_PAGE_SIZE_8KB is not set=0A=
# CONFIG_PAGE_SIZE_16KB is not set=0A=
# CONFIG_PAGE_SIZE_64KB is not set=0A=
# CONFIG_SIBYTE_DMA_PAGEOPS is not set=0A=
# CONFIG_MIPS_MT is not set=0A=
CONFIG_64BIT_PHYS_ADDR=3Dy=0A=
# CONFIG_CPU_ADVANCED is not set=0A=
CONFIG_CPU_HAS_LLSC=3Dy=0A=
CONFIG_CPU_HAS_SYNC=3Dy=0A=
CONFIG_GENERIC_HARDIRQS=3Dy=0A=
CONFIG_GENERIC_IRQ_PROBE=3Dy=0A=
CONFIG_CPU_SUPPORTS_HIGHMEM=3Dy=0A=
CONFIG_ARCH_FLATMEM_ENABLE=3Dy=0A=
CONFIG_SELECT_MEMORY_MODEL=3Dy=0A=
CONFIG_FLATMEM_MANUAL=3Dy=0A=
# CONFIG_DISCONTIGMEM_MANUAL is not set=0A=
# CONFIG_SPARSEMEM_MANUAL is not set=0A=
CONFIG_FLATMEM=3Dy=0A=
CONFIG_FLAT_NODE_MEM_MAP=3Dy=0A=
# CONFIG_SPARSEMEM_STATIC is not set=0A=
CONFIG_SPLIT_PTLOCK_CPUS=3D4=0A=
CONFIG_SMP=3Dy=0A=
CONFIG_NR_CPUS=3D32=0A=
# CONFIG_PREEMPT_NONE is not set=0A=
# CONFIG_PREEMPT_VOLUNTARY is not set=0A=
CONFIG_PREEMPT=3Dy=0A=
# CONFIG_PREEMPT_BKL is not set=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
CONFIG_LOCK_KERNEL=3Dy=0A=
CONFIG_INIT_ENV_ARG_LIMIT=3D32=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_LOCALVERSION=3D""=0A=
CONFIG_LOCALVERSION_AUTO=3Dy=0A=
CONFIG_SWAP=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
# CONFIG_POSIX_MQUEUE is not set=0A=
# CONFIG_BSD_PROCESS_ACCT is not set=0A=
CONFIG_SYSCTL=3Dy=0A=
# CONFIG_AUDIT is not set=0A=
# CONFIG_IKCONFIG is not set=0A=
# CONFIG_CPUSETS is not set=0A=
# CONFIG_BTLB_LOADER is not set=0A=
CONFIG_INITRAMFS_SOURCE=3D"./arch/mips/rmi/phoenix/initramfs_data.cpio"=0A=
CONFIG_INITRAMFS_ROOT_UID=3D0=0A=
CONFIG_INITRAMFS_ROOT_GID=3D0=0A=
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set=0A=
CONFIG_EMBEDDED=3Dy=0A=
# CONFIG_KALLSYMS is not set=0A=
CONFIG_HOTPLUG=3Dy=0A=
CONFIG_PRINTK=3Dy=0A=
CONFIG_BUG=3Dy=0A=
CONFIG_ELF_CORE=3Dy=0A=
CONFIG_BASE_FULL=3Dy=0A=
CONFIG_FUTEX=3Dy=0A=
CONFIG_EPOLL=3Dy=0A=
CONFIG_SHMEM=3Dy=0A=
CONFIG_CC_ALIGN_FUNCTIONS=3D0=0A=
CONFIG_CC_ALIGN_LABELS=3D0=0A=
CONFIG_CC_ALIGN_LOOPS=3D0=0A=
CONFIG_CC_ALIGN_JUMPS=3D0=0A=
CONFIG_SLAB=3Dy=0A=
# CONFIG_TINY_SHMEM is not set=0A=
CONFIG_BASE_SMALL=3D0=0A=
# CONFIG_SLOB is not set=0A=
CONFIG_OBSOLETE_INTERMODULE=3Dy=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODULE_UNLOAD=3Dy=0A=
CONFIG_MODULE_FORCE_UNLOAD=3Dy=0A=
CONFIG_OBSOLETE_MODPARM=3Dy=0A=
# CONFIG_MODVERSIONS is not set=0A=
# CONFIG_MODULE_SRCVERSION_ALL is not set=0A=
CONFIG_KMOD=3Dy=0A=
CONFIG_STOP_MACHINE=3Dy=0A=
=0A=
#=0A=
# Block layer=0A=
#=0A=
CONFIG_LBD=3Dy=0A=
=0A=
#=0A=
# IO Schedulers=0A=
#=0A=
CONFIG_IOSCHED_NOOP=3Dy=0A=
CONFIG_IOSCHED_AS=3Dy=0A=
CONFIG_IOSCHED_DEADLINE=3Dy=0A=
CONFIG_IOSCHED_CFQ=3Dy=0A=
CONFIG_DEFAULT_AS=3Dy=0A=
# CONFIG_DEFAULT_DEADLINE is not set=0A=
# CONFIG_DEFAULT_CFQ is not set=0A=
# CONFIG_DEFAULT_NOOP is not set=0A=
CONFIG_DEFAULT_IOSCHED=3D"anticipatory"=0A=
=0A=
#=0A=
# Bus options (PCI, PCMCIA, EISA, ISA, TC)=0A=
#=0A=
CONFIG_HW_HAS_PCI=3Dy=0A=
CONFIG_PCI=3Dy=0A=
CONFIG_PCI_DOMAINS=3Dy=0A=
CONFIG_PCI_LEGACY_PROC=3Dy=0A=
CONFIG_MMU=3Dy=0A=
=0A=
#=0A=
# PCCARD (PCMCIA/CardBus) support=0A=
#=0A=
# CONFIG_PCCARD is not set=0A=
=0A=
#=0A=
# PCI Hotplug Support=0A=
#=0A=
# CONFIG_HOTPLUG_PCI is not set=0A=
=0A=
#=0A=
# Executable file formats=0A=
#=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
# CONFIG_BINFMT_MISC is not set=0A=
CONFIG_TRAD_SIGNALS=3Dy=0A=
=0A=
#=0A=
# Networking=0A=
#=0A=
CONFIG_NET=3Dy=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
# CONFIG_NETDEBUG is not set=0A=
CONFIG_PACKET=3Dy=0A=
CONFIG_PACKET_MMAP=3Dy=0A=
CONFIG_UNIX=3Dy=0A=
CONFIG_XFRM=3Dy=0A=
CONFIG_XFRM_USER=3Dy=0A=
CONFIG_NET_KEY=3Dy=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
CONFIG_IP_ADVANCED_ROUTER=3Dy=0A=
CONFIG_ASK_IP_FIB_HASH=3Dy=0A=
# CONFIG_IP_FIB_TRIE is not set=0A=
CONFIG_IP_FIB_HASH=3Dy=0A=
CONFIG_IP_MULTIPLE_TABLES=3Dy=0A=
CONFIG_IP_ROUTE_MULTIPATH=3Dy=0A=
# CONFIG_IP_ROUTE_MULTIPATH_CACHED is not set=0A=
CONFIG_IP_ROUTE_VERBOSE=3Dy=0A=
CONFIG_IP_PNP=3Dy=0A=
CONFIG_IP_PNP_DHCP=3Dy=0A=
CONFIG_IP_PNP_BOOTP=3Dy=0A=
CONFIG_IP_PNP_RARP=3Dy=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_IP_MROUTE is not set=0A=
CONFIG_ARPD=3Dy=0A=
CONFIG_SYN_COOKIES=3Dy=0A=
CONFIG_INET_AH=3Dy=0A=
CONFIG_INET_ESP=3Dy=0A=
CONFIG_INET_IPCOMP=3Dy=0A=
CONFIG_INET_TUNNEL=3Dy=0A=
CONFIG_INET_DIAG=3Dy=0A=
CONFIG_INET_TCP_DIAG=3Dy=0A=
# CONFIG_TCP_CONG_ADVANCED is not set=0A=
CONFIG_TCP_CONG_BIC=3Dy=0A=
CONFIG_IPV6=3Dy=0A=
# CONFIG_IPV6_PRIVACY is not set=0A=
# CONFIG_INET6_AH is not set=0A=
CONFIG_INET6_ESP=3Dy=0A=
CONFIG_INET6_IPCOMP=3Dy=0A=
CONFIG_INET6_TUNNEL=3Dy=0A=
CONFIG_IPV6_TUNNEL=3Dy=0A=
# CONFIG_NETFILTER is not set=0A=
=0A=
#=0A=
# DCCP Configuration (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IP_DCCP is not set=0A=
=0A=
#=0A=
# SCTP Configuration (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IP_SCTP is not set=0A=
=0A=
#=0A=
# TIPC Configuration (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_TIPC is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_BRIDGE is not set=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_LLC2 is not set=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
# CONFIG_HAMRADIO is not set=0A=
# CONFIG_IRDA is not set=0A=
# CONFIG_BT is not set=0A=
# CONFIG_IEEE80211 is not set=0A=
=0A=
#=0A=
# Device Drivers=0A=
#=0A=
=0A=
#=0A=
# Generic Driver Options=0A=
#=0A=
CONFIG_STANDALONE=3Dy=0A=
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy=0A=
# CONFIG_FW_LOADER is not set=0A=
=0A=
#=0A=
# Connector - unified userspace <-> kernelspace linker=0A=
#=0A=
# CONFIG_CONNECTOR is not set=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
CONFIG_MTD=3Dy=0A=
# CONFIG_MTD_DEBUG is not set=0A=
# CONFIG_MTD_CONCAT is not set=0A=
# CONFIG_MTD_PARTITIONS is not set=0A=
=0A=
#=0A=
# User Modules And Translation Layers=0A=
#=0A=
CONFIG_MTD_CHAR=3Dy=0A=
CONFIG_MTD_BLOCK=3Dy=0A=
# CONFIG_FTL is not set=0A=
# CONFIG_NFTL is not set=0A=
# CONFIG_INFTL is not set=0A=
# CONFIG_RFD_FTL is not set=0A=
=0A=
#=0A=
# RAM/ROM/Flash chip drivers=0A=
#=0A=
CONFIG_MTD_CFI=3Dy=0A=
# CONFIG_MTD_JEDECPROBE is not set=0A=
CONFIG_MTD_GEN_PROBE=3Dy=0A=
CONFIG_MTD_CFI_ADV_OPTIONS=3Dy=0A=
# CONFIG_MTD_CFI_NOSWAP is not set=0A=
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set=0A=
CONFIG_MTD_CFI_LE_BYTE_SWAP=3Dy=0A=
CONFIG_MTD_CFI_GEOMETRY=3Dy=0A=
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set=0A=
CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy=0A=
# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set=0A=
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set=0A=
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set=0A=
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set=0A=
CONFIG_MTD_CFI_I1=3Dy=0A=
# CONFIG_MTD_CFI_I2 is not set=0A=
# CONFIG_MTD_CFI_I4 is not set=0A=
# CONFIG_MTD_CFI_I8 is not set=0A=
# CONFIG_MTD_OTP is not set=0A=
CONFIG_MTD_CFI_INTELEXT=3Dy=0A=
# CONFIG_MTD_CFI_AMDSTD is not set=0A=
# CONFIG_MTD_CFI_STAA is not set=0A=
CONFIG_MTD_CFI_UTIL=3Dy=0A=
# CONFIG_MTD_RAM is not set=0A=
# CONFIG_MTD_ROM is not set=0A=
# CONFIG_MTD_ABSENT is not set=0A=
# CONFIG_MTD_OBSOLETE_CHIPS is not set=0A=
=0A=
#=0A=
# Mapping drivers for chip access=0A=
#=0A=
# CONFIG_MTD_COMPLEX_MAPPINGS is not set=0A=
CONFIG_MTD_PHYSMAP=3Dy=0A=
CONFIG_MTD_PHYSMAP_START=3D0x1c000000=0A=
CONFIG_MTD_PHYSMAP_LEN=3D0x1000000=0A=
CONFIG_MTD_PHYSMAP_BANKWIDTH=3D2=0A=
# CONFIG_MTD_PLATRAM is not set=0A=
=0A=
#=0A=
# Self-contained MTD device drivers=0A=
#=0A=
# CONFIG_MTD_PMC551 is not set=0A=
# CONFIG_MTD_SLRAM is not set=0A=
# CONFIG_MTD_PHRAM is not set=0A=
# CONFIG_MTD_MTDRAM is not set=0A=
# CONFIG_MTD_BLKMTD is not set=0A=
# CONFIG_MTD_BLOCK2MTD is not set=0A=
=0A=
#=0A=
# Disk-On-Chip Device Drivers=0A=
#=0A=
# CONFIG_MTD_DOC2000 is not set=0A=
# CONFIG_MTD_DOC2001 is not set=0A=
# CONFIG_MTD_DOC2001PLUS is not set=0A=
=0A=
#=0A=
# NAND Flash Device Drivers=0A=
#=0A=
# CONFIG_MTD_NAND is not set=0A=
=0A=
#=0A=
# OneNAND Flash Device Drivers=0A=
#=0A=
# CONFIG_MTD_ONENAND is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
# CONFIG_PARPORT is not set=0A=
=0A=
#=0A=
# Plug and Play support=0A=
#=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_UMEM is not set=0A=
# CONFIG_BLK_DEV_COW_COMMON is not set=0A=
# CONFIG_BLK_DEV_LOOP is not set=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
# CONFIG_BLK_DEV_SX8 is not set=0A=
CONFIG_BLK_DEV_RAM=3Dy=0A=
CONFIG_BLK_DEV_RAM_COUNT=3D16=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D32768=0A=
CONFIG_BLK_DEV_INITRD=3Dy=0A=
# CONFIG_CDROM_PKTCDVD is not set=0A=
# CONFIG_ATA_OVER_ETH is not set=0A=
=0A=
#=0A=
# ATA/ATAPI/MFM/RLL support=0A=
#=0A=
CONFIG_IDE=3Dy=0A=
CONFIG_BLK_DEV_IDE=3Dy=0A=
=0A=
#=0A=
# Please see Documentation/ide.txt for help/info on IDE drives=0A=
#=0A=
CONFIG_BLK_DEV_IDE_SATA=3Dy=0A=
CONFIG_BLK_DEV_IDEDISK=3Dy=0A=
# CONFIG_IDEDISK_MULTI_MODE is not set=0A=
# CONFIG_BLK_DEV_IDECD is not set=0A=
# CONFIG_BLK_DEV_IDETAPE is not set=0A=
# CONFIG_BLK_DEV_IDEFLOPPY is not set=0A=
# CONFIG_IDE_TASK_IOCTL is not set=0A=
=0A=
#=0A=
# IDE chipset support/bugfixes=0A=
#=0A=
CONFIG_IDE_GENERIC=3Dy=0A=
CONFIG_BLK_DEV_IDEPCI=3Dy=0A=
CONFIG_IDEPCI_SHARE_IRQ=3Dy=0A=
# CONFIG_BLK_DEV_OFFBOARD is not set=0A=
CONFIG_BLK_DEV_GENERIC=3Dy=0A=
# CONFIG_BLK_DEV_OPTI621 is not set=0A=
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy=0A=
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set=0A=
CONFIG_IDEDMA_PCI_AUTO=3Dy=0A=
# CONFIG_IDEDMA_ONLYDISK is not set=0A=
# CONFIG_BLK_DEV_AEC62XX is not set=0A=
# CONFIG_BLK_DEV_ALI15X3 is not set=0A=
# CONFIG_BLK_DEV_AMD74XX is not set=0A=
# CONFIG_BLK_DEV_CMD64X is not set=0A=
# CONFIG_BLK_DEV_TRIFLEX is not set=0A=
# CONFIG_BLK_DEV_CY82C693 is not set=0A=
# CONFIG_BLK_DEV_CS5520 is not set=0A=
# CONFIG_BLK_DEV_CS5530 is not set=0A=
# CONFIG_BLK_DEV_HPT34X is not set=0A=
# CONFIG_BLK_DEV_HPT366 is not set=0A=
# CONFIG_BLK_DEV_SC1200 is not set=0A=
# CONFIG_BLK_DEV_PIIX is not set=0A=
# CONFIG_BLK_DEV_IT821X is not set=0A=
# CONFIG_BLK_DEV_NS87415 is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_OLD is not set=0A=
CONFIG_BLK_DEV_PDC202XX_NEW=3Dy=0A=
# CONFIG_BLK_DEV_SVWKS is not set=0A=
CONFIG_BLK_DEV_SIIMAGE=3Dy=0A=
# CONFIG_BLK_DEV_SLC90E66 is not set=0A=
# CONFIG_BLK_DEV_TRM290 is not set=0A=
# CONFIG_BLK_DEV_VIA82CXXX is not set=0A=
# CONFIG_BLK_DEV_IDE_SWARM is not set=0A=
# CONFIG_IDE_ARM is not set=0A=
CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
# CONFIG_IDEDMA_IVB is not set=0A=
CONFIG_IDEDMA_AUTO=3Dy=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
=0A=
#=0A=
# SCSI device support=0A=
#=0A=
# CONFIG_RAID_ATTRS is not set=0A=
# CONFIG_SCSI is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
=0A=
#=0A=
# Fusion MPT device support=0A=
#=0A=
# CONFIG_FUSION is not set=0A=
=0A=
#=0A=
# IEEE 1394 (FireWire) support=0A=
#=0A=
# CONFIG_IEEE1394 is not set=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
# CONFIG_I2O is not set=0A=
=0A=
#=0A=
# Network device support=0A=
#=0A=
CONFIG_NETDEVICES=3Dy=0A=
CONFIG_DUMMY=3Dy=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
=0A=
#=0A=
# PHY device support=0A=
#=0A=
# CONFIG_PHYLIB is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
CONFIG_MII=3Dy=0A=
# CONFIG_HAPPYMEAL is not set=0A=
# CONFIG_SUNGEM is not set=0A=
# CONFIG_CASSINI is not set=0A=
# CONFIG_NET_VENDOR_3COM is not set=0A=
# CONFIG_DM9000 is not set=0A=
=0A=
#=0A=
# Tulip family network device support=0A=
#=0A=
# CONFIG_NET_TULIP is not set=0A=
# CONFIG_HP100 is not set=0A=
CONFIG_NET_PCI=3Dy=0A=
# CONFIG_PCNET32 is not set=0A=
# CONFIG_AMD8111_ETH is not set=0A=
# CONFIG_ADAPTEC_STARFIRE is not set=0A=
# CONFIG_B44 is not set=0A=
# CONFIG_FORCEDETH is not set=0A=
# CONFIG_DGRS is not set=0A=
# CONFIG_EEPRO100 is not set=0A=
# CONFIG_E100 is not set=0A=
# CONFIG_FEALNX is not set=0A=
CONFIG_NATSEMI=3Dy=0A=
# CONFIG_NE2K_PCI is not set=0A=
# CONFIG_8139CP is not set=0A=
CONFIG_8139TOO=3Dy=0A=
# CONFIG_8139TOO_PIO is not set=0A=
# CONFIG_8139TOO_TUNE_TWISTER is not set=0A=
# CONFIG_8139TOO_8129 is not set=0A=
# CONFIG_8139_OLD_RX_RESET is not set=0A=
# CONFIG_SIS900 is not set=0A=
# CONFIG_EPIC100 is not set=0A=
# CONFIG_SUNDANCE is not set=0A=
# CONFIG_TLAN is not set=0A=
# CONFIG_VIA_RHINE is not set=0A=
# CONFIG_LAN_SAA9730 is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_DL2K is not set=0A=
# CONFIG_E1000 is not set=0A=
# CONFIG_NS83820 is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_R8169 is not set=0A=
# CONFIG_NET_SB1250_MAC is not set=0A=
# CONFIG_SIS190 is not set=0A=
# CONFIG_SKGE is not set=0A=
# CONFIG_SKY2 is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_VIA_VELOCITY is not set=0A=
CONFIG_TIGON3=3Dy=0A=
# CONFIG_BNX2 is not set=0A=
=0A=
#=0A=
# Ethernet (10000 Mbit)=0A=
#=0A=
# CONFIG_CHELSIO_T1 is not set=0A=
# CONFIG_IXGB is not set=0A=
# CONFIG_S2IO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
CONFIG_NET_RADIO=3Dy=0A=
=0A=
#=0A=
# Obsolete Wireless cards support (pre-802.11)=0A=
#=0A=
CONFIG_STRIP=3Dm=0A=
=0A=
#=0A=
# Wireless 802.11b ISA/PCI cards support=0A=
#=0A=
CONFIG_HERMES=3Dm=0A=
# CONFIG_PLX_HERMES is not set=0A=
# CONFIG_TMD_HERMES is not set=0A=
# CONFIG_NORTEL_HERMES is not set=0A=
# CONFIG_PCI_HERMES is not set=0A=
# CONFIG_ATMEL is not set=0A=
=0A=
#=0A=
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support=0A=
#=0A=
# CONFIG_PRISM54 is not set=0A=
# CONFIG_HOSTAP is not set=0A=
CONFIG_NET_WIRELESS=3Dy=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
CONFIG_WAN=3Dy=0A=
# CONFIG_DSCC4 is not set=0A=
# CONFIG_LANMEDIA is not set=0A=
# CONFIG_SYNCLINK_SYNCPPP is not set=0A=
# CONFIG_HDLC is not set=0A=
CONFIG_DLCI=3Dm=0A=
CONFIG_DLCI_COUNT=3D24=0A=
CONFIG_DLCI_MAX=3D8=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
# CONFIG_PPP is not set=0A=
# CONFIG_SLIP is not set=0A=
# CONFIG_SHAPER is not set=0A=
# CONFIG_NETCONSOLE is not set=0A=
# CONFIG_NETPOLL is not set=0A=
# CONFIG_NET_POLL_CONTROLLER is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Telephony Support=0A=
#=0A=
# CONFIG_PHONE is not set=0A=
=0A=
#=0A=
# Input device support=0A=
#=0A=
# CONFIG_INPUT is not set=0A=
=0A=
#=0A=
# Hardware I/O ports=0A=
#=0A=
# CONFIG_SERIO is not set=0A=
# CONFIG_GAMEPORT is not set=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
# CONFIG_VT is not set=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
# CONFIG_SIBYTE_SB1250_DUART is not set=0A=
=0A=
#=0A=
# Serial drivers=0A=
#=0A=
CONFIG_SERIAL_8250=3Dy=0A=
CONFIG_SERIAL_8250_CONSOLE=3Dy=0A=
CONFIG_SERIAL_8250_NR_UARTS=3D4=0A=
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4=0A=
CONFIG_SERIAL_8250_EXTENDED=3Dy=0A=
# CONFIG_SERIAL_8250_MANY_PORTS is not set=0A=
# CONFIG_SERIAL_8250_SHARE_IRQ is not set=0A=
# CONFIG_SERIAL_8250_DETECT_IRQ is not set=0A=
# CONFIG_SERIAL_8250_RSA is not set=0A=
=0A=
#=0A=
# Non-8250 serial port support=0A=
#=0A=
CONFIG_SERIAL_CORE=3Dy=0A=
CONFIG_SERIAL_CORE_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_JSM is not set=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_LEGACY_PTYS=3Dy=0A=
CONFIG_LEGACY_PTY_COUNT=3D256=0A=
=0A=
#=0A=
# IPMI=0A=
#=0A=
# CONFIG_IPMI_HANDLER is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
# CONFIG_RTC is not set=0A=
# CONFIG_GEN_RTC is not set=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_DRM is not set=0A=
# CONFIG_RAW_DRIVER is not set=0A=
=0A=
#=0A=
# TPM devices=0A=
#=0A=
# CONFIG_TCG_TPM is not set=0A=
# CONFIG_TELCLOCK is not set=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
CONFIG_I2C=3Dy=0A=
# CONFIG_I2C_CHARDEV is not set=0A=
=0A=
#=0A=
# I2C Algorithms=0A=
#=0A=
# CONFIG_I2C_ALGOBIT is not set=0A=
# CONFIG_I2C_ALGOPCF is not set=0A=
CONFIG_I2C_ALGOPALM=3Dy=0A=
# CONFIG_I2C_ALGOPCA is not set=0A=
# CONFIG_I2C_ALGO_SIBYTE is not set=0A=
=0A=
#=0A=
# I2C Hardware Bus support=0A=
#=0A=
# CONFIG_I2C_ALI1535 is not set=0A=
# CONFIG_I2C_ALI1563 is not set=0A=
# CONFIG_I2C_ALI15X3 is not set=0A=
# CONFIG_I2C_AMD756 is not set=0A=
# CONFIG_I2C_AMD8111 is not set=0A=
CONFIG_I2C_BK3220=3Dy=0A=
# CONFIG_I2C_I801 is not set=0A=
# CONFIG_I2C_I810 is not set=0A=
# CONFIG_I2C_PIIX4 is not set=0A=
# CONFIG_I2C_NFORCE2 is not set=0A=
# CONFIG_I2C_PARPORT_LIGHT is not set=0A=
# CONFIG_I2C_PROSAVAGE is not set=0A=
# CONFIG_I2C_SAVAGE4 is not set=0A=
# CONFIG_I2C_SIBYTE is not set=0A=
# CONFIG_SCx200_ACB is not set=0A=
# CONFIG_I2C_SIS5595 is not set=0A=
# CONFIG_I2C_SIS630 is not set=0A=
# CONFIG_I2C_SIS96X is not set=0A=
# CONFIG_I2C_STUB is not set=0A=
# CONFIG_I2C_VIA is not set=0A=
# CONFIG_I2C_VIAPRO is not set=0A=
# CONFIG_I2C_VOODOO3 is not set=0A=
# CONFIG_I2C_PCA_ISA is not set=0A=
=0A=
#=0A=
# Miscellaneous I2C Chip support=0A=
#=0A=
# CONFIG_SENSORS_DS1337 is not set=0A=
# CONFIG_SENSORS_DS1374 is not set=0A=
# CONFIG_SENSORS_EEPROM is not set=0A=
# CONFIG_SENSORS_PCF8574 is not set=0A=
# CONFIG_SENSORS_PCA9539 is not set=0A=
# CONFIG_SENSORS_PCF8591 is not set=0A=
# CONFIG_SENSORS_RTC8564 is not set=0A=
# CONFIG_SENSORS_MAX6875 is not set=0A=
# CONFIG_RTC_X1205_I2C is not set=0A=
# CONFIG_I2C_DEBUG_CORE is not set=0A=
# CONFIG_I2C_DEBUG_ALGO is not set=0A=
# CONFIG_I2C_DEBUG_BUS is not set=0A=
# CONFIG_I2C_DEBUG_CHIP is not set=0A=
=0A=
#=0A=
# SPI support=0A=
#=0A=
# CONFIG_SPI is not set=0A=
# CONFIG_SPI_MASTER is not set=0A=
=0A=
#=0A=
# Dallas's 1-wire bus=0A=
#=0A=
# CONFIG_W1 is not set=0A=
=0A=
#=0A=
# Hardware Monitoring support=0A=
#=0A=
CONFIG_HWMON=3Dy=0A=
# CONFIG_HWMON_VID is not set=0A=
# CONFIG_SENSORS_ADM1021 is not set=0A=
# CONFIG_SENSORS_ADM1025 is not set=0A=
# CONFIG_SENSORS_ADM1026 is not set=0A=
# CONFIG_SENSORS_ADM1031 is not set=0A=
# CONFIG_SENSORS_ADM9240 is not set=0A=
# CONFIG_SENSORS_ASB100 is not set=0A=
# CONFIG_SENSORS_ATXP1 is not set=0A=
# CONFIG_SENSORS_DS1621 is not set=0A=
# CONFIG_SENSORS_F71805F is not set=0A=
# CONFIG_SENSORS_FSCHER is not set=0A=
# CONFIG_SENSORS_FSCPOS is not set=0A=
# CONFIG_SENSORS_GL518SM is not set=0A=
# CONFIG_SENSORS_GL520SM is not set=0A=
# CONFIG_SENSORS_IT87 is not set=0A=
# CONFIG_SENSORS_LM63 is not set=0A=
# CONFIG_SENSORS_LM75 is not set=0A=
# CONFIG_SENSORS_LM77 is not set=0A=
# CONFIG_SENSORS_LM78 is not set=0A=
# CONFIG_SENSORS_LM80 is not set=0A=
# CONFIG_SENSORS_LM83 is not set=0A=
# CONFIG_SENSORS_LM85 is not set=0A=
# CONFIG_SENSORS_LM87 is not set=0A=
# CONFIG_SENSORS_LM90 is not set=0A=
# CONFIG_SENSORS_LM92 is not set=0A=
# CONFIG_SENSORS_MAX1619 is not set=0A=
# CONFIG_SENSORS_PC87360 is not set=0A=
# CONFIG_SENSORS_SIS5595 is not set=0A=
# CONFIG_SENSORS_SMSC47M1 is not set=0A=
# CONFIG_SENSORS_SMSC47B397 is not set=0A=
# CONFIG_SENSORS_VIA686A is not set=0A=
# CONFIG_SENSORS_VT8231 is not set=0A=
# CONFIG_SENSORS_W83781D is not set=0A=
# CONFIG_SENSORS_W83792D is not set=0A=
# CONFIG_SENSORS_W83L785TS is not set=0A=
# CONFIG_SENSORS_W83627HF is not set=0A=
# CONFIG_SENSORS_W83627EHF is not set=0A=
# CONFIG_HWMON_DEBUG_CHIP is not set=0A=
=0A=
#=0A=
# Misc devices=0A=
#=0A=
=0A=
#=0A=
# Multimedia Capabilities Port drivers=0A=
#=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# Digital Video Broadcasting Devices=0A=
#=0A=
# CONFIG_DVB is not set=0A=
=0A=
#=0A=
# Graphics support=0A=
#=0A=
# CONFIG_FB is not set=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
# CONFIG_SOUND is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
CONFIG_USB_ARCH_HAS_HCD=3Dy=0A=
CONFIG_USB_ARCH_HAS_OHCI=3Dy=0A=
# CONFIG_USB is not set=0A=
=0A=
#=0A=
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'=0A=
#=0A=
=0A=
#=0A=
# USB Gadget Support=0A=
#=0A=
# CONFIG_USB_GADGET is not set=0A=
=0A=
#=0A=
# MMC/SD Card support=0A=
#=0A=
# CONFIG_MMC is not set=0A=
=0A=
#=0A=
# InfiniBand support=0A=
#=0A=
# CONFIG_INFINIBAND is not set=0A=
=0A=
#=0A=
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)=0A=
#=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
CONFIG_EXT2_FS=3Dy=0A=
# CONFIG_EXT2_FS_XATTR is not set=0A=
# CONFIG_EXT2_FS_XIP is not set=0A=
CONFIG_EXT3_FS=3Dy=0A=
# CONFIG_EXT3_FS_XATTR is not set=0A=
CONFIG_JBD=3Dy=0A=
# CONFIG_JBD_DEBUG is not set=0A=
# CONFIG_REISERFS_FS is not set=0A=
# CONFIG_JFS_FS is not set=0A=
# CONFIG_FS_POSIX_ACL is not set=0A=
# CONFIG_XFS_FS is not set=0A=
# CONFIG_OCFS2_FS is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
CONFIG_INOTIFY=3Dy=0A=
# CONFIG_QUOTA is not set=0A=
CONFIG_DNOTIFY=3Dy=0A=
# CONFIG_AUTOFS_FS is not set=0A=
# CONFIG_AUTOFS4_FS is not set=0A=
# CONFIG_FUSE_FS is not set=0A=
=0A=
#=0A=
# CD-ROM/DVD Filesystems=0A=
#=0A=
# CONFIG_ISO9660_FS is not set=0A=
# CONFIG_UDF_FS is not set=0A=
=0A=
#=0A=
# DOS/FAT/NT Filesystems=0A=
#=0A=
CONFIG_FAT_FS=3Dy=0A=
CONFIG_MSDOS_FS=3Dy=0A=
CONFIG_VFAT_FS=3Dy=0A=
CONFIG_FAT_DEFAULT_CODEPAGE=3D437=0A=
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"=0A=
# CONFIG_NTFS_FS is not set=0A=
=0A=
#=0A=
# Pseudo filesystems=0A=
#=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_PROC_KCORE=3Dy=0A=
CONFIG_SYSFS=3Dy=0A=
CONFIG_TMPFS=3Dy=0A=
# CONFIG_HUGETLB_PAGE is not set=0A=
CONFIG_RAMFS=3Dy=0A=
# CONFIG_RELAYFS_FS is not set=0A=
# CONFIG_CONFIGFS_FS is not set=0A=
=0A=
#=0A=
# Miscellaneous filesystems=0A=
#=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_HFSPLUS_FS is not set=0A=
# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_JFFS_FS is not set=0A=
# CONFIG_JFFS2_FS is not set=0A=
# CONFIG_CRAMFS is not set=0A=
# CONFIG_VXFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
CONFIG_NFS_FS=3Dy=0A=
CONFIG_NFS_V3=3Dy=0A=
# CONFIG_NFS_V3_ACL is not set=0A=
CONFIG_NFS_V4=3Dy=0A=
# CONFIG_NFS_DIRECTIO is not set=0A=
# CONFIG_NFSD is not set=0A=
# CONFIG_ROOT_NFS is not set=0A=
CONFIG_LOCKD=3Dy=0A=
CONFIG_LOCKD_V4=3Dy=0A=
CONFIG_NFS_COMMON=3Dy=0A=
CONFIG_SUNRPC=3Dy=0A=
CONFIG_SUNRPC_GSS=3Dy=0A=
CONFIG_RPCSEC_GSS_KRB5=3Dy=0A=
# CONFIG_RPCSEC_GSS_SPKM3 is not set=0A=
# CONFIG_SMB_FS is not set=0A=
# CONFIG_CIFS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_AFS_FS is not set=0A=
# CONFIG_9P_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
CONFIG_PARTITION_ADVANCED=3Dy=0A=
# CONFIG_ACORN_PARTITION is not set=0A=
# CONFIG_OSF_PARTITION is not set=0A=
# CONFIG_AMIGA_PARTITION is not set=0A=
# CONFIG_ATARI_PARTITION is not set=0A=
# CONFIG_MAC_PARTITION is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
CONFIG_BSD_DISKLABEL=3Dy=0A=
# CONFIG_MINIX_SUBPARTITION is not set=0A=
# CONFIG_SOLARIS_X86_PARTITION is not set=0A=
# CONFIG_UNIXWARE_DISKLABEL is not set=0A=
# CONFIG_LDM_PARTITION is not set=0A=
# CONFIG_SGI_PARTITION is not set=0A=
# CONFIG_ULTRIX_PARTITION is not set=0A=
# CONFIG_SUN_PARTITION is not set=0A=
# CONFIG_KARMA_PARTITION is not set=0A=
# CONFIG_EFI_PARTITION is not set=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
CONFIG_NLS=3Dy=0A=
CONFIG_NLS_DEFAULT=3D"iso8859-1"=0A=
# CONFIG_NLS_CODEPAGE_437 is not set=0A=
# CONFIG_NLS_CODEPAGE_737 is not set=0A=
# CONFIG_NLS_CODEPAGE_775 is not set=0A=
# CONFIG_NLS_CODEPAGE_850 is not set=0A=
# CONFIG_NLS_CODEPAGE_852 is not set=0A=
# CONFIG_NLS_CODEPAGE_855 is not set=0A=
# CONFIG_NLS_CODEPAGE_857 is not set=0A=
# CONFIG_NLS_CODEPAGE_860 is not set=0A=
# CONFIG_NLS_CODEPAGE_861 is not set=0A=
# CONFIG_NLS_CODEPAGE_862 is not set=0A=
# CONFIG_NLS_CODEPAGE_863 is not set=0A=
# CONFIG_NLS_CODEPAGE_864 is not set=0A=
# CONFIG_NLS_CODEPAGE_865 is not set=0A=
# CONFIG_NLS_CODEPAGE_866 is not set=0A=
# CONFIG_NLS_CODEPAGE_869 is not set=0A=
# CONFIG_NLS_CODEPAGE_936 is not set=0A=
# CONFIG_NLS_CODEPAGE_950 is not set=0A=
# CONFIG_NLS_CODEPAGE_932 is not set=0A=
# CONFIG_NLS_CODEPAGE_949 is not set=0A=
# CONFIG_NLS_CODEPAGE_874 is not set=0A=
# CONFIG_NLS_ISO8859_8 is not set=0A=
# CONFIG_NLS_CODEPAGE_1250 is not set=0A=
# CONFIG_NLS_CODEPAGE_1251 is not set=0A=
# CONFIG_NLS_ASCII is not set=0A=
# CONFIG_NLS_ISO8859_1 is not set=0A=
# CONFIG_NLS_ISO8859_2 is not set=0A=
# CONFIG_NLS_ISO8859_3 is not set=0A=
# CONFIG_NLS_ISO8859_4 is not set=0A=
# CONFIG_NLS_ISO8859_5 is not set=0A=
# CONFIG_NLS_ISO8859_6 is not set=0A=
# CONFIG_NLS_ISO8859_7 is not set=0A=
# CONFIG_NLS_ISO8859_9 is not set=0A=
# CONFIG_NLS_ISO8859_13 is not set=0A=
# CONFIG_NLS_ISO8859_14 is not set=0A=
# CONFIG_NLS_ISO8859_15 is not set=0A=
# CONFIG_NLS_KOI8_R is not set=0A=
# CONFIG_NLS_KOI8_U is not set=0A=
# CONFIG_NLS_UTF8 is not set=0A=
=0A=
#=0A=
# Profiling support=0A=
#=0A=
=0A=
#=0A=
# Performance-monitoring counters support=0A=
#=0A=
# CONFIG_PERFCTR is not set=0A=
# CONFIG_PROFILING is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
# CONFIG_PRINTK_TIME is not set=0A=
# CONFIG_MAGIC_SYSRQ is not set=0A=
# CONFIG_DEBUG_KERNEL is not set=0A=
CONFIG_LOG_BUF_SHIFT=3D15=0A=
CONFIG_CROSSCOMPILE=3Dy=0A=
CONFIG_CMDLINE=3D""=0A=
# CONFIG_SB1XXX_CORELIS is not set=0A=
=0A=
#=0A=
# Security options=0A=
#=0A=
# CONFIG_KEYS is not set=0A=
CONFIG_SECURITY=3Dy=0A=
CONFIG_SECURITY_NETWORK=3Dy=0A=
# CONFIG_SECURITY_NETWORK_XFRM is not set=0A=
CONFIG_SECURITY_CAPABILITIES=3Dy=0A=
# CONFIG_SECURITY_SECLVL is not set=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
CONFIG_CRYPTO=3Dy=0A=
CONFIG_CRYPTO_HMAC=3Dy=0A=
CONFIG_CRYPTO_NULL=3Dy=0A=
CONFIG_CRYPTO_MD4=3Dy=0A=
CONFIG_CRYPTO_MD5=3Dy=0A=
CONFIG_CRYPTO_SHA1=3Dy=0A=
CONFIG_CRYPTO_SHA256=3Dy=0A=
CONFIG_CRYPTO_SHA512=3Dy=0A=
# CONFIG_CRYPTO_WP512 is not set=0A=
# CONFIG_CRYPTO_TGR192 is not set=0A=
CONFIG_CRYPTO_DES=3Dy=0A=
CONFIG_CRYPTO_BLOWFISH=3Dy=0A=
CONFIG_CRYPTO_TWOFISH=3Dy=0A=
CONFIG_CRYPTO_SERPENT=3Dy=0A=
CONFIG_CRYPTO_AES=3Dy=0A=
CONFIG_CRYPTO_CAST5=3Dy=0A=
CONFIG_CRYPTO_CAST6=3Dy=0A=
# CONFIG_CRYPTO_TEA is not set=0A=
CONFIG_CRYPTO_ARC4=3Dy=0A=
# CONFIG_CRYPTO_KHAZAD is not set=0A=
# CONFIG_CRYPTO_ANUBIS is not set=0A=
CONFIG_CRYPTO_DEFLATE=3Dy=0A=
CONFIG_CRYPTO_MICHAEL_MIC=3Dy=0A=
# CONFIG_CRYPTO_CRC32C is not set=0A=
# CONFIG_CRYPTO_TEST is not set=0A=
=0A=
#=0A=
# Hardware crypto devices=0A=
#=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
# CONFIG_CRC_CCITT is not set=0A=
# CONFIG_CRC16 is not set=0A=
CONFIG_CRC32=3Dy=0A=
# CONFIG_LIBCRC32C is not set=0A=
CONFIG_ZLIB_INFLATE=3Dy=0A=
CONFIG_ZLIB_DEFLATE=3Dy=0A=

------=_NextPart_000_000C_01C6B487.DF72B8A0--
