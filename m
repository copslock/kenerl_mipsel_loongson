Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 16:54:05 +0200 (CEST)
Received: from mail-bl2lp0204.outbound.protection.outlook.com ([207.46.163.204]:30437
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855104AbaETOuDZpFYD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 May 2014 16:50:03 +0200
Received: from localhost.localdomain (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Tue, 20 May 2014 14:49:45 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>, <kvm@vger.kernel.org>
Subject: [PATCH 14/15] MIPS: paravirt: Update mips_paravirt_defconfig
Date:   Tue, 20 May 2014 16:47:15 +0200
Message-ID: <1400597236-11352-15-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: AM3PR01CA004.eurprd01.prod.exchangelabs.com
 (10.242.240.14) To DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21)
X-Forefront-PRVS: 02176E2458
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6069001)(6009001)(428001)(199002)(189002)(79102001)(36756003)(48376002)(66066001)(77982001)(92726001)(50466002)(74502001)(46102001)(64706001)(47776003)(80022001)(20776003)(50226001)(33646001)(101416001)(50986999)(76482001)(77156001)(89996001)(42186004)(81542001)(92566001)(62966002)(81342001)(87976001)(575784001)(93916002)(87286001)(4396001)(19580395003)(83072002)(88136002)(85852003)(21056001)(76176999)(83322001)(31966008)(74662001)(86362001)(99396002)(102836001)(19580405001);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB398;H:localhost.localdomain;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
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

Change CPU selection, enable SMP, enable almost all virtio options.

Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 arch/mips/configs/mips_paravirt_defconfig |   69 ++++++++++++++---------------
 1 file changed, 33 insertions(+), 36 deletions(-)

diff --git a/arch/mips/configs/mips_paravirt_defconfig b/arch/mips/configs/mips_paravirt_defconfig
index f0cac9c..f3215b49 100644
--- a/arch/mips/configs/mips_paravirt_defconfig
+++ b/arch/mips/configs/mips_paravirt_defconfig
@@ -49,10 +49,6 @@ CONFIG_MIPS=y
 # CONFIG_NLM_XLP_BOARD is not set
 CONFIG_MIPS_PARAVIRT=y
 # CONFIG_ALCHEMY_GPIO_INDIRECT is not set
-# CONFIG_MACH_TX39XX is not set
-# CONFIG_MACH_TX49XX is not set
-# CONFIG_CAVIUM_CN63XXP1 is not set
-CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE=1
 CONFIG_MIPS_PCI_VIRTIO=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
@@ -72,22 +68,22 @@ CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
 CONFIG_SYS_SUPPORTS_HUGETLBFS=y
 CONFIG_MIPS_HUGE_TLB_SUPPORT=y
 CONFIG_SWAP_IO_SPACE=y
-CONFIG_MIPS_L1_CACHE_SHIFT_7=y
-CONFIG_MIPS_L1_CACHE_SHIFT=7
+CONFIG_MIPS_L1_CACHE_SHIFT=5
 
 #
 # CPU selection
 #
 # CONFIG_CPU_MIPS32_R2 is not set
-# CONFIG_CPU_MIPS64_R2 is not set
-CONFIG_CPU_CAVIUM_OCTEON=y
+CONFIG_CPU_MIPS64_R2=y
+# CONFIG_CPU_CAVIUM_OCTEON is not set
 CONFIG_SYS_HAS_CPU_MIPS32_R2=y
 CONFIG_SYS_HAS_CPU_MIPS64_R2=y
 CONFIG_SYS_HAS_CPU_CAVIUM_OCTEON=y
-CONFIG_WEAK_ORDERING=y
+CONFIG_CPU_MIPS64=y
 CONFIG_CPU_MIPSR2=y
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
 CONFIG_SYS_SUPPORTS_64BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_HUGEPAGES=y
 CONFIG_MIPS_PGD_C0_CONTEXT=y
@@ -96,20 +92,22 @@ CONFIG_HARDWARE_WATCHPOINTS=y
 #
 # Kernel type
 #
+# CONFIG_32BIT is not set
 CONFIG_64BIT=y
