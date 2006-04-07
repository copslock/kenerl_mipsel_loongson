Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2006 16:52:29 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:10978 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133574AbWDGPwL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Apr 2006 16:52:11 +0100
Received: from localhost (p8176-ipad03funabasi.chiba.ocn.ne.jp [219.160.88.176])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DF1FDAB90; Sat,  8 Apr 2006 01:03:29 +0900 (JST)
Date:	Sat, 08 Apr 2006 01:03:48 +0900 (JST)
Message-Id: <20060408.010348.41197502.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] use CONFIG_HZ
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060407115323.GB5909@linux-mips.org>
References: <20060407.011000.77652835.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0604071156350.25570@blysk.ds.pg.gda.pl>
	<20060407115323.GB5909@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Take 2.

Make HZ configurable (DECSTATION can select 128/256/1024 HZ, JAZZ can
only select 100 HZ, others can select 48/100/128/250/256/1000/1024
HZ).  Also remove all mach-xxx/param.h files and update all defconfigs
according to current HZ value.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 b/arch/mips/Kconfig                         |   75 ++++++++++++++++++++++++++++
 b/arch/mips/configs/atlas_defconfig         |    9 +++
 b/arch/mips/configs/bigsur_defconfig        |    9 +++
 b/arch/mips/configs/capcella_defconfig      |    9 +++
 b/arch/mips/configs/cobalt_defconfig        |    9 +++
 b/arch/mips/configs/db1000_defconfig        |    9 +++
 b/arch/mips/configs/db1100_defconfig        |    9 +++
 b/arch/mips/configs/db1200_defconfig        |    9 +++
 b/arch/mips/configs/db1500_defconfig        |    9 +++
 b/arch/mips/configs/db1550_defconfig        |    9 +++
 b/arch/mips/configs/ddb5476_defconfig       |    9 +++
 b/arch/mips/configs/ddb5477_defconfig       |    9 +++
 b/arch/mips/configs/decstation_defconfig    |   11 ++++
 b/arch/mips/configs/e55_defconfig           |    9 +++
 b/arch/mips/configs/ev64120_defconfig       |    9 +++
 b/arch/mips/configs/ev96100_defconfig       |    9 +++
 b/arch/mips/configs/ip22_defconfig          |    9 +++
 b/arch/mips/configs/ip27_defconfig          |    9 +++
 b/arch/mips/configs/ip32_defconfig          |    9 +++
 b/arch/mips/configs/it8172_defconfig        |    9 +++
 b/arch/mips/configs/ivr_defconfig           |    9 +++
 b/arch/mips/configs/jaguar-atx_defconfig    |    9 +++
 b/arch/mips/configs/jmr3927_defconfig       |    9 +++
 b/arch/mips/configs/lasat200_defconfig      |    9 +++
 b/arch/mips/configs/malta_defconfig         |    9 +++
 b/arch/mips/configs/mipssim_defconfig       |    9 +++
 b/arch/mips/configs/mpc30x_defconfig        |    9 +++
 b/arch/mips/configs/ocelot_3_defconfig      |    9 +++
 b/arch/mips/configs/ocelot_c_defconfig      |    9 +++
 b/arch/mips/configs/ocelot_defconfig        |    9 +++
 b/arch/mips/configs/ocelot_g_defconfig      |    9 +++
 b/arch/mips/configs/pb1100_defconfig        |    9 +++
 b/arch/mips/configs/pb1500_defconfig        |    9 +++
 b/arch/mips/configs/pb1550_defconfig        |    9 +++
 b/arch/mips/configs/pnx8550-jbs_defconfig   |    9 +++
 b/arch/mips/configs/pnx8550-v2pci_defconfig |    9 +++
 b/arch/mips/configs/qemu_defconfig          |    9 +++
 b/arch/mips/configs/rbhma4500_defconfig     |    9 +++
 b/arch/mips/configs/rm200_defconfig         |    9 +++
 b/arch/mips/configs/sb1250-swarm_defconfig  |    9 +++
 b/arch/mips/configs/sead_defconfig          |    9 +++
 b/arch/mips/configs/tb0226_defconfig        |    9 +++
 b/arch/mips/configs/tb0229_defconfig        |    9 +++
 b/arch/mips/configs/tb0287_defconfig        |    9 +++
 b/arch/mips/configs/workpad_defconfig       |    9 +++
 b/arch/mips/configs/yosemite_defconfig      |    9 +++
 b/arch/mips/dec/time.c                      |    2 
 b/arch/mips/defconfig                       |    9 +++
 b/include/asm-mips/param.h                  |    2 
 include/asm-mips/mach-dec/param.h           |   18 ------
 include/asm-mips/mach-generic/param.h       |   13 ----
 include/asm-mips/mach-jazz/param.h          |   16 -----
 include/asm-mips/mach-mips/param.h          |   13 ----
 include/asm-mips/mach-qemu/param.h          |   13 ----
 54 files changed, 493 insertions(+), 75 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 71d9a4b..bebc4dc 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -142,6 +142,9 @@ config MACH_DECSTATION
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORT_128HZ
+	select SYS_SUPPORT_256HZ
+	select SYS_SUPPORT_1024HZ
 	help
 	  This enables support for DEC's MIPS based workstations.  For details
 	  see the Linux/MIPS FAQ on <http://www.linux-mips.org/> and the
