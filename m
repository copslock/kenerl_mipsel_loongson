Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2006 16:58:39 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:57557 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133522AbWDFP60 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2006 16:58:26 +0100
Received: from localhost (p7200-ipad30funabasi.chiba.ocn.ne.jp [221.184.82.200])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BD6DDAAC7; Fri,  7 Apr 2006 01:09:41 +0900 (JST)
Date:	Fri, 07 Apr 2006 01:10:00 +0900 (JST)
Message-Id: <20060407.011000.77652835.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] use CONFIG_HZ
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
X-archive-position: 11051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Make HZ configurable (except for DECSTATION which is using special HZ
value which is out of choice).  Also remove some param.h files and
update all defconfigs according to current HZ value (except for JAZZ
which does not have defconfig).

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 b/arch/mips/Kconfig                         |    3 +++
 b/arch/mips/configs/atlas_defconfig         |    4 ++++
 b/arch/mips/configs/bigsur_defconfig        |    4 ++++
 b/arch/mips/configs/capcella_defconfig      |    4 ++++
 b/arch/mips/configs/cobalt_defconfig        |    4 ++++
 b/arch/mips/configs/db1000_defconfig        |    4 ++++
 b/arch/mips/configs/db1100_defconfig        |    4 ++++
 b/arch/mips/configs/db1200_defconfig        |    4 ++++
 b/arch/mips/configs/db1500_defconfig        |    4 ++++
 b/arch/mips/configs/db1550_defconfig        |    4 ++++
 b/arch/mips/configs/ddb5476_defconfig       |    4 ++++
 b/arch/mips/configs/ddb5477_defconfig       |    4 ++++
 b/arch/mips/configs/e55_defconfig           |    4 ++++
 b/arch/mips/configs/ev64120_defconfig       |    4 ++++
 b/arch/mips/configs/ev96100_defconfig       |    4 ++++
 b/arch/mips/configs/ip22_defconfig          |    4 ++++
 b/arch/mips/configs/ip27_defconfig          |    4 ++++
 b/arch/mips/configs/ip32_defconfig          |    4 ++++
 b/arch/mips/configs/it8172_defconfig        |    4 ++++
 b/arch/mips/configs/ivr_defconfig           |    4 ++++
 b/arch/mips/configs/jaguar-atx_defconfig    |    4 ++++
 b/arch/mips/configs/jmr3927_defconfig       |    4 ++++
 b/arch/mips/configs/lasat200_defconfig      |    4 ++++
 b/arch/mips/configs/malta_defconfig         |    4 ++++
 b/arch/mips/configs/mipssim_defconfig       |    4 ++++
 b/arch/mips/configs/mpc30x_defconfig        |    4 ++++
 b/arch/mips/configs/ocelot_3_defconfig      |    4 ++++
 b/arch/mips/configs/ocelot_c_defconfig      |    4 ++++
 b/arch/mips/configs/ocelot_defconfig        |    4 ++++
 b/arch/mips/configs/ocelot_g_defconfig      |    4 ++++
 b/arch/mips/configs/pb1100_defconfig        |    4 ++++
 b/arch/mips/configs/pb1500_defconfig        |    4 ++++
 b/arch/mips/configs/pb1550_defconfig        |    4 ++++
 b/arch/mips/configs/pnx8550-jbs_defconfig   |    4 ++++
 b/arch/mips/configs/pnx8550-v2pci_defconfig |    4 ++++
 b/arch/mips/configs/qemu_defconfig          |    4 ++++
 b/arch/mips/configs/rbhma4500_defconfig     |    4 ++++
 b/arch/mips/configs/rm200_defconfig         |    4 ++++
 b/arch/mips/configs/sb1250-swarm_defconfig  |    4 ++++
 b/arch/mips/configs/sead_defconfig          |    4 ++++
 b/arch/mips/configs/tb0226_defconfig        |    4 ++++
 b/arch/mips/configs/tb0229_defconfig        |    4 ++++
 b/arch/mips/configs/tb0287_defconfig        |    4 ++++
 b/arch/mips/configs/workpad_defconfig       |    4 ++++
 b/arch/mips/configs/yosemite_defconfig      |    4 ++++
 b/arch/mips/defconfig                       |    4 ++++
 b/include/asm-mips/mach-generic/param.h     |    2 +-
 include/asm-mips/mach-jazz/param.h          |   16 ----------------
 include/asm-mips/mach-mips/param.h          |   13 -------------
 include/asm-mips/mach-qemu/param.h          |   13 -------------
 50 files changed, 184 insertions(+), 43 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 71d9a4b..dfc6764 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1652,6 +1652,9 @@ config NR_CPUS
 	  This is purely to save memory - each supported CPU adds
 	  approximately eight kilobytes to the kernel image.
 
