Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2016 15:44:09 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:52141 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033660AbcEYNoGm1Mqi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 May 2016 15:44:06 +0200
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd001.nsn-inter.net (8.15.2/8.15.2) with ESMTPS id u4PDhxNR011894
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 25 May 2016 13:44:00 GMT
Received: from ak-desktop.emea.nsn-net.net ([10.144.36.118])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with SMTP id u4PDhw8D026005;
        Wed, 25 May 2016 15:43:58 +0200
Received: by ak-desktop.emea.nsn-net.net (sSMTP sendmail emulation); Wed, 25 May 2016 16:41:52 +0300
Date:   Wed, 25 May 2016 16:41:52 +0300
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     David Daney <ddaney.cavm@gmail.com>
Subject: Re: THP broken on OCTEON?
Message-ID: <20160525134152.GG23204@ak-desktop.emea.nsn-net.net>
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 7250
X-purgate-ID: 151667::1464183840-00004C87-20EE73FD/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nokia.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi,

On Mon, May 23, 2016 at 06:13:46PM +0300, Aaro Koskinen wrote:
> I'm getting kernel crashes (see below) reliably when building Perl in
> parallel (make -j16) on OCTEON EBH5600 board (8 cores, 4 GB RAM) with
> Linux 4.6.
> 
> It seems that CONFIG_TRANSPARENT_HUGEPAGE has something to do with the
> issue - disabling it makes build go through fine.

Seems to be also reproducible on MIPS64/Malta/QEMU (UP, 2 GB RAM). This
happened during Perl's Configure script on the first try:

...

killpg() found.
 
lchown() found.
 
LDBL_DIG found.
 
<math.h> found.
 