@@ -239,6 +242,7 @@ config MACH_JAZZ
 	select SYS_HAS_CPU_R4X00
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
+	select SYS_SUPPORT_100HZ
 	help
 	 This a family of machines based on the MIPS R4030 chipset which was
 	 used by several vendors to build RISC/os and Windows NT workstations.
@@ -1652,6 +1656,77 @@ config NR_CPUS
 	  This is purely to save memory - each supported CPU adds
 	  approximately eight kilobytes to the kernel image.
 
+#
+# Timer Interrupt Frequency Configuration
+#
+
+choice
+	prompt "Timer frequency"
+	default HZ_250
+	help
+	 Allows the configuration of the timer frequency.
+
+	config HZ_48
+		bool "48 HZ" if SYS_SUPPORT_48HZ || SYS_SUPPORT_ARBIT_HZ
+
+	config HZ_100
+		bool "100 HZ" if SYS_SUPPORT_100HZ || SYS_SUPPORT_ARBIT_HZ
+
+	config HZ_128
+		bool "128 HZ" if SYS_SUPPORT_128HZ || SYS_SUPPORT_ARBIT_HZ
+
+	config HZ_250
+		bool "250 HZ" if SYS_SUPPORT_250HZ || SYS_SUPPORT_ARBIT_HZ
+
+	config HZ_256
+		bool "256 HZ" if SYS_SUPPORT_256HZ || SYS_SUPPORT_ARBIT_HZ
+
+	config HZ_1000
+		bool "1000 HZ" if SYS_SUPPORT_1000HZ || SYS_SUPPORT_ARBIT_HZ
+
+	config HZ_1024
+		bool "1024 HZ" if SYS_SUPPORT_1024HZ || SYS_SUPPORT_ARBIT_HZ
+
+endchoice
+
+config SYS_SUPPORT_48HZ
+	bool
+
+config SYS_SUPPORT_100HZ
+	bool
+
+config SYS_SUPPORT_128HZ
+	bool
+
+config SYS_SUPPORT_250HZ
+	bool
+
+config SYS_SUPPORT_256HZ
+	bool
+
+config SYS_SUPPORT_1000HZ
+	bool
+
+config SYS_SUPPORT_1024HZ
+	bool
+
+config SYS_SUPPORT_ARBIT_HZ
+	bool
+	default y if !SYS_SUPPORT_48HZ && !SYS_SUPPORT_100HZ && \
+		     !SYS_SUPPORT_128HZ && !SYS_SUPPORT_250HZ && \
+		     !SYS_SUPPORT_256HZ && !SYS_SUPPORT_1000HZ && \
+		     !SYS_SUPPORT_1024HZ
+
+config HZ
+	int
+	default 48 if HZ_48
+	default 100 if HZ_100
+	default 128 if HZ_128
+	default 250 if HZ_250
+	default 256 if HZ_256
+	default 1000 if HZ_1000
+	default 1024 if HZ_1024
+
 source "kernel/Kconfig.preempt"
 
 config RTC_DS1742
