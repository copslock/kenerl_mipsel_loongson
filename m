Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2006 05:01:03 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:25572 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8126537AbWDDEAo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Apr 2006 05:00:44 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 4 Apr 2006 13:11:48 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 7D1E720552;
	Tue,  4 Apr 2006 13:11:46 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 711FF713A;
	Tue,  4 Apr 2006 13:11:46 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k344Bj4D019812;
	Tue, 4 Apr 2006 13:11:46 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 04 Apr 2006 13:11:45 +0900 (JST)
Message-Id: <20060404.131145.130849545.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Enable SCHED_NO_NO_OMIT_FRAME_POINTER for MIPS.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

MIPS get_wchan() no longer requires -fno-omit-frame-pointer.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 Kconfig                         |    4 ++++
 configs/atlas_defconfig         |    1 +
 configs/bigsur_defconfig        |    1 +
 configs/capcella_defconfig      |    1 +
 configs/cobalt_defconfig        |    1 +
 configs/db1000_defconfig        |    1 +
 configs/db1100_defconfig        |    1 +
 configs/db1200_defconfig        |    1 +
 configs/db1500_defconfig        |    1 +
 configs/db1550_defconfig        |    1 +
 configs/ddb5476_defconfig       |    1 +
 configs/ddb5477_defconfig       |    1 +
 configs/decstation_defconfig    |    1 +
 configs/e55_defconfig           |    1 +
 configs/ev64120_defconfig       |    1 +
 configs/ev96100_defconfig       |    1 +
 configs/ip22_defconfig          |    1 +
 configs/ip27_defconfig          |    1 +
 configs/ip32_defconfig          |    1 +
 configs/it8172_defconfig        |    1 +
 configs/ivr_defconfig           |    1 +
 configs/jaguar-atx_defconfig    |    1 +
 configs/jmr3927_defconfig       |    1 +
 configs/lasat200_defconfig      |    1 +
 configs/malta_defconfig         |    1 +
 configs/mipssim_defconfig       |    1 +
 configs/mpc30x_defconfig        |    1 +
 configs/ocelot_3_defconfig      |    1 +
 configs/ocelot_c_defconfig      |    1 +
 configs/ocelot_defconfig        |    1 +
 configs/ocelot_g_defconfig      |    1 +
 configs/pb1100_defconfig        |    1 +
 configs/pb1500_defconfig        |    1 +
 configs/pb1550_defconfig        |    1 +
 configs/pnx8550-jbs_defconfig   |    1 +
 configs/pnx8550-v2pci_defconfig |    1 +
 configs/qemu_defconfig          |    1 +
 configs/rbhma4500_defconfig     |    1 +
 configs/rm200_defconfig         |    1 +
 configs/sb1250-swarm_defconfig  |    1 +
 configs/sead_defconfig          |    1 +
 configs/tb0226_defconfig        |    1 +
 configs/tb0229_defconfig        |    1 +
 configs/tb0287_defconfig        |    1 +
 configs/workpad_defconfig       |    1 +
 configs/yosemite_defconfig      |    1 +
 defconfig                       |    1 +
 47 files changed, 50 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ed52af7..c4d66ba 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -813,6 +813,10 @@ config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
 
+config SCHED_NO_NO_OMIT_FRAME_POINTER
+	bool
+	default y
+
 #
 # Select some configuration options automatically based on user selections.
 #
diff --git a/arch/mips/configs/atlas_defconfig b/arch/mips/configs/atlas_defconfig
index 9e1ae95..80da9c8 100644
--- a/arch/mips/configs/atlas_defconfig
+++ b/arch/mips/configs/atlas_defconfig
@@ -65,6 +65,7 @@ CONFIG_MIPS_ATLAS=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_MIPS_BONITO64=y
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index 3298410..05566a2 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -81,6 +81,7 @@ CONFIG_SIBYTE_CFE=y
 # CONFIG_SIBYTE_TBPROF is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_COHERENT=y
 CONFIG_CPU_BIG_ENDIAN=y
 # CONFIG_CPU_LITTLE_ENDIAN is not set