+if !MACH_DECSTATION
+source "kernel/Kconfig.hz"
+endif
 source "kernel/Kconfig.preempt"
 
 config RTC_DS1742
diff --git a/arch/mips/configs/atlas_defconfig b/arch/mips/configs/atlas_defconfig
index 80da9c8..ffbecbf 100644
--- a/arch/mips/configs/atlas_defconfig
+++ b/arch/mips/configs/atlas_defconfig
@@ -142,6 +142,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_HZ_100=y
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=100
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index 05566a2..139b259 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -144,6 +144,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_SMP=y
 CONFIG_NR_CPUS=4
 CONFIG_PREEMPT_NONE=y
diff --git a/arch/mips/configs/capcella_defconfig b/arch/mips/configs/capcella_defconfig
index a69dafb..bb987ed 100644
--- a/arch/mips/configs/capcella_defconfig
+++ b/arch/mips/configs/capcella_defconfig
@@ -128,6 +128,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/cobalt_defconfig b/arch/mips/configs/cobalt_defconfig
index 6a4940b..6e4d516 100644
--- a/arch/mips/configs/cobalt_defconfig
+++ b/arch/mips/configs/cobalt_defconfig
@@ -128,6 +128,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/db1000_defconfig b/arch/mips/configs/db1000_defconfig
index 6d7bcc0..06edc5a 100644
--- a/arch/mips/configs/db1000_defconfig
+++ b/arch/mips/configs/db1000_defconfig
@@ -129,6 +129,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/db1100_defconfig b/arch/mips/configs/db1100_defconfig
index acd2ffe..1ee44b1 100644
--- a/arch/mips/configs/db1100_defconfig
+++ b/arch/mips/configs/db1100_defconfig
@@ -129,6 +129,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/db1200_defconfig b/arch/mips/configs/db1200_defconfig
index d918754..60b46e8 100644
--- a/arch/mips/configs/db1200_defconfig
+++ b/arch/mips/configs/db1200_defconfig
@@ -129,6 +129,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/db1500_defconfig b/arch/mips/configs/db1500_defconfig
index 5491a51..6d37ec3 100644
--- a/arch/mips/configs/db1500_defconfig
+++ b/arch/mips/configs/db1500_defconfig
@@ -131,6 +131,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/db1550_defconfig b/arch/mips/configs/db1550_defconfig
index 425d939..497e1c6 100644
--- a/arch/mips/configs/db1550_defconfig
+++ b/arch/mips/configs/db1550_defconfig
@@ -130,6 +130,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ddb5476_defconfig b/arch/mips/configs/ddb5476_defconfig
index 4837b3c..340d3ad 100644
--- a/arch/mips/configs/ddb5476_defconfig
+++ b/arch/mips/configs/ddb5476_defconfig
@@ -129,6 +129,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ddb5477_defconfig b/arch/mips/configs/ddb5477_defconfig
index e3a3786..7be250d 100644
--- a/arch/mips/configs/ddb5477_defconfig
+++ b/arch/mips/configs/ddb5477_defconfig
@@ -129,6 +129,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/e55_defconfig b/arch/mips/configs/e55_defconfig
index 263cc38..3919ae8 100644
--- a/arch/mips/configs/e55_defconfig
+++ b/arch/mips/configs/e55_defconfig
@@ -126,6 +126,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ev64120_defconfig b/arch/mips/configs/ev64120_defconfig
index e0d7e07..a0777ff 100644
--- a/arch/mips/configs/ev64120_defconfig
+++ b/arch/mips/configs/ev64120_defconfig
@@ -131,6 +131,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ev96100_defconfig b/arch/mips/configs/ev96100_defconfig
index 095bfe3..717dc9b 100644
--- a/arch/mips/configs/ev96100_defconfig
+++ b/arch/mips/configs/ev96100_defconfig
@@ -135,6 +135,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index f66ba91..cd82a4a 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -136,6 +136,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 # CONFIG_PREEMPT_NONE is not set
 CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 33f18c6..1c3e692 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -133,6 +133,10 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_NEED_MULTIPLE_NODES=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_MIGRATION=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=64
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index 2b8f223..9eeb18e 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -135,6 +135,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 # CONFIG_PREEMPT_NONE is not set
 CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/it8172_defconfig b/arch/mips/configs/it8172_defconfig