diff --git a/arch/mips/configs/atlas_defconfig b/arch/mips/configs/atlas_defconfig
index 80da9c8..4fb85d6 100644
--- a/arch/mips/configs/atlas_defconfig
+++ b/arch/mips/configs/atlas_defconfig
@@ -142,6 +142,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+CONFIG_HZ_100=y
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+# CONFIG_HZ_1000 is not set
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=100
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index 05566a2..c689c46 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -144,6 +144,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_SMP=y
 CONFIG_NR_CPUS=4
 CONFIG_PREEMPT_NONE=y
diff --git a/arch/mips/configs/capcella_defconfig b/arch/mips/configs/capcella_defconfig
index a69dafb..94f22a5 100644
--- a/arch/mips/configs/capcella_defconfig
+++ b/arch/mips/configs/capcella_defconfig
@@ -128,6 +128,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/cobalt_defconfig b/arch/mips/configs/cobalt_defconfig
index 6a4940b..7c5e630 100644
--- a/arch/mips/configs/cobalt_defconfig
+++ b/arch/mips/configs/cobalt_defconfig
@@ -128,6 +128,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/db1000_defconfig b/arch/mips/configs/db1000_defconfig
index 6d7bcc0..b0cd1cf 100644
--- a/arch/mips/configs/db1000_defconfig
+++ b/arch/mips/configs/db1000_defconfig
@@ -129,6 +129,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/db1100_defconfig b/arch/mips/configs/db1100_defconfig
index acd2ffe..b86b1d0 100644
--- a/arch/mips/configs/db1100_defconfig
+++ b/arch/mips/configs/db1100_defconfig
@@ -129,6 +129,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/db1200_defconfig b/arch/mips/configs/db1200_defconfig
index d918754..ede48fe 100644
--- a/arch/mips/configs/db1200_defconfig
+++ b/arch/mips/configs/db1200_defconfig
@@ -129,6 +129,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/db1500_defconfig b/arch/mips/configs/db1500_defconfig
index 5491a51..cd4ad89 100644
--- a/arch/mips/configs/db1500_defconfig
+++ b/arch/mips/configs/db1500_defconfig
@@ -131,6 +131,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/db1550_defconfig b/arch/mips/configs/db1550_defconfig
index 425d939..4547ae4 100644
--- a/arch/mips/configs/db1550_defconfig
+++ b/arch/mips/configs/db1550_defconfig
@@ -130,6 +130,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ddb5476_defconfig b/arch/mips/configs/ddb5476_defconfig
index 4837b3c..688432c 100644
--- a/arch/mips/configs/ddb5476_defconfig
+++ b/arch/mips/configs/ddb5476_defconfig
@@ -129,6 +129,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ddb5477_defconfig b/arch/mips/configs/ddb5477_defconfig
index e3a3786..2fe236b 100644
--- a/arch/mips/configs/ddb5477_defconfig
+++ b/arch/mips/configs/ddb5477_defconfig
@@ -129,6 +129,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/decstation_defconfig b/arch/mips/configs/decstation_defconfig
index b5b44a8..279383a 100644
--- a/arch/mips/configs/decstation_defconfig
+++ b/arch/mips/configs/decstation_defconfig
@@ -128,6 +128,17 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_128=y
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+# CONFIG_HZ_1000 is not set
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_128HZ=y
+CONFIG_SYS_SUPPORT_256HZ=y
+CONFIG_SYS_SUPPORT_1024HZ=y
+CONFIG_HZ=128
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/e55_defconfig b/arch/mips/configs/e55_defconfig
index 263cc38..2bf2571 100644
--- a/arch/mips/configs/e55_defconfig
+++ b/arch/mips/configs/e55_defconfig
@@ -126,6 +126,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ev64120_defconfig b/arch/mips/configs/ev64120_defconfig
index e0d7e07..206c95a 100644
--- a/arch/mips/configs/ev64120_defconfig
+++ b/arch/mips/configs/ev64120_defconfig
@@ -131,6 +131,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ev96100_defconfig b/arch/mips/configs/ev96100_defconfig
index 095bfe3..3acb5c1 100644
--- a/arch/mips/configs/ev96100_defconfig
+++ b/arch/mips/configs/ev96100_defconfig
@@ -135,6 +135,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index f66ba91..e6dd62d 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -136,6 +136,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 # CONFIG_PREEMPT_NONE is not set
 CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 33f18c6..78aa710 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -133,6 +133,15 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_NEED_MULTIPLE_NODES=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_MIGRATION=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=64
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index 2b8f223..3257acc 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -135,6 +135,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 # CONFIG_PREEMPT_NONE is not set
 CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/it8172_defconfig b/arch/mips/configs/it8172_defconfig