Checking to see if your libm supports _LIB_VERSION...
[ 1180.488704] Data bus error, epc == 000000fff4c0ae10, ra == 000000fff4df5d3c
[ 1180.650437] Unhandled kernel unaligned access[#1]:
[ 1180.651021] CPU: 0 PID: 3213 Comm: ld Not tainted 4.6.0-mipsqemu-distro.git-v2.16-3-g8f2e042-dirty-00002-g97bf1a1 #1
[ 1180.651619] task: 98000000fdc6e300 ti: 98000000fdd98000 task.ti: 98000000fdd98000
[ 1180.652049] $ 0   : 0000000000000000 ffffffff8021b2c8 9800000001000600 00000000f1a005bf
[ 1180.652928] $ 4   : 00000000f1a005bf 0000000120200000 00000000000f1a00 0000000000100077
[ 1180.653417] $ 8   : 000000000000001c 98000000fdd9ba60 98000000fdd9ba68 0000000000000000
[ 1180.653852] $12   : 98000000fdd9ba58 000000000000a400 0000000000000000 0000000000000000
[ 1180.654309] $16   : 0000000120200000 0000000120200000 0000000120200000 98000000fdcfd500
[ 1180.654764] $20   : 0000000000000000 ffffffff80e10000 0000000000000003 00000001206f5000
[ 1180.655220] $24   : 0000000000000000 ffffffff801629d0                                  
[ 1180.655725] $28   : 98000000fdd98000 98000000fdd9ba20 0000000000000000 ffffffff8021b2c8
[ 1180.656219] Hi    : 00000000002d4e00
[ 1180.656453] Lo    : 00000000000f1a00
[ 1180.657115] epc   : ffffffff8012c990 r4k_flush_cache_page+0x80/0x4f0
[ 1180.657529] ra    : ffffffff8021b2c8 get_dump_page+0x90/0xb8
[ 1180.657809] Status: 1400a4e3	KX SX UX KERNEL EXL IE 
[ 1180.658268] Cause : 00800010 (ExcCode 04)
[ 1180.658500] BadVA : 00000000f1a005bf
[ 1180.658703] PrId  : 000182a0 (MIPS 20Kc)
[ 1180.658931] Modules linked in: autofs4
[ 1180.659360] Process ld (pid: 3213, threadinfo=98000000fdd98000, task=98000000fdc6e300, tls=000000fff4eba700)
[ 1180.659821] Stack : 0000000120200000 98000000fdee2480 0000000120200000 98000000fdee2a80
	  0000000000000000 98000000fdc95580 0000000000000003 ffffffff8021b2c8
	  98000000044db600 98000000fdc95580 98000000fe602100 ffffffff802ad418
	  98000000fe636800 ffffffff806c0188 0000000300000088 98000000fe602300
	  ffffffff806c0188 5349474900000080 98000000fdd9bae8 ffffffff806c0188
	  0000000600000120 98000000fdcfd630 ffffffff806c0188 46494c45000004c7
	  c000000000171000 0000000a00000080 0000000000000000 0000000000000000
	  0000000000000000 0000000000000000 0000000000000000 0000000000000000
	  0000000000000000 0000000000000000 0000000000000000 0000000000000000
	  0000000000000000 0000000000000000 0000000000000000 0000000000000000
	  ...
[ 1180.664677] Call Trace:
[ 1180.665054] [<ffffffff8012c990>] r4k_flush_cache_page+0x80/0x4f0
[ 1180.666422] [<ffffffff8021b2c8>] get_dump_page+0x90/0xb8
[ 1180.667099] [<ffffffff802ad418>] elf_core_dump+0x11a0/0x1350
[ 1180.667813] [<ffffffff802b1b30>] do_coredump+0x5a0/0xdf0
[ 1180.668500] [<ffffffff80143bfc>] get_signal+0x2bc/0x688
[ 1180.669172] [<ffffffff8010a874>] do_signal+0x24/0x1e8
[ 1180.669808] [<ffffffff8010b740>] do_notify_resume+0xa8/0xc8
[ 1180.670504] [<ffffffff80105d00>] work_notifysig+0x10/0x18
[ 1180.671514] 
[ 1180.671806] 
Code: 00111a7a  30630ff8  0064182d <dc630000> 30640001  1080005b  00000000  df840000  dc8402b8 
[ 1180.674251] ---[ end trace b03bb9be4922a576 ]---
[ 1180.675178] Fatal exception: panic in 5 seconds
[ 1185.681555] Kernel panic - not syncing: Fatal exception
[ 1185.682849] ---[ end Kernel panic - not syncing: Fatal exception

Used kernel config:

CONFIG_MIPS_MALTA=y
CONFIG_CPU_MIPS64_R1=y
CONFIG_64BIT=y
# CONFIG_BOUNCE is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_HZ_100=y
CONFIG_KEXEC=y
# CONFIG_SECCOMP is not set
CONFIG_LOCALVERSION="-mipsqemu"
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_AUDIT=y
CONFIG_NO_HZ_IDLE=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_NAMESPACES=y
CONFIG_SCHED_AUTOGROUP=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_KALLSYMS_ALL=y
CONFIG_EMBEDDED=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_BLK_DEV_BSG is not set
CONFIG_PARTITION_ADVANCED=y
# CONFIG_EFI_PARTITION is not set
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_PCI=y
CONFIG_MIPS32_O32=y
CONFIG_MIPS32_N32=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_DIAG is not set
CONFIG_TCP_MD5SIG=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_INET6_XFRM_MODE_BEET=m
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_NETFILTER=y
CONFIG_NF_CONNTRACK=m
CONFIG_NF_CONNTRACK_IPV4=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_NF_CONNTRACK_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
CONFIG_VLAN_8021Q=m
# CONFIG_WIRELESS is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_DEVTMPFS=y
# CONFIG_FW_LOADER is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_DRBD=m
CONFIG_VIRTIO_BLK=y
CONFIG_BLK_DEV_SD=y
# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_ATA=y
CONFIG_ATA_PIIX=y
CONFIG_MD=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_VXLAN=m
CONFIG_NETCONSOLE=m
CONFIG_VIRTIO_NET=y
# CONFIG_ETHERNET is not set
# CONFIG_WLAN is not set
# CONFIG_INPUT is not set
# CONFIG_SERIO is not set
# CONFIG_VT is not set
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=3
CONFIG_SERIAL_8250_RUNTIME_UARTS=3
# CONFIG_HW_RANDOM is not set
# CONFIG_HWMON is not set
# CONFIG_VGA_ARB is not set
CONFIG_VIRTIO_PCI=y
# CONFIG_IOMMU_SUPPORT is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=m
CONFIG_ISO9660_FS=m
CONFIG_VFAT_FS=m
CONFIG_PROC_KCORE=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
CONFIG_NFSD=m
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_9P_FS=y
CONFIG_PRINTK_TIME=y
CONFIG_DEBUG_INFO=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_SCHEDSTATS=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
# CONFIG_CRYPTO_HW is not set

A.