diff --git a/arch/mips/configs/capcella_defconfig b/arch/mips/configs/capcella_defconfig
index 6c2961a..a69dafb 100644
--- a/arch/mips/configs/capcella_defconfig
+++ b/arch/mips/configs/capcella_defconfig
@@ -73,6 +73,7 @@ CONFIG_PCI_VR41XX=y
 # CONFIG_VRC4173 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
diff --git a/arch/mips/configs/cobalt_defconfig b/arch/mips/configs/cobalt_defconfig
index 8336b21..6a4940b 100644
--- a/arch/mips/configs/cobalt_defconfig
+++ b/arch/mips/configs/cobalt_defconfig
@@ -65,6 +65,7 @@ CONFIG_MIPS_COBALT=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_I8259=y
diff --git a/arch/mips/configs/db1000_defconfig b/arch/mips/configs/db1000_defconfig
index 7f07140..6d7bcc0 100644
--- a/arch/mips/configs/db1000_defconfig
+++ b/arch/mips/configs/db1000_defconfig
@@ -65,6 +65,7 @@ CONFIG_MIPS_DB1000=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
diff --git a/arch/mips/configs/db1100_defconfig b/arch/mips/configs/db1100_defconfig
index 98590ca..acd2ffe 100644
--- a/arch/mips/configs/db1100_defconfig
+++ b/arch/mips/configs/db1100_defconfig
@@ -65,6 +65,7 @@ CONFIG_MIPS_DB1100=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
diff --git a/arch/mips/configs/db1200_defconfig b/arch/mips/configs/db1200_defconfig
index 9288847..d918754 100644
--- a/arch/mips/configs/db1200_defconfig
+++ b/arch/mips/configs/db1200_defconfig
@@ -65,6 +65,7 @@ CONFIG_MIPS_DB1200=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_COHERENT=y
 CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
diff --git a/arch/mips/configs/db1500_defconfig b/arch/mips/configs/db1500_defconfig
index 5a415b1..5491a51 100644
--- a/arch/mips/configs/db1500_defconfig
+++ b/arch/mips/configs/db1500_defconfig
@@ -65,6 +65,7 @@ CONFIG_MIPS_DB1500=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
diff --git a/arch/mips/configs/db1550_defconfig b/arch/mips/configs/db1550_defconfig
index 8dc1f18..425d939 100644
--- a/arch/mips/configs/db1550_defconfig
+++ b/arch/mips/configs/db1550_defconfig
@@ -65,6 +65,7 @@ CONFIG_MIPS_DB1550=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
diff --git a/arch/mips/configs/ddb5476_defconfig b/arch/mips/configs/ddb5476_defconfig
index 8fae63e..4837b3c 100644
--- a/arch/mips/configs/ddb5476_defconfig
+++ b/arch/mips/configs/ddb5476_defconfig
@@ -65,6 +65,7 @@ CONFIG_DDB5476=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_I8259=y
diff --git a/arch/mips/configs/ddb5477_defconfig b/arch/mips/configs/ddb5477_defconfig
index a0fcd44..e3a3786 100644
--- a/arch/mips/configs/ddb5477_defconfig
+++ b/arch/mips/configs/ddb5477_defconfig
@@ -66,6 +66,7 @@ CONFIG_DDB5477=y
 CONFIG_DDB5477_BUS_FREQUENCY=0
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_I8259=y
diff --git a/arch/mips/configs/decstation_defconfig b/arch/mips/configs/decstation_defconfig
index 5a181ea..b5b44a8 100644
--- a/arch/mips/configs/decstation_defconfig
+++ b/arch/mips/configs/decstation_defconfig
@@ -65,6 +65,7 @@ CONFIG_MACH_DECSTATION=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_EARLY_PRINTK=y
diff --git a/arch/mips/configs/e55_defconfig b/arch/mips/configs/e55_defconfig
index 8fbfc06..263cc38 100644
--- a/arch/mips/configs/e55_defconfig
+++ b/arch/mips/configs/e55_defconfig
@@ -71,6 +71,7 @@ CONFIG_CASIO_E55=y
 # CONFIG_ZAO_CAPCELLA is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