index a5ac713..fe2a125 100644
--- a/arch/mips/configs/it8172_defconfig
+++ b/arch/mips/configs/it8172_defconfig
@@ -130,6 +130,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ivr_defconfig b/arch/mips/configs/ivr_defconfig
index 3cf9750..cafb3fd 100644
--- a/arch/mips/configs/ivr_defconfig
+++ b/arch/mips/configs/ivr_defconfig
@@ -127,6 +127,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/jaguar-atx_defconfig b/arch/mips/configs/jaguar-atx_defconfig
index 9f6303d..76e4ece 100644
--- a/arch/mips/configs/jaguar-atx_defconfig
+++ b/arch/mips/configs/jaguar-atx_defconfig
@@ -136,6 +136,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 # CONFIG_SMP is not set
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
diff --git a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
index a2ce2e1..6258974 100644
--- a/arch/mips/configs/jmr3927_defconfig
+++ b/arch/mips/configs/jmr3927_defconfig
@@ -125,6 +125,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/lasat200_defconfig b/arch/mips/configs/lasat200_defconfig
index d742529..2e48af8 100644
--- a/arch/mips/configs/lasat200_defconfig
+++ b/arch/mips/configs/lasat200_defconfig
@@ -134,6 +134,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 50c8679..b1bb99a 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -148,6 +148,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+CONFIG_HZ_100=y
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+# CONFIG_HZ_1000 is not set
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=100
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/mipssim_defconfig b/arch/mips/configs/mipssim_defconfig
index 4b3342c..ca543ee 100644
--- a/arch/mips/configs/mipssim_defconfig
+++ b/arch/mips/configs/mipssim_defconfig
@@ -134,6 +134,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/mpc30x_defconfig b/arch/mips/configs/mpc30x_defconfig
index 3e75368..536f23a 100644
--- a/arch/mips/configs/mpc30x_defconfig
+++ b/arch/mips/configs/mpc30x_defconfig
@@ -128,6 +128,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ocelot_3_defconfig b/arch/mips/configs/ocelot_3_defconfig
index 4197ac3..b01f072 100644
--- a/arch/mips/configs/ocelot_3_defconfig
+++ b/arch/mips/configs/ocelot_3_defconfig
@@ -136,6 +136,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 # CONFIG_SMP is not set
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
diff --git a/arch/mips/configs/ocelot_c_defconfig b/arch/mips/configs/ocelot_c_defconfig
index da777cb..1e3ca9c 100644
--- a/arch/mips/configs/ocelot_c_defconfig
+++ b/arch/mips/configs/ocelot_c_defconfig
@@ -132,6 +132,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ocelot_defconfig b/arch/mips/configs/ocelot_defconfig
index 9ff6ab5..806dcca 100644
--- a/arch/mips/configs/ocelot_defconfig
+++ b/arch/mips/configs/ocelot_defconfig
@@ -137,6 +137,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ocelot_g_defconfig b/arch/mips/configs/ocelot_g_defconfig
index 7df9ce9..3d2a7d2 100644
--- a/arch/mips/configs/ocelot_g_defconfig
+++ b/arch/mips/configs/ocelot_g_defconfig
@@ -135,6 +135,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/pb1100_defconfig b/arch/mips/configs/pb1100_defconfig
index fc28746..74a08fe 100644
--- a/arch/mips/configs/pb1100_defconfig
+++ b/arch/mips/configs/pb1100_defconfig
@@ -131,6 +131,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/pb1500_defconfig b/arch/mips/configs/pb1500_defconfig
index a09be54..a5f5a0a 100644
--- a/arch/mips/configs/pb1500_defconfig
+++ b/arch/mips/configs/pb1500_defconfig
@@ -130,6 +130,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/pb1550_defconfig b/arch/mips/configs/pb1550_defconfig
index b8bcbc2..6b84d91 100644
--- a/arch/mips/configs/pb1550_defconfig
+++ b/arch/mips/configs/pb1550_defconfig
@@ -130,6 +130,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/pnx8550-jbs_defconfig b/arch/mips/configs/pnx8550-jbs_defconfig
index 91ff3ba..59c37d8 100644
--- a/arch/mips/configs/pnx8550-jbs_defconfig
+++ b/arch/mips/configs/pnx8550-jbs_defconfig
@@ -129,6 +129,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/pnx8550-v2pci_defconfig b/arch/mips/configs/pnx8550-v2pci_defconfig
index 932c803..4364d53 100644
--- a/arch/mips/configs/pnx8550-v2pci_defconfig
+++ b/arch/mips/configs/pnx8550-v2pci_defconfig
@@ -130,6 +130,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/qemu_defconfig b/arch/mips/configs/qemu_defconfig
index 0d3ce64..65fadff 100644
--- a/arch/mips/configs/qemu_defconfig
+++ b/arch/mips/configs/qemu_defconfig
@@ -126,6 +126,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+CONFIG_HZ_100=y
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+# CONFIG_HZ_1000 is not set
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=100
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/rbhma4500_defconfig b/arch/mips/configs/rbhma4500_defconfig
index 0ad74a5..b8693dd 100644
--- a/arch/mips/configs/rbhma4500_defconfig
+++ b/arch/mips/configs/rbhma4500_defconfig
@@ -138,6 +138,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index fab27fe..a18a42b 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -138,6 +138,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 # CONFIG_PREEMPT_NONE is not set
 CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/sb1250-swarm_defconfig b/arch/mips/configs/sb1250-swarm_defconfig
