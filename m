Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 15:42:36 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:58072 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037758AbWIZOmN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2006 15:42:13 +0100
Received: from localhost (p5240-ipad201funabasi.chiba.ocn.ne.jp [222.146.68.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EE9ED61EC; Tue, 26 Sep 2006 23:42:07 +0900 (JST)
Date:	Tue, 26 Sep 2006 23:44:16 +0900 (JST)
Message-Id: <20060926.234416.96685688.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, mingo@redhat.com
Subject: [PATCH 3/3] [MIPS] lockdep: update defconfigs
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 12675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add those lines to all defconfigs.

CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

This is a patch againt linux-mips.org git tree.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 configs/atlas_defconfig         |    3 +++
 configs/bigsur_defconfig        |    3 +++
 configs/capcella_defconfig      |    3 +++
 configs/cobalt_defconfig        |    3 +++
 configs/db1000_defconfig        |    3 +++
 configs/db1100_defconfig        |    3 +++
 configs/db1200_defconfig        |    3 +++
 configs/db1500_defconfig        |    3 +++
 configs/db1550_defconfig        |    3 +++
 configs/ddb5477_defconfig       |    3 +++
 configs/decstation_defconfig    |    3 +++
 configs/e55_defconfig           |    2 ++
 configs/emma2rh_defconfig       |    3 +++
 configs/ev64120_defconfig       |    3 +++
 configs/excite_defconfig        |    3 +++
 configs/ip22_defconfig          |    3 +++
 configs/ip27_defconfig          |    3 +++
 configs/ip32_defconfig          |    3 +++
 configs/it8172_defconfig        |    3 +++
 configs/ivr_defconfig           |    3 +++
 configs/jaguar-atx_defconfig    |    3 +++
 configs/jmr3927_defconfig       |    3 +++
 configs/lasat200_defconfig      |    3 +++
 configs/malta_defconfig         |    3 +++
 configs/mipssim_defconfig       |    3 +++
 configs/mpc30x_defconfig        |    2 ++
 configs/ocelot_3_defconfig      |    3 +++
 configs/ocelot_c_defconfig      |    3 +++
 configs/ocelot_defconfig        |    3 +++
 configs/ocelot_g_defconfig      |    3 +++
 configs/pb1100_defconfig        |    3 +++
 configs/pb1500_defconfig        |    3 +++
 configs/pb1550_defconfig        |    3 +++
 configs/pnx8550-jbs_defconfig   |    3 +++
 configs/pnx8550-v2pci_defconfig |    3 +++
 configs/qemu_defconfig          |    3 +++
 configs/rbhma4500_defconfig     |    3 +++
 configs/rm200_defconfig         |    3 +++
 configs/sb1250-swarm_defconfig  |    3 +++
 configs/sead_defconfig          |    3 +++
 configs/tb0226_defconfig        |    3 +++
 configs/tb0229_defconfig        |    3 +++
 configs/tb0287_defconfig        |    3 +++
 configs/workpad_defconfig       |    2 ++
 configs/wrppmc_defconfig        |    3 +++
 configs/yosemite_defconfig      |    3 +++
 defconfig                       |    3 +++
 47 files changed, 138 insertions(+)

diff --git a/arch/mips/configs/atlas_defconfig b/arch/mips/configs/atlas_defconfig
index d370528..35931be 100644
--- a/arch/mips/configs/atlas_defconfig
+++ b/arch/mips/configs/atlas_defconfig
@@ -161,6 +161,8 @@ CONFIG_HZ=100
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1304,6 +1306,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index e12a475..c6a0159 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -167,6 +167,8 @@ CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
 # CONFIG_PREEMPT_BKL is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -904,6 +906,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 CONFIG_PRINTK_TIME=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/capcella_defconfig b/arch/mips/configs/capcella_defconfig
index bfade9a..e535812 100644
--- a/arch/mips/configs/capcella_defconfig
+++ b/arch/mips/configs/capcella_defconfig
@@ -149,6 +149,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -891,6 +893,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/cobalt_defconfig b/arch/mips/configs/cobalt_defconfig
index 4baf2ff..adf1e8c 100644
--- a/arch/mips/configs/cobalt_defconfig
+++ b/arch/mips/configs/cobalt_defconfig
@@ -146,6 +146,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -889,6 +891,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/db1000_defconfig b/arch/mips/configs/db1000_defconfig
index 93cca15..4fd29ff 100644
--- a/arch/mips/configs/db1000_defconfig
+++ b/arch/mips/configs/db1000_defconfig
@@ -147,6 +147,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1006,6 +1008,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/db1100_defconfig b/arch/mips/configs/db1100_defconfig
index ffd9925..025b960 100644
--- a/arch/mips/configs/db1100_defconfig
+++ b/arch/mips/configs/db1100_defconfig
@@ -147,6 +147,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1006,6 +1008,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/db1200_defconfig b/arch/mips/configs/db1200_defconfig
index 63eac5e..80c9dd9 100644
--- a/arch/mips/configs/db1200_defconfig
+++ b/arch/mips/configs/db1200_defconfig
@@ -147,6 +147,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1087,6 +1089,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/db1500_defconfig b/arch/mips/configs/db1500_defconfig
index 25a095f..6caa90b 100644
--- a/arch/mips/configs/db1500_defconfig
+++ b/arch/mips/configs/db1500_defconfig
@@ -149,6 +149,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1290,6 +1292,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/db1550_defconfig b/arch/mips/configs/db1550_defconfig
index dda469c..c6cae86 100644
--- a/arch/mips/configs/db1550_defconfig
+++ b/arch/mips/configs/db1550_defconfig
@@ -148,6 +148,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1111,6 +1113,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/ddb5477_defconfig b/arch/mips/configs/ddb5477_defconfig
index fcd3dd1..72f2400 100644
--- a/arch/mips/configs/ddb5477_defconfig
+++ b/arch/mips/configs/ddb5477_defconfig
@@ -146,6 +146,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -852,6 +854,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/decstation_defconfig b/arch/mips/configs/decstation_defconfig
index 8683e0d..be901df 100644
--- a/arch/mips/configs/decstation_defconfig
+++ b/arch/mips/configs/decstation_defconfig
@@ -147,6 +147,8 @@ CONFIG_HZ=128
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -828,6 +830,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/e55_defconfig b/arch/mips/configs/e55_defconfig
index 4ace61c..6133c28 100644
--- a/arch/mips/configs/e55_defconfig
+++ b/arch/mips/configs/e55_defconfig
@@ -147,6 +147,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
diff --git a/arch/mips/configs/emma2rh_defconfig b/arch/mips/configs/emma2rh_defconfig
index 5847c91..a484b7d 100644
--- a/arch/mips/configs/emma2rh_defconfig
+++ b/arch/mips/configs/emma2rh_defconfig
@@ -147,6 +147,8 @@ # CONFIG_PREEMPT_NONE is not set
 # CONFIG_PREEMPT_VOLUNTARY is not set
 CONFIG_PREEMPT=y
 CONFIG_PREEMPT_BKL=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1180,6 +1182,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/ev64120_defconfig b/arch/mips/configs/ev64120_defconfig
index bc4c4f1..21bfcde 100644
--- a/arch/mips/configs/ev64120_defconfig
+++ b/arch/mips/configs/ev64120_defconfig
@@ -148,6 +148,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -842,6 +844,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/excite_defconfig b/arch/mips/configs/excite_defconfig
index eb87cbb..1a5b06c 100644
--- a/arch/mips/configs/excite_defconfig
+++ b/arch/mips/configs/excite_defconfig
@@ -149,6 +149,8 @@ # CONFIG_PREEMPT_NONE is not set
 # CONFIG_PREEMPT_VOLUNTARY is not set
 CONFIG_PREEMPT=y
 CONFIG_PREEMPT_BKL=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1184,6 +1186,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index cc9b24e..21d53e0 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -153,6 +153,8 @@ CONFIG_HZ=1000
 # CONFIG_PREEMPT_NONE is not set
 CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1147,6 +1149,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 50092ba..e3e94c7 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -162,6 +162,8 @@ # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
 CONFIG_PREEMPT_BKL=y
 # CONFIG_MIPS_INSANE_LARGE is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -980,6 +982,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index dec2ba6..b4ab2be 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -153,6 +153,8 @@ CONFIG_HZ=1000
 # CONFIG_PREEMPT_NONE is not set
 CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -922,6 +924,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/it8172_defconfig b/arch/mips/configs/it8172_defconfig
index 37f9dd7..18d20fb 100644
--- a/arch/mips/configs/it8172_defconfig
+++ b/arch/mips/configs/it8172_defconfig
@@ -147,6 +147,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -900,6 +902,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/ivr_defconfig b/arch/mips/configs/ivr_defconfig
index 18874a4..99831d0 100644
--- a/arch/mips/configs/ivr_defconfig
+++ b/arch/mips/configs/ivr_defconfig
@@ -144,6 +144,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -856,6 +858,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/jaguar-atx_defconfig b/arch/mips/configs/jaguar-atx_defconfig
index 9f1e304..9d4d17a 100644
--- a/arch/mips/configs/jaguar-atx_defconfig
+++ b/arch/mips/configs/jaguar-atx_defconfig
@@ -153,6 +153,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -775,6 +777,7 @@ # CONFIG_NLS is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
index fded3f7..d037466 100644
--- a/arch/mips/configs/jmr3927_defconfig
+++ b/arch/mips/configs/jmr3927_defconfig
@@ -143,6 +143,8 @@ CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
 CONFIG_RTC_DS1742=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -872,6 +874,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/lasat200_defconfig b/arch/mips/configs/lasat200_defconfig
index 320b8cd..1db8249 100644
--- a/arch/mips/configs/lasat200_defconfig
+++ b/arch/mips/configs/lasat200_defconfig
@@ -151,6 +151,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -970,6 +972,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 0ba1ef5..aeefe28 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -170,6 +170,8 @@ CONFIG_HZ=100
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1341,6 +1343,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/mipssim_defconfig b/arch/mips/configs/mipssim_defconfig
index adbeead..a3cbd23 100644
--- a/arch/mips/configs/mipssim_defconfig
+++ b/arch/mips/configs/mipssim_defconfig
@@ -148,6 +148,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -799,6 +801,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/mpc30x_defconfig b/arch/mips/configs/mpc30x_defconfig
index 79fd544..6570b47 100644
--- a/arch/mips/configs/mpc30x_defconfig
+++ b/arch/mips/configs/mpc30x_defconfig
@@ -148,6 +148,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
diff --git a/arch/mips/configs/ocelot_3_defconfig b/arch/mips/configs/ocelot_3_defconfig
index 4d87da2..440d65f 100644
--- a/arch/mips/configs/ocelot_3_defconfig
+++ b/arch/mips/configs/ocelot_3_defconfig
@@ -153,6 +153,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1091,6 +1093,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/ocelot_c_defconfig b/arch/mips/configs/ocelot_c_defconfig
index a7ac2b0..c2c7ae7 100644
--- a/arch/mips/configs/ocelot_c_defconfig
+++ b/arch/mips/configs/ocelot_c_defconfig
@@ -150,6 +150,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -839,6 +841,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/ocelot_defconfig b/arch/mips/configs/ocelot_defconfig
index 853e7bb..67efe27 100644
--- a/arch/mips/configs/ocelot_defconfig
+++ b/arch/mips/configs/ocelot_defconfig
@@ -154,6 +154,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -788,6 +790,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/ocelot_g_defconfig b/arch/mips/configs/ocelot_g_defconfig
index 8524efa..a10f34d 100644
--- a/arch/mips/configs/ocelot_g_defconfig
+++ b/arch/mips/configs/ocelot_g_defconfig
@@ -153,6 +153,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -842,6 +844,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/pb1100_defconfig b/arch/mips/configs/pb1100_defconfig
index 1a16e92..741f825 100644
--- a/arch/mips/configs/pb1100_defconfig
+++ b/arch/mips/configs/pb1100_defconfig
@@ -149,6 +149,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1000,6 +1002,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/pb1500_defconfig b/arch/mips/configs/pb1500_defconfig
index 9ea8ede..8576340 100644
--- a/arch/mips/configs/pb1500_defconfig
+++ b/arch/mips/configs/pb1500_defconfig
@@ -148,6 +148,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1106,6 +1108,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/pb1550_defconfig b/arch/mips/configs/pb1550_defconfig
index c4a1589..3db7427 100644
--- a/arch/mips/configs/pb1550_defconfig
+++ b/arch/mips/configs/pb1550_defconfig
@@ -148,6 +148,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1098,6 +1100,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/pnx8550-jbs_defconfig b/arch/mips/configs/pnx8550-jbs_defconfig
index 1cbf270..26b0b98 100644
--- a/arch/mips/configs/pnx8550-jbs_defconfig
+++ b/arch/mips/configs/pnx8550-jbs_defconfig
@@ -153,6 +153,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -876,6 +878,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/pnx8550-v2pci_defconfig b/arch/mips/configs/pnx8550-v2pci_defconfig
index bec30b1..e93266b 100644
--- a/arch/mips/configs/pnx8550-v2pci_defconfig
+++ b/arch/mips/configs/pnx8550-v2pci_defconfig
@@ -153,6 +153,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1057,6 +1059,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/qemu_defconfig b/arch/mips/configs/qemu_defconfig
index f5f799e..9b0dab8 100644
--- a/arch/mips/configs/qemu_defconfig
+++ b/arch/mips/configs/qemu_defconfig
@@ -145,6 +145,8 @@ CONFIG_HZ=100
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -733,6 +735,7 @@ # CONFIG_NLS is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/rbhma4500_defconfig b/arch/mips/configs/rbhma4500_defconfig
index 2f56502..dd02960 100644
--- a/arch/mips/configs/rbhma4500_defconfig
+++ b/arch/mips/configs/rbhma4500_defconfig
@@ -155,6 +155,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1335,6 +1337,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index 4fee90b..d8a498d 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -158,6 +158,8 @@ CONFIG_HZ=1000
 # CONFIG_PREEMPT_NONE is not set
 CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1584,6 +1586,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/sb1250-swarm_defconfig b/arch/mips/configs/sb1250-swarm_defconfig
index 9041f09..805a4fe 100644
--- a/arch/mips/configs/sb1250-swarm_defconfig
+++ b/arch/mips/configs/sb1250-swarm_defconfig
@@ -171,6 +171,8 @@ CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
 CONFIG_PREEMPT_BKL=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -873,6 +875,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/sead_defconfig b/arch/mips/configs/sead_defconfig
index 02abb2f..6fcb656 100644
--- a/arch/mips/configs/sead_defconfig
+++ b/arch/mips/configs/sead_defconfig
@@ -151,6 +151,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -581,6 +583,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/tb0226_defconfig b/arch/mips/configs/tb0226_defconfig
index ca3d0c4..dc312f1 100644
--- a/arch/mips/configs/tb0226_defconfig
+++ b/arch/mips/configs/tb0226_defconfig
@@ -151,6 +151,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1059,6 +1061,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/tb0229_defconfig b/arch/mips/configs/tb0229_defconfig
index 4e2009a..85615d9 100644
--- a/arch/mips/configs/tb0229_defconfig
+++ b/arch/mips/configs/tb0229_defconfig
@@ -151,6 +151,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -968,6 +970,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/tb0287_defconfig b/arch/mips/configs/tb0287_defconfig
index 535a813..ad7271b 100644
--- a/arch/mips/configs/tb0287_defconfig
+++ b/arch/mips/configs/tb0287_defconfig
@@ -151,6 +151,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1146,6 +1148,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/workpad_defconfig b/arch/mips/configs/workpad_defconfig
index 3a3ef20..863f6a7 100644
--- a/arch/mips/configs/workpad_defconfig
+++ b/arch/mips/configs/workpad_defconfig
@@ -147,6 +147,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
diff --git a/arch/mips/configs/wrppmc_defconfig b/arch/mips/configs/wrppmc_defconfig
index e6b1dea..c10267d 100644
--- a/arch/mips/configs/wrppmc_defconfig
+++ b/arch/mips/configs/wrppmc_defconfig
@@ -155,6 +155,8 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -829,6 +831,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/configs/yosemite_defconfig b/arch/mips/configs/yosemite_defconfig
index 06a072b..4d3c132 100644
--- a/arch/mips/configs/yosemite_defconfig
+++ b/arch/mips/configs/yosemite_defconfig
@@ -152,6 +152,8 @@ CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
 CONFIG_PREEMPT_BKL=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -760,6 +762,7 @@ # CONFIG_NLS is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
diff --git a/arch/mips/defconfig b/arch/mips/defconfig
index cc9b24e..21d53e0 100644
--- a/arch/mips/defconfig
+++ b/arch/mips/defconfig
@@ -153,6 +153,8 @@ CONFIG_HZ=1000
 # CONFIG_PREEMPT_NONE is not set
 CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_PREEMPT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -1147,6 +1149,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