-# CONFIG_KVM_GUEST is not set
 CONFIG_PAGE_SIZE_4KB=y
-# CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
-# CONFIG_PAGE_SIZE_32KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_FORCE_MAX_ZONEORDER=11
 CONFIG_CPU_HAS_PREFETCH=y
 CONFIG_CPU_GENERIC_DUMP_TLB=y
+CONFIG_CPU_R4K_FPU=y
+CONFIG_CPU_R4K_CACHE_TLB=y
 CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
+CONFIG_CPU_HAS_MSA=y
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_CPU_SUPPORTS_HIGHMEM=y
+CONFIG_CPU_SUPPORTS_MSA=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
@@ -119,6 +117,7 @@ CONFIG_ARCH_DISCARD_MEMBLOCK=y
 # CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
 CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_BALLOON_COMPACTION=y
 CONFIG_COMPACTION=y
 CONFIG_MIGRATION=y
 CONFIG_PHYS_ADDR_T_64BIT=y
@@ -130,15 +129,15 @@ CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
 # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
 CONFIG_CROSS_MEMORY_ATTACH=y
-CONFIG_NEED_PER_CPU_KM=y
 # CONFIG_CLEANCACHE is not set
 # CONFIG_FRONTSWAP is not set
 # CONFIG_CMA is not set
 # CONFIG_ZBUD is not set
 # CONFIG_ZSMALLOC is not set
-# CONFIG_SMP is not set
+CONFIG_SMP=y
 CONFIG_SYS_SUPPORTS_SMP=y
 CONFIG_NR_CPUS_DEFAULT_4=y
+CONFIG_NR_CPUS=4
 # CONFIG_HZ_48 is not set
 # CONFIG_HZ_100 is not set
 # CONFIG_HZ_128 is not set
@@ -165,7 +164,6 @@ CONFIG_BUILDTIME_EXTABLE_SORT=y
 #
 # General setup
 #
-CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 CONFIG_CROSS_COMPILE=""
 # CONFIG_COMPILE_TEST is not set
@@ -175,8 +173,7 @@ CONFIG_DEFAULT_HOSTNAME="(none)"
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_SYSVIPC_SYSCTL=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_POSIX_MQUEUE_SYSCTL=y
+# CONFIG_POSIX_MQUEUE is not set
 # CONFIG_FHANDLE is not set
 CONFIG_USELIB=y
 # CONFIG_AUDIT is not set
@@ -196,6 +193,7 @@ CONFIG_GENERIC_CMOS_UPDATE=y
 #
 CONFIG_HZ_PERIODIC=y
 # CONFIG_NO_HZ_IDLE is not set
+# CONFIG_NO_HZ_FULL is not set
 # CONFIG_NO_HZ is not set
 # CONFIG_HIGH_RES_TIMERS is not set
 
@@ -214,6 +212,7 @@ CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_TREE_PREEMPT_RCU=y
 CONFIG_PREEMPT_RCU=y
 CONFIG_RCU_STALL_COMMON=y
+# CONFIG_RCU_USER_QS is not set
 CONFIG_RCU_FANOUT=64
 CONFIG_RCU_FANOUT_LEAF=16
 # CONFIG_RCU_FANOUT_EXACT is not set
@@ -317,6 +316,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 # CONFIG_MODULE_SIG is not set
+CONFIG_STOP_MACHINE=y
 CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_BLK_DEV_BSGLIB is not set
@@ -342,7 +342,8 @@ CONFIG_DEFAULT_CFQ=y
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="cfq"
 CONFIG_UNINLINE_SPIN_UNLOCK=y
-CONFIG_FREEZER=y
+CONFIG_MUTEX_SPIN_ON_OWNER=y
+# CONFIG_FREEZER is not set
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
@@ -387,18 +388,7 @@ CONFIG_BINFMT_ELF32=y
 #
 # Power management options
 #
-CONFIG_ARCH_HIBERNATION_POSSIBLE=y
-CONFIG_ARCH_SUSPEND_POSSIBLE=y
-CONFIG_SUSPEND=y
-CONFIG_SUSPEND_FREEZER=y
-# CONFIG_HIBERNATION is not set
-CONFIG_PM_SLEEP=y
-# CONFIG_PM_AUTOSLEEP is not set
-# CONFIG_PM_WAKELOCKS is not set
 # CONFIG_PM_RUNTIME is not set