index 9060622..04948bc 100644
--- a/arch/mips/configs/sb1250-swarm_defconfig
+++ b/arch/mips/configs/sb1250-swarm_defconfig
@@ -148,6 +148,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_PREEMPT_NONE=y
diff --git a/arch/mips/configs/sead_defconfig b/arch/mips/configs/sead_defconfig
index de02881..d164819 100644
--- a/arch/mips/configs/sead_defconfig
+++ b/arch/mips/configs/sead_defconfig
@@ -133,6 +133,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/tb0226_defconfig b/arch/mips/configs/tb0226_defconfig
index 8f4f06c..a171722 100644
--- a/arch/mips/configs/tb0226_defconfig
+++ b/arch/mips/configs/tb0226_defconfig
@@ -130,6 +130,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/tb0229_defconfig b/arch/mips/configs/tb0229_defconfig
index 5f54e27..04b5ec2 100644
--- a/arch/mips/configs/tb0229_defconfig
+++ b/arch/mips/configs/tb0229_defconfig
@@ -130,6 +130,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/tb0287_defconfig b/arch/mips/configs/tb0287_defconfig
index fe3ba4f..90091d1 100644
--- a/arch/mips/configs/tb0287_defconfig
+++ b/arch/mips/configs/tb0287_defconfig
@@ -135,6 +135,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/workpad_defconfig b/arch/mips/configs/workpad_defconfig
index bd5bd46..5791c60 100644
--- a/arch/mips/configs/workpad_defconfig
+++ b/arch/mips/configs/workpad_defconfig
@@ -126,6 +126,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/yosemite_defconfig b/arch/mips/configs/yosemite_defconfig
index 2c0c25e..33fb507 100644
--- a/arch/mips/configs/yosemite_defconfig
+++ b/arch/mips/configs/yosemite_defconfig
@@ -130,6 +130,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_PREEMPT_NONE=y
diff --git a/arch/mips/dec/time.c b/arch/mips/dec/time.c
index 74cb055..76e4d09 100644
--- a/arch/mips/dec/time.c
+++ b/arch/mips/dec/time.c
@@ -181,7 +181,7 @@ void __init dec_time_init(void)
 	}
 
 	/* Set up the rate of periodic DS1287 interrupts.  */