diff --git a/arch/mips/configs/ev64120_defconfig b/arch/mips/configs/ev64120_defconfig
index f2d43be..e0d7e07 100644
--- a/arch/mips/configs/ev64120_defconfig
+++ b/arch/mips/configs/ev64120_defconfig
@@ -66,6 +66,7 @@ CONFIG_MIPS_EV64120=y
 # CONFIG_EVB_PCI1 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_CPU_BIG_ENDIAN=y
diff --git a/arch/mips/configs/ev96100_defconfig b/arch/mips/configs/ev96100_defconfig
index ac5841c..095bfe3 100644
--- a/arch/mips/configs/ev96100_defconfig
+++ b/arch/mips/configs/ev96100_defconfig
@@ -65,6 +65,7 @@ CONFIG_MIPS_EV96100=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_CPU_BIG_ENDIAN=y
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index 42d5cd7..f66ba91 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -65,6 +65,7 @@ CONFIG_SGI_IP22=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_ARC=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 8c40590..33f18c6 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -71,6 +71,7 @@ CONFIG_NUMA=y
 # CONFIG_REPLICATE_EXHANDLERS is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_ARC=y
 CONFIG_DMA_IP27=y
 CONFIG_CPU_BIG_ENDIAN=y
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index 7fdcaf5..2b8f223 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -65,6 +65,7 @@ CONFIG_SGI_IP32=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_ARC=y
 CONFIG_DMA_IP32=y
 CONFIG_DMA_NONCOHERENT=y
diff --git a/arch/mips/configs/it8172_defconfig b/arch/mips/configs/it8172_defconfig
index c716996..a5ac713 100644
--- a/arch/mips/configs/it8172_defconfig
+++ b/arch/mips/configs/it8172_defconfig
@@ -66,6 +66,7 @@ CONFIG_MIPS_ITE8172=y
 # CONFIG_IT8172_REVC is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
diff --git a/arch/mips/configs/ivr_defconfig b/arch/mips/configs/ivr_defconfig
index a8376d1..3cf9750 100644
--- a/arch/mips/configs/ivr_defconfig
+++ b/arch/mips/configs/ivr_defconfig
@@ -65,6 +65,7 @@ CONFIG_MIPS_IVR=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
diff --git a/arch/mips/configs/jaguar-atx_defconfig b/arch/mips/configs/jaguar-atx_defconfig
index 3160153..9f6303d 100644
--- a/arch/mips/configs/jaguar-atx_defconfig
+++ b/arch/mips/configs/jaguar-atx_defconfig
@@ -66,6 +66,7 @@ CONFIG_MOMENCO_JAGUAR_ATX=y
 CONFIG_JAGUAR_DMALOW=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_LIMITED_DMA=y
diff --git a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
index 53fbef1..a2ce2e1 100644
--- a/arch/mips/configs/jmr3927_defconfig
+++ b/arch/mips/configs/jmr3927_defconfig
@@ -65,6 +65,7 @@ CONFIG_TOSHIBA_JMR3927=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_CPU_BIG_ENDIAN=y
diff --git a/arch/mips/configs/lasat200_defconfig b/arch/mips/configs/lasat200_defconfig
index ef0fa9f..d742529 100644
--- a/arch/mips/configs/lasat200_defconfig
+++ b/arch/mips/configs/lasat200_defconfig
@@ -69,6 +69,7 @@ CONFIG_DS1603=y
 CONFIG_LASAT_SYSCTL=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_MIPS_NILE4=y
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 367d279..50c8679 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -65,6 +65,7 @@ CONFIG_MIPS_MALTA=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
diff --git a/arch/mips/configs/mipssim_defconfig b/arch/mips/configs/mipssim_defconfig
index fe78961..4b3342c 100644
--- a/arch/mips/configs/mipssim_defconfig
+++ b/arch/mips/configs/mipssim_defconfig
@@ -65,6 +65,7 @@ CONFIG_MIPS_SIM=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
diff --git a/arch/mips/configs/mpc30x_defconfig b/arch/mips/configs/mpc30x_defconfig
index e4620e7..3e75368 100644
--- a/arch/mips/configs/mpc30x_defconfig
+++ b/arch/mips/configs/mpc30x_defconfig
@@ -73,6 +73,7 @@ CONFIG_PCI_VR41XX=y
 CONFIG_VRC4173=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