index a5ac713..9009bae 100644
--- a/arch/mips/configs/it8172_defconfig
+++ b/arch/mips/configs/it8172_defconfig
@@ -130,6 +130,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ivr_defconfig b/arch/mips/configs/ivr_defconfig
index 3cf9750..5602579 100644
--- a/arch/mips/configs/ivr_defconfig
+++ b/arch/mips/configs/ivr_defconfig
@@ -127,6 +127,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/jaguar-atx_defconfig b/arch/mips/configs/jaguar-atx_defconfig
index 9f6303d..6a2009f 100644
--- a/arch/mips/configs/jaguar-atx_defconfig
+++ b/arch/mips/configs/jaguar-atx_defconfig
@@ -136,6 +136,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 # CONFIG_SMP is not set
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
diff --git a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
index a2ce2e1..a9eb001 100644
--- a/arch/mips/configs/jmr3927_defconfig
+++ b/arch/mips/configs/jmr3927_defconfig
@@ -125,6 +125,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/lasat200_defconfig b/arch/mips/configs/lasat200_defconfig
index d742529..bc755a3 100644
--- a/arch/mips/configs/lasat200_defconfig
+++ b/arch/mips/configs/lasat200_defconfig
@@ -134,6 +134,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 50c8679..1ad6480 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -148,6 +148,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_HZ_100=y
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=100
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/mipssim_defconfig b/arch/mips/configs/mipssim_defconfig
index 4b3342c..63cac5b 100644
--- a/arch/mips/configs/mipssim_defconfig
+++ b/arch/mips/configs/mipssim_defconfig
@@ -134,6 +134,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/mpc30x_defconfig b/arch/mips/configs/mpc30x_defconfig
index 3e75368..68c3200 100644
--- a/arch/mips/configs/mpc30x_defconfig
+++ b/arch/mips/configs/mpc30x_defconfig
@@ -128,6 +128,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ocelot_3_defconfig b/arch/mips/configs/ocelot_3_defconfig
index 4197ac3..703e826 100644
--- a/arch/mips/configs/ocelot_3_defconfig
+++ b/arch/mips/configs/ocelot_3_defconfig
@@ -136,6 +136,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 # CONFIG_SMP is not set
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
diff --git a/arch/mips/configs/ocelot_c_defconfig b/arch/mips/configs/ocelot_c_defconfig
index da777cb..12b1167 100644
--- a/arch/mips/configs/ocelot_c_defconfig
+++ b/arch/mips/configs/ocelot_c_defconfig
@@ -132,6 +132,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ocelot_defconfig b/arch/mips/configs/ocelot_defconfig
index 9ff6ab5..1904393 100644
--- a/arch/mips/configs/ocelot_defconfig
+++ b/arch/mips/configs/ocelot_defconfig
@@ -137,6 +137,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/ocelot_g_defconfig b/arch/mips/configs/ocelot_g_defconfig
index 7df9ce9..2822b32 100644
--- a/arch/mips/configs/ocelot_g_defconfig
+++ b/arch/mips/configs/ocelot_g_defconfig
@@ -135,6 +135,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/pb1100_defconfig b/arch/mips/configs/pb1100_defconfig
index fc28746..a304a44 100644
--- a/arch/mips/configs/pb1100_defconfig
+++ b/arch/mips/configs/pb1100_defconfig
@@ -131,6 +131,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/pb1500_defconfig b/arch/mips/configs/pb1500_defconfig
index a09be54..da00155 100644
--- a/arch/mips/configs/pb1500_defconfig
+++ b/arch/mips/configs/pb1500_defconfig
@@ -130,6 +130,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/pb1550_defconfig b/arch/mips/configs/pb1550_defconfig
index b8bcbc2..3a6e717 100644
--- a/arch/mips/configs/pb1550_defconfig
+++ b/arch/mips/configs/pb1550_defconfig
@@ -130,6 +130,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/pnx8550-jbs_defconfig b/arch/mips/configs/pnx8550-jbs_defconfig
index 91ff3ba..6570804 100644
--- a/arch/mips/configs/pnx8550-jbs_defconfig
+++ b/arch/mips/configs/pnx8550-jbs_defconfig
@@ -129,6 +129,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/pnx8550-v2pci_defconfig b/arch/mips/configs/pnx8550-v2pci_defconfig
index 932c803..fb1c190 100644
--- a/arch/mips/configs/pnx8550-v2pci_defconfig
+++ b/arch/mips/configs/pnx8550-v2pci_defconfig
@@ -130,6 +130,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/qemu_defconfig b/arch/mips/configs/qemu_defconfig
index 0d3ce64..d922bcb 100644
--- a/arch/mips/configs/qemu_defconfig
+++ b/arch/mips/configs/qemu_defconfig
@@ -126,6 +126,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_HZ_100=y
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=100
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/rbhma4500_defconfig b/arch/mips/configs/rbhma4500_defconfig
index 0ad74a5..ffc9470 100644
--- a/arch/mips/configs/rbhma4500_defconfig
+++ b/arch/mips/configs/rbhma4500_defconfig
@@ -138,6 +138,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index fab27fe..82d9ea5 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -138,6 +138,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 # CONFIG_PREEMPT_NONE is not set
 CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/sb1250-swarm_defconfig b/arch/mips/configs/sb1250-swarm_defconfig