-	CMOS_WRITE(RTC_REF_CLCK_32KHZ | (16 - LOG_2_HZ), RTC_REG_A);
+	CMOS_WRITE(RTC_REF_CLCK_32KHZ | (16 - __ffs(HZ)), RTC_REG_A);
 }
 
 EXPORT_SYMBOL(do_settimeofday);
diff --git a/arch/mips/defconfig b/arch/mips/defconfig
index f66ba91..e6dd62d 100644
--- a/arch/mips/defconfig
+++ b/arch/mips/defconfig
@@ -136,6 +136,15 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORT_ARBIT_HZ=y
+CONFIG_HZ=1000
 # CONFIG_PREEMPT_NONE is not set
 CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_PREEMPT is not set
diff --git a/include/asm-mips/mach-dec/param.h b/include/asm-mips/mach-dec/param.h
deleted file mode 100644
index 3e4f0e3..0000000
--- a/include/asm-mips/mach-dec/param.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2003 by Ralf Baechle
- */
-#ifndef __ASM_MACH_DEC_PARAM_H
-#define __ASM_MACH_DEC_PARAM_H
-
-/*
- * log2(HZ), change this here if you want another HZ value. This is also
- * used in dec_time_init.  Minimum is 1, Maximum is 15.
- */
-#define LOG_2_HZ 7
-#define HZ (1 << LOG_2_HZ)
-
-#endif /* __ASM_MACH_DEC_PARAM_H */
diff --git a/include/asm-mips/mach-generic/param.h b/include/asm-mips/mach-generic/param.h
deleted file mode 100644
index a0d12f9..0000000
--- a/include/asm-mips/mach-generic/param.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2003 by Ralf Baechle
- */
-#ifndef __ASM_MACH_GENERIC_PARAM_H
-#define __ASM_MACH_GENERIC_PARAM_H
-
-#define HZ		1000		/* Internal kernel timer frequency */
-
-#endif /* __ASM_MACH_GENERIC_PARAM_H */
diff --git a/include/asm-mips/mach-jazz/param.h b/include/asm-mips/mach-jazz/param.h
deleted file mode 100644
index 639763a..0000000
--- a/include/asm-mips/mach-jazz/param.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2003 by Ralf Baechle
- */
-#ifndef __ASM_MACH_JAZZ_PARAM_H
-#define __ASM_MACH_JAZZ_PARAM_H
-
-/*
- * Jazz is currently using the internal 100Hz timer of the R4030
- */
-#define HZ		100		/* Internal kernel timer frequency */
-
-#endif /* __ASM_MACH_JAZZ_PARAM_H */
diff --git a/include/asm-mips/mach-mips/param.h b/include/asm-mips/mach-mips/param.h
deleted file mode 100644
index 805ef6d..0000000
--- a/include/asm-mips/mach-mips/param.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2003 by Ralf Baechle
- */
-#ifndef __ASM_MACH_MIPS_PARAM_H
-#define __ASM_MACH_MIPS_PARAM_H
-
-#define HZ		100		/* Internal kernel timer frequency */
-
-#endif /* __ASM_MACH_MIPS_PARAM_H */
diff --git a/include/asm-mips/mach-qemu/param.h b/include/asm-mips/mach-qemu/param.h
deleted file mode 100644
index cb30ee4..0000000
--- a/include/asm-mips/mach-qemu/param.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2005 by Ralf Baechle
- */
-#ifndef __ASM_MACH_QEMU_PARAM_H
-#define __ASM_MACH_QEMU_PARAM_H
-
-#define HZ		100		/* Internal kernel timer frequency */
-
-#endif /* __ASM_MACH_QEMU_PARAM_H */
diff --git a/include/asm-mips/param.h b/include/asm-mips/param.h
index 2bead82..1d9bb8c 100644
--- a/include/asm-mips/param.h
+++ b/include/asm-mips/param.h
@@ -11,7 +11,7 @@
 
 #ifdef __KERNEL__
 
-# include <param.h>			/* Internal kernel timer frequency */
+# define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
 #endif