diff --git a/arch/mips/configs/ocelot_3_defconfig b/arch/mips/configs/ocelot_3_defconfig
index 925d8ad..4197ac3 100644
--- a/arch/mips/configs/ocelot_3_defconfig
+++ b/arch/mips/configs/ocelot_3_defconfig
@@ -65,6 +65,7 @@ CONFIG_MOMENCO_OCELOT_3=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_CPU_BIG_ENDIAN=y
diff --git a/arch/mips/configs/ocelot_c_defconfig b/arch/mips/configs/ocelot_c_defconfig
index ee1cf9b..da777cb 100644
--- a/arch/mips/configs/ocelot_c_defconfig
+++ b/arch/mips/configs/ocelot_c_defconfig
@@ -65,6 +65,7 @@ CONFIG_MOMENCO_OCELOT_C=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_CPU_BIG_ENDIAN=y
diff --git a/arch/mips/configs/ocelot_defconfig b/arch/mips/configs/ocelot_defconfig
index d80ff27..9ff6ab5 100644
--- a/arch/mips/configs/ocelot_defconfig
+++ b/arch/mips/configs/ocelot_defconfig
@@ -65,6 +65,7 @@ CONFIG_MOMENCO_OCELOT=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_CPU_BIG_ENDIAN=y
diff --git a/arch/mips/configs/ocelot_g_defconfig b/arch/mips/configs/ocelot_g_defconfig
index c0f508d..7df9ce9 100644
--- a/arch/mips/configs/ocelot_g_defconfig
+++ b/arch/mips/configs/ocelot_g_defconfig
@@ -65,6 +65,7 @@ CONFIG_MOMENCO_OCELOT_G=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_CPU_BIG_ENDIAN=y
diff --git a/arch/mips/configs/pb1100_defconfig b/arch/mips/configs/pb1100_defconfig
index 194b3c7..fc28746 100644
--- a/arch/mips/configs/pb1100_defconfig
+++ b/arch/mips/configs/pb1100_defconfig
@@ -65,6 +65,7 @@ CONFIG_MIPS_PB1100=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
diff --git a/arch/mips/configs/pb1500_defconfig b/arch/mips/configs/pb1500_defconfig
index 8985725..a09be54 100644
--- a/arch/mips/configs/pb1500_defconfig
+++ b/arch/mips/configs/pb1500_defconfig
@@ -65,6 +65,7 @@ CONFIG_MIPS_PB1500=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
diff --git a/arch/mips/configs/pb1550_defconfig b/arch/mips/configs/pb1550_defconfig
index adbf997..b8bcbc2 100644
--- a/arch/mips/configs/pb1550_defconfig
+++ b/arch/mips/configs/pb1550_defconfig
@@ -65,6 +65,7 @@ CONFIG_MIPS_PB1550=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
diff --git a/arch/mips/configs/pnx8550-jbs_defconfig b/arch/mips/configs/pnx8550-jbs_defconfig
index b5db700..91ff3ba 100644
--- a/arch/mips/configs/pnx8550-jbs_defconfig
+++ b/arch/mips/configs/pnx8550-jbs_defconfig
@@ -65,6 +65,7 @@ CONFIG_PNX8550_JBS=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
diff --git a/arch/mips/configs/pnx8550-v2pci_defconfig b/arch/mips/configs/pnx8550-v2pci_defconfig
index 4187287..932c803 100644
--- a/arch/mips/configs/pnx8550-v2pci_defconfig
+++ b/arch/mips/configs/pnx8550-v2pci_defconfig
@@ -65,6 +65,7 @@ CONFIG_PNX8550_V2PCI=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
diff --git a/arch/mips/configs/qemu_defconfig b/arch/mips/configs/qemu_defconfig
index 31f5afa..0d3ce64 100644
--- a/arch/mips/configs/qemu_defconfig
+++ b/arch/mips/configs/qemu_defconfig
@@ -65,6 +65,7 @@ CONFIG_QEMU=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_COHERENT=y
 CONFIG_GENERIC_ISA_DMA=y
 CONFIG_I8259=y