index 9060622..2fb8391 100644
--- a/arch/mips/configs/sb1250-swarm_defconfig
+++ b/arch/mips/configs/sb1250-swarm_defconfig
@@ -148,6 +148,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_PREEMPT_NONE=y
diff --git a/arch/mips/configs/sead_defconfig b/arch/mips/configs/sead_defconfig
index de02881..64095ec 100644
--- a/arch/mips/configs/sead_defconfig
+++ b/arch/mips/configs/sead_defconfig
@@ -133,6 +133,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/tb0226_defconfig b/arch/mips/configs/tb0226_defconfig
index 8f4f06c..dd90743 100644
--- a/arch/mips/configs/tb0226_defconfig
+++ b/arch/mips/configs/tb0226_defconfig
@@ -130,6 +130,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/tb0229_defconfig b/arch/mips/configs/tb0229_defconfig
index 5f54e27..5886b0b 100644
--- a/arch/mips/configs/tb0229_defconfig
+++ b/arch/mips/configs/tb0229_defconfig
@@ -130,6 +130,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/tb0287_defconfig b/arch/mips/configs/tb0287_defconfig
index fe3ba4f..c5c0ee8 100644
--- a/arch/mips/configs/tb0287_defconfig
+++ b/arch/mips/configs/tb0287_defconfig
@@ -135,6 +135,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/workpad_defconfig b/arch/mips/configs/workpad_defconfig
index bd5bd46..569ecbe 100644
--- a/arch/mips/configs/workpad_defconfig
+++ b/arch/mips/configs/workpad_defconfig
@@ -126,6 +126,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
diff --git a/arch/mips/configs/yosemite_defconfig b/arch/mips/configs/yosemite_defconfig
index 2c0c25e..423e840 100644
--- a/arch/mips/configs/yosemite_defconfig
+++ b/arch/mips/configs/yosemite_defconfig
@@ -130,6 +130,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_PREEMPT_NONE=y
diff --git a/arch/mips/defconfig b/arch/mips/defconfig
index f66ba91..cd82a4a 100644
--- a/arch/mips/defconfig
+++ b/arch/mips/defconfig
@@ -136,6 +136,10 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
 # CONFIG_PREEMPT_NONE is not set
 CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_PREEMPT is not set
diff --git a/include/asm-mips/mach-generic/param.h b/include/asm-mips/mach-generic/param.h
index a0d12f9..3ba0ed7 100644
--- a/include/asm-mips/mach-generic/param.h
+++ b/include/asm-mips/mach-generic/param.h
@@ -8,6 +8,6 @@
 #ifndef __ASM_MACH_GENERIC_PARAM_H
 #define __ASM_MACH_GENERIC_PARAM_H
 
-#define HZ		1000		/* Internal kernel timer frequency */
+#define HZ		CONFIG_HZ	/* internal kernel timer frequency */
 
 #endif /* __ASM_MACH_GENERIC_PARAM_H */
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