-CONFIG_PM=y
-# CONFIG_PM_DEBUG is not set
-# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
 CONFIG_NET=y
 
 #
@@ -502,8 +492,12 @@ CONFIG_DNS_RESOLVER=y
 # CONFIG_NETLINK_DIAG is not set
 # CONFIG_NET_MPLS_GSO is not set
 # CONFIG_HSR is not set
+CONFIG_RPS=y
+CONFIG_RFS_ACCEL=y
+CONFIG_XPS=y
 CONFIG_NET_RX_BUSY_POLL=y
 CONFIG_BQL=y
+CONFIG_NET_FLOW_LIMIT=y
 
 #
 # Network testing
@@ -566,7 +560,7 @@ CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
-# CONFIG_VIRTIO_BLK is not set
+CONFIG_VIRTIO_BLK=y
 # CONFIG_BLK_DEV_HD is not set
 # CONFIG_BLK_DEV_RBD is not set
 # CONFIG_BLK_DEV_RSXX is not set
@@ -725,7 +719,7 @@ CONFIG_NET_CORE=y
 # CONFIG_NET_POLL_CONTROLLER is not set
 # CONFIG_TUN is not set
 # CONFIG_VETH is not set
-# CONFIG_VIRTIO_NET is not set
+CONFIG_VIRTIO_NET=y
 # CONFIG_NLMON is not set
 # CONFIG_ARCNET is not set
 
@@ -819,7 +813,7 @@ CONFIG_NET_VENDOR_RDC=y
 # CONFIG_R6040 is not set
 CONFIG_NET_VENDOR_SAMSUNG=y
 # CONFIG_SXGBE_ETH is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
+CONFIG_NET_VENDOR_SEEQ=y
 CONFIG_NET_VENDOR_SILAN=y
 # CONFIG_SC92031 is not set
 CONFIG_NET_VENDOR_SIS=y
@@ -1018,7 +1012,6 @@ CONFIG_VGA_ARB_MAX_GPUS=16
 # CONFIG_VGASTATE is not set
 # CONFIG_SOUND is not set
 CONFIG_USB_OHCI_LITTLE_ENDIAN=y
-CONFIG_USB_EHCI_BIG_ENDIAN_MMIO=y
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_UWB is not set
 # CONFIG_MMC is not set
@@ -1038,8 +1031,9 @@ CONFIG_VIRTIO=y
 # Virtio drivers
 #
 CONFIG_VIRTIO_PCI=y
-# CONFIG_VIRTIO_BALLOON is not set
-# CONFIG_VIRTIO_MMIO is not set
+CONFIG_VIRTIO_BALLOON=y
+CONFIG_VIRTIO_MMIO=y
+# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
 
 #
 # Microsoft Hyper-V guest support
@@ -1277,6 +1271,7 @@ CONFIG_HAVE_DEBUG_KMEMLEAK=y
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_DEBUG_PER_CPU_MAPS is not set
 CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_SHIRQ is not set
@@ -1394,6 +1389,7 @@ CONFIG_CRYPTO_MANAGER2=y
 CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
 # CONFIG_CRYPTO_GF128MUL is not set
 # CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_PCRYPT is not set
 CONFIG_CRYPTO_WORKQUEUE=y
 # CONFIG_CRYPTO_CRYPTD is not set
 # CONFIG_CRYPTO_AUTHENC is not set
@@ -1514,10 +1510,11 @@ CONFIG_ASSOCIATIVE_ARRAY=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT_MAP=y
 CONFIG_HAS_DMA=y
+CONFIG_CPU_RMAP=y
 CONFIG_DQL=y
 CONFIG_NLATTR=y
 CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=y
-# CONFIG_AVERAGE is not set
+CONFIG_AVERAGE=y
 # CONFIG_CORDIC is not set
 # CONFIG_DDR is not set
 CONFIG_OID_REGISTRY=y
-- 
1.7.9.5