diff --git a/arch/mips/configs/rbhma4500_defconfig b/arch/mips/configs/rbhma4500_defconfig
index b126f76..0ad74a5 100644
--- a/arch/mips/configs/rbhma4500_defconfig
+++ b/arch/mips/configs/rbhma4500_defconfig
@@ -72,6 +72,7 @@ CONFIG_TOSHIBA_RBTX4938_MPLEX_PIO58_61=y
 # CONFIG_TOSHIBA_RBTX4938_MPLEX_ATA is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_GENERIC_ISA_DMA=y
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index 463ed3d..fab27fe 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -65,6 +65,7 @@ CONFIG_SNI_RM200_PCI=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_ARC=y
 CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_DMA_NONCOHERENT=y
diff --git a/arch/mips/configs/sb1250-swarm_defconfig b/arch/mips/configs/sb1250-swarm_defconfig
index da68c3f..9060622 100644
--- a/arch/mips/configs/sb1250-swarm_defconfig
+++ b/arch/mips/configs/sb1250-swarm_defconfig
@@ -82,6 +82,7 @@ CONFIG_SIBYTE_CFE=y
 # CONFIG_SIBYTE_TBPROF is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_COHERENT=y
 CONFIG_CPU_BIG_ENDIAN=y
 # CONFIG_CPU_LITTLE_ENDIAN is not set
diff --git a/arch/mips/configs/sead_defconfig b/arch/mips/configs/sead_defconfig
index 9a936d7..de02881 100644
--- a/arch/mips/configs/sead_defconfig
+++ b/arch/mips/configs/sead_defconfig
@@ -65,6 +65,7 @@ CONFIG_MIPS_SEAD=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
diff --git a/arch/mips/configs/tb0226_defconfig b/arch/mips/configs/tb0226_defconfig
index c2dee0d..8f4f06c 100644
--- a/arch/mips/configs/tb0226_defconfig
+++ b/arch/mips/configs/tb0226_defconfig
@@ -75,6 +75,7 @@ CONFIG_PCI_VR41XX=y
 # CONFIG_VRC4173 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
diff --git a/arch/mips/configs/tb0229_defconfig b/arch/mips/configs/tb0229_defconfig
index be99261..5f54e27 100644
--- a/arch/mips/configs/tb0229_defconfig
+++ b/arch/mips/configs/tb0229_defconfig
@@ -75,6 +75,7 @@ CONFIG_PCI_VR41XX=y
 # CONFIG_VRC4173 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
diff --git a/arch/mips/configs/tb0287_defconfig b/arch/mips/configs/tb0287_defconfig
index 8a1e3ac..fe3ba4f 100644
--- a/arch/mips/configs/tb0287_defconfig
+++ b/arch/mips/configs/tb0287_defconfig
@@ -75,6 +75,7 @@ CONFIG_PCI_VR41XX=y
 # CONFIG_VRC4173 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
diff --git a/arch/mips/configs/workpad_defconfig b/arch/mips/configs/workpad_defconfig
index 7132e29..bd5bd46 100644
--- a/arch/mips/configs/workpad_defconfig
+++ b/arch/mips/configs/workpad_defconfig
@@ -71,6 +71,7 @@ CONFIG_IBM_WORKPAD=y
 # CONFIG_ZAO_CAPCELLA is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
diff --git a/arch/mips/configs/yosemite_defconfig b/arch/mips/configs/yosemite_defconfig
index 6745785..2c0c25e 100644
--- a/arch/mips/configs/yosemite_defconfig
+++ b/arch/mips/configs/yosemite_defconfig
@@ -66,6 +66,7 @@ CONFIG_PMC_YOSEMITE=y
 # CONFIG_HYPERTRANSPORT is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_COHERENT=y
 CONFIG_CPU_BIG_ENDIAN=y
 # CONFIG_CPU_LITTLE_ENDIAN is not set
diff --git a/arch/mips/defconfig b/arch/mips/defconfig
index 42d5cd7..f66ba91 100644
--- a/arch/mips/defconfig
+++ b/arch/mips/defconfig
@@ -65,6 +65,7 @@ CONFIG_SGI_IP22=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_ARC=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
