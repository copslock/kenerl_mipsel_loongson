Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Jan 2007 15:07:37 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:30152 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20050789AbXANPHb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 14 Jan 2007 15:07:31 +0000
Received: from localhost (p1114-ipad202funabasi.chiba.ocn.ne.jp [222.146.72.114])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 08AA19CC7; Mon, 15 Jan 2007 00:07:26 +0900 (JST)
Date:	Mon, 15 Jan 2007 00:07:25 +0900 (JST)
Message-Id: <20070115.000725.92586142.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] use name instead of typename for each irq_chip
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
X-archive-position: 13598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The "typename" field was obsoleted by the "name" field.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/au1000/common/irq.c                            |    8 ++++----
 arch/mips/ddb5xxx/ddb5477/irq_5477.c                     |    2 +-
 arch/mips/dec/ioasic-irq.c                               |    4 ++--
 arch/mips/dec/kn02-irq.c                                 |    2 +-
 arch/mips/emma2rh/common/irq_emma2rh.c                   |    2 +-
 arch/mips/emma2rh/markeins/irq_markeins.c                |    4 ++--
 arch/mips/gt64120/ev64120/irq.c                          |    2 +-
 arch/mips/jazz/irq.c                                     |    2 +-
 arch/mips/jmr3927/rbhma3100/irq.c                        |    2 +-
 arch/mips/kernel/irq-msc01.c                             |    4 ++--
 arch/mips/kernel/irq-mv6434x.c                           |    2 +-
 arch/mips/kernel/irq-rm7000.c                            |    2 +-
 arch/mips/kernel/irq-rm9000.c                            |    4 ++--
 arch/mips/kernel/irq_cpu.c                               |    4 ++--
 arch/mips/lasat/interrupt.c                              |    2 +-
 arch/mips/mips-boards/atlas/atlas_int.c                  |    2 +-
 arch/mips/momentum/ocelot_c/cpci-irq.c                   |    2 +-
 arch/mips/momentum/ocelot_c/uart-irq.c                   |    2 +-
 arch/mips/philips/pnx8550/common/int.c                   |    2 +-
 arch/mips/sgi-ip22/ip22-eisa.c                           |    4 ++--
 arch/mips/sgi-ip22/ip22-int.c                            |    8 ++++----
 arch/mips/sgi-ip27/ip27-irq.c                            |    2 +-
 arch/mips/sgi-ip27/ip27-timer.c                          |    2 +-
 arch/mips/sgi-ip32/ip32-irq.c                            |   10 +++++-----
 arch/mips/sibyte/bcm1480/irq.c                           |    2 +-
 arch/mips/sibyte/sb1250/irq.c                            |    2 +-
 arch/mips/sni/irq.c                                      |    2 +-
 arch/mips/tx4927/common/tx4927_irq.c                     |    4 ++--
 arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c |   12 ++++++------
 arch/mips/tx4938/common/irq.c                            |    4 ++--
 arch/mips/tx4938/toshiba_rbtx4938/irq.c                  |    2 +-
 arch/mips/vr41xx/common/icu.c                            |    4 ++--
 32 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/arch/mips/au1000/common/irq.c b/arch/mips/au1000/common/irq.c
index 9cf7b67..ea6e99f 100644
--- a/arch/mips/au1000/common/irq.c
+++ b/arch/mips/au1000/common/irq.c
@@ -233,7 +233,7 @@ void restore_local_and_enable(int contro
 
 
 static struct irq_chip rise_edge_irq_type = {
-	.typename = "Au1000 Rise Edge",
+	.name = "Au1000 Rise Edge",
 	.ack = mask_and_ack_rise_edge_irq,
 	.mask = local_disable_irq,
 	.mask_ack = mask_and_ack_rise_edge_irq,
@@ -242,7 +242,7 @@ static struct irq_chip rise_edge_irq_typ
 };
 
 static struct irq_chip fall_edge_irq_type = {
-	.typename = "Au1000 Fall Edge",
+	.name = "Au1000 Fall Edge",
 	.ack = mask_and_ack_fall_edge_irq,
 	.mask = local_disable_irq,
 	.mask_ack = mask_and_ack_fall_edge_irq,
@@ -251,7 +251,7 @@ static struct irq_chip fall_edge_irq_typ
 };
 
 static struct irq_chip either_edge_irq_type = {
-	.typename = "Au1000 Rise or Fall Edge",
+	.name = "Au1000 Rise or Fall Edge",
 	.ack = mask_and_ack_either_edge_irq,
 	.mask = local_disable_irq,
 	.mask_ack = mask_and_ack_either_edge_irq,
@@ -260,7 +260,7 @@ static struct irq_chip either_edge_irq_t
 };
 
 static struct irq_chip level_irq_type = {
-	.typename = "Au1000 Level",
+	.name = "Au1000 Level",
 	.ack = mask_and_ack_level_irq,
 	.mask = local_disable_irq,
 	.mask_ack = mask_and_ack_level_irq,
diff --git a/arch/mips/ddb5xxx/ddb5477/irq_5477.c b/arch/mips/ddb5xxx/ddb5477/irq_5477.c
index 96249aa..98c3b15 100644
--- a/arch/mips/ddb5xxx/ddb5477/irq_5477.c
+++ b/arch/mips/ddb5xxx/ddb5477/irq_5477.c
@@ -82,7 +82,7 @@ vrc5477_irq_end(unsigned int irq)
 }
 
 struct irq_chip vrc5477_irq_controller = {
-	.typename = "vrc5477_irq",
+	.name = "vrc5477_irq",
 	.ack = vrc5477_irq_ack,
 	.mask = vrc5477_irq_disable,
 	.mask_ack = vrc5477_irq_ack,
diff --git a/arch/mips/dec/ioasic-irq.c b/arch/mips/dec/ioasic-irq.c
index 4c7cb40..3acb133 100644
--- a/arch/mips/dec/ioasic-irq.c
+++ b/arch/mips/dec/ioasic-irq.c
@@ -62,7 +62,7 @@ static inline void end_ioasic_irq(unsign
 }
 
 static struct irq_chip ioasic_irq_type = {
-	.typename = "IO-ASIC",
+	.name = "IO-ASIC",
 	.ack = ack_ioasic_irq,
 	.mask = mask_ioasic_irq,
 	.mask_ack = ack_ioasic_irq,
@@ -84,7 +84,7 @@ static inline void end_ioasic_dma_irq(un
 }
 
 static struct irq_chip ioasic_dma_irq_type = {
-	.typename = "IO-ASIC-DMA",
+	.name = "IO-ASIC-DMA",
 	.ack = ack_ioasic_dma_irq,
 	.mask = mask_ioasic_dma_irq,
 	.mask_ack = ack_ioasic_dma_irq,
diff --git a/arch/mips/dec/kn02-irq.c b/arch/mips/dec/kn02-irq.c
index 916e46b..02439dc 100644
--- a/arch/mips/dec/kn02-irq.c
+++ b/arch/mips/dec/kn02-irq.c
@@ -58,7 +58,7 @@ static void ack_kn02_irq(unsigned int ir
 }
 
 static struct irq_chip kn02_irq_type = {
-	.typename = "KN02-CSR",
+	.name = "KN02-CSR",
 	.ack = ack_kn02_irq,
 	.mask = mask_kn02_irq,
 	.mask_ack = ack_kn02_irq,
diff --git a/arch/mips/emma2rh/common/irq_emma2rh.c b/arch/mips/emma2rh/common/irq_emma2rh.c
index 8d880f0..96df37b 100644
--- a/arch/mips/emma2rh/common/irq_emma2rh.c
+++ b/arch/mips/emma2rh/common/irq_emma2rh.c
@@ -57,7 +57,7 @@ static void emma2rh_irq_disable(unsigned
 }
 
 struct irq_chip emma2rh_irq_controller = {
-	.typename = "emma2rh_irq",
+	.name = "emma2rh_irq",
 	.ack = emma2rh_irq_disable,
 	.mask = emma2rh_irq_disable,
 	.mask_ack = emma2rh_irq_disable,
diff --git a/arch/mips/emma2rh/markeins/irq_markeins.c b/arch/mips/emma2rh/markeins/irq_markeins.c
index 2116d9b..fba5c15 100644
--- a/arch/mips/emma2rh/markeins/irq_markeins.c
+++ b/arch/mips/emma2rh/markeins/irq_markeins.c
@@ -49,7 +49,7 @@ static void emma2rh_sw_irq_disable(unsig
 }
 
 struct irq_chip emma2rh_sw_irq_controller = {
-	.typename = "emma2rh_sw_irq",
+	.name = "emma2rh_sw_irq",
 	.ack = emma2rh_sw_irq_disable,
 	.mask = emma2rh_sw_irq_disable,
 	.mask_ack = emma2rh_sw_irq_disable,
@@ -115,7 +115,7 @@ static void emma2rh_gpio_irq_end(unsigne
 }
 
 struct irq_chip emma2rh_gpio_irq_controller = {
-	.typename = "emma2rh_gpio_irq",
+	.name = "emma2rh_gpio_irq",
 	.ack = emma2rh_gpio_irq_ack,
 	.mask = emma2rh_gpio_irq_disable,
 	.mask_ack = emma2rh_gpio_irq_ack,
diff --git a/arch/mips/gt64120/ev64120/irq.c b/arch/mips/gt64120/ev64120/irq.c
index b3e5796..04572b9 100644
--- a/arch/mips/gt64120/ev64120/irq.c
+++ b/arch/mips/gt64120/ev64120/irq.c
@@ -88,7 +88,7 @@ static void end_ev64120_irq(unsigned int
 }
 
 static struct irq_chip ev64120_irq_type = {
-	.typename	= "EV64120",
+	.name		= "EV64120",
 	.ack		= disable_ev64120_irq,
 	.mask		= disable_ev64120_irq,
 	.mask_ack	= disable_ev64120_irq,
diff --git a/arch/mips/jazz/irq.c b/arch/mips/jazz/irq.c
index f8d417b..295892e 100644
--- a/arch/mips/jazz/irq.c
+++ b/arch/mips/jazz/irq.c
@@ -40,7 +40,7 @@ void disable_r4030_irq(unsigned int irq)
 }
 
 static struct irq_chip r4030_irq_type = {
-	.typename = "R4030",
+	.name = "R4030",
 	.ack = disable_r4030_irq,
 	.mask = disable_r4030_irq,
 	.mask_ack = disable_r4030_irq,
diff --git a/arch/mips/jmr3927/rbhma3100/irq.c b/arch/mips/jmr3927/rbhma3100/irq.c
index 3da49c5..7d2c203 100644
--- a/arch/mips/jmr3927/rbhma3100/irq.c
+++ b/arch/mips/jmr3927/rbhma3100/irq.c
@@ -439,7 +439,7 @@ void __init arch_init_irq(void)
 }
 
 static struct irq_chip jmr3927_irq_controller = {
-	.typename = "jmr3927_irq",
+	.name = "jmr3927_irq",
 	.ack = jmr3927_irq_ack,
 	.mask = jmr3927_irq_disable,
 	.mask_ack = jmr3927_irq_ack,
diff --git a/arch/mips/kernel/irq-msc01.c b/arch/mips/kernel/irq-msc01.c
index bcaad66..2967537 100644
--- a/arch/mips/kernel/irq-msc01.c
+++ b/arch/mips/kernel/irq-msc01.c
@@ -112,7 +112,7 @@ msc_bind_eic_interrupt (unsigned int irq
 }
 
 struct irq_chip msc_levelirq_type = {
-	.typename = "SOC-it-Level",
+	.name = "SOC-it-Level",
 	.ack = level_mask_and_ack_msc_irq,
 	.mask = mask_msc_irq,
 	.mask_ack = level_mask_and_ack_msc_irq,
@@ -122,7 +122,7 @@ struct irq_chip msc_levelirq_type = {
 };
 
 struct irq_chip msc_edgeirq_type = {
-	.typename = "SOC-it-Edge",
+	.name = "SOC-it-Edge",
 	.ack = edge_mask_and_ack_msc_irq,
 	.mask = mask_msc_irq,
 	.mask_ack = edge_mask_and_ack_msc_irq,
diff --git a/arch/mips/kernel/irq-mv6434x.c b/arch/mips/kernel/irq-mv6434x.c
index efbd219..bf6015e 100644
--- a/arch/mips/kernel/irq-mv6434x.c
+++ b/arch/mips/kernel/irq-mv6434x.c
@@ -92,7 +92,7 @@ void ll_mv64340_irq(void)
 }
 
 struct irq_chip mv64340_irq_type = {
-	.typename = "MV-64340",
+	.name = "MV-64340",
 	.ack = mask_mv64340_irq,
 	.mask = mask_mv64340_irq,
 	.mask_ack = mask_mv64340_irq,
diff --git a/arch/mips/kernel/irq-rm7000.c b/arch/mips/kernel/irq-rm7000.c
index a60cfe5..2507328 100644
--- a/arch/mips/kernel/irq-rm7000.c
+++ b/arch/mips/kernel/irq-rm7000.c
@@ -28,7 +28,7 @@ static inline void mask_rm7k_irq(unsigne
 }
 
 static struct irq_chip rm7k_irq_controller = {
-	.typename = "RM7000",
+	.name = "RM7000",
 	.ack = mask_rm7k_irq,
 	.mask = mask_rm7k_irq,
 	.mask_ack = mask_rm7k_irq,
diff --git a/arch/mips/kernel/irq-rm9000.c b/arch/mips/kernel/irq-rm9000.c
index 6df072b..d62a59e 100644
--- a/arch/mips/kernel/irq-rm9000.c
+++ b/arch/mips/kernel/irq-rm9000.c
@@ -79,7 +79,7 @@ static void rm9k_perfcounter_irq_shutdow
 }
 
 static struct irq_chip rm9k_irq_controller = {
-	.typename = "RM9000",
+	.name = "RM9000",
 	.ack = mask_rm9k_irq,
 	.mask = mask_rm9k_irq,
 	.mask_ack = mask_rm9k_irq,
@@ -87,7 +87,7 @@ static struct irq_chip rm9k_irq_controll
 };
 
 static struct irq_chip rm9k_perfcounter_irq = {
-	.typename = "RM9000",
+	.name = "RM9000",
 	.startup = rm9k_perfcounter_irq_startup,
 	.shutdown = rm9k_perfcounter_irq_shutdown,
 	.ack = mask_rm9k_irq,
diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index 6e73dda..7b66e03 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -49,7 +49,7 @@ static inline void mask_mips_irq(unsigne
 }
 
 static struct irq_chip mips_cpu_irq_controller = {
-	.typename	= "MIPS",
+	.name		= "MIPS",
 	.ack		= mask_mips_irq,
 	.mask		= mask_mips_irq,
 	.mask_ack	= mask_mips_irq,
@@ -88,7 +88,7 @@ static void mips_mt_cpu_irq_ack(unsigned
 }
 
 static struct irq_chip mips_mt_cpu_irq_controller = {
-	.typename	= "MIPS",
+	.name		= "MIPS",
 	.startup	= mips_mt_cpu_irq_startup,
 	.ack		= mips_mt_cpu_irq_ack,
 	.mask		= mask_mips_mt_irq,
diff --git a/arch/mips/lasat/interrupt.c b/arch/mips/lasat/interrupt.c
index 2affa5f..9a622b9 100644
--- a/arch/mips/lasat/interrupt.c
+++ b/arch/mips/lasat/interrupt.c
@@ -45,7 +45,7 @@ void enable_lasat_irq(unsigned int irq_n
 }
 
 static struct irq_chip lasat_irq_type = {
-	.typename = "Lasat",
+	.name = "Lasat",
 	.ack = disable_lasat_irq,
 	.mask = disable_lasat_irq,
 	.mask_ack = disable_lasat_irq,
diff --git a/arch/mips/mips-boards/atlas/atlas_int.c b/arch/mips/mips-boards/atlas/atlas_int.c
index 85482a6..6cfcd8f 100644
--- a/arch/mips/mips-boards/atlas/atlas_int.c
+++ b/arch/mips/mips-boards/atlas/atlas_int.c
@@ -69,7 +69,7 @@ static void end_atlas_irq(unsigned int i
 }
 
 static struct irq_chip atlas_irq_type = {
-	.typename = "Atlas",
+	.name = "Atlas",
 	.ack = disable_atlas_irq,
 	.mask = disable_atlas_irq,
 	.mask_ack = disable_atlas_irq,
diff --git a/arch/mips/momentum/ocelot_c/cpci-irq.c b/arch/mips/momentum/ocelot_c/cpci-irq.c
index bb11fef..186a140 100644
--- a/arch/mips/momentum/ocelot_c/cpci-irq.c
+++ b/arch/mips/momentum/ocelot_c/cpci-irq.c
@@ -84,7 +84,7 @@ void ll_cpci_irq(void)
 }
 
 struct irq_chip cpci_irq_type = {
-	.typename = "CPCI/FPGA",
+	.name = "CPCI/FPGA",
 	.ack = mask_cpci_irq,
 	.mask = mask_cpci_irq,
 	.mask_ack = mask_cpci_irq,
diff --git a/arch/mips/momentum/ocelot_c/uart-irq.c b/arch/mips/momentum/ocelot_c/uart-irq.c
index a7a80c0..de1a31e 100644
--- a/arch/mips/momentum/ocelot_c/uart-irq.c
+++ b/arch/mips/momentum/ocelot_c/uart-irq.c
@@ -77,7 +77,7 @@ void ll_uart_irq(void)
 }
 
 struct irq_chip uart_irq_type = {
-	.typename = "UART/FPGA",
+	.name = "UART/FPGA",
 	.ack = mask_uart_irq,
 	.mask = mask_uart_irq,
 	.mask_ack = mask_uart_irq,
diff --git a/arch/mips/philips/pnx8550/common/int.c b/arch/mips/philips/pnx8550/common/int.c
index 2c36c10..d48665e 100644
--- a/arch/mips/philips/pnx8550/common/int.c
+++ b/arch/mips/philips/pnx8550/common/int.c
@@ -159,7 +159,7 @@ int pnx8550_set_gic_priority(int irq, in
 }
 
 static struct irq_chip level_irq_type = {
-	.typename =	"PNX Level IRQ",
+	.name =		"PNX Level IRQ",
 	.ack =		mask_irq,
 	.mask =		mask_irq,
 	.mask_ack =	mask_irq,
diff --git a/arch/mips/sgi-ip22/ip22-eisa.c b/arch/mips/sgi-ip22/ip22-eisa.c
index a1a9af6..6b6e97b 100644
--- a/arch/mips/sgi-ip22/ip22-eisa.c
+++ b/arch/mips/sgi-ip22/ip22-eisa.c
@@ -139,7 +139,7 @@ static void end_eisa1_irq(unsigned int i
 }
 
 static struct irq_chip ip22_eisa1_irq_type = {
-	.typename	= "IP22 EISA",
+	.name		= "IP22 EISA",
 	.startup	= startup_eisa1_irq,
 	.ack		= mask_and_ack_eisa1_irq,
 	.mask		= disable_eisa1_irq,
@@ -194,7 +194,7 @@ static void end_eisa2_irq(unsigned int i
 }
 
 static struct irq_chip ip22_eisa2_irq_type = {
-	.typename	= "IP22 EISA",
+	.name		= "IP22 EISA",
 	.startup	= startup_eisa2_irq,
 	.ack		= mask_and_ack_eisa2_irq,
 	.mask		= disable_eisa2_irq,
diff --git a/arch/mips/sgi-ip22/ip22-int.c b/arch/mips/sgi-ip22/ip22-int.c
index f3d2ae3..b454924 100644
--- a/arch/mips/sgi-ip22/ip22-int.c
+++ b/arch/mips/sgi-ip22/ip22-int.c
@@ -53,7 +53,7 @@ static void disable_local0_irq(unsigned
 }
 
 static struct irq_chip ip22_local0_irq_type = {
-	.typename	= "IP22 local 0",
+	.name		= "IP22 local 0",
 	.ack		= disable_local0_irq,
 	.mask		= disable_local0_irq,
 	.mask_ack	= disable_local0_irq,
@@ -74,7 +74,7 @@ void disable_local1_irq(unsigned int irq
 }
 
 static struct irq_chip ip22_local1_irq_type = {
-	.typename	= "IP22 local 1",
+	.name		= "IP22 local 1",
 	.ack		= disable_local1_irq,
 	.mask		= disable_local1_irq,
 	.mask_ack	= disable_local1_irq,
@@ -95,7 +95,7 @@ void disable_local2_irq(unsigned int irq
 }
 
 static struct irq_chip ip22_local2_irq_type = {
-	.typename	= "IP22 local 2",
+	.name		= "IP22 local 2",
 	.ack		= disable_local2_irq,
 	.mask		= disable_local2_irq,
 	.mask_ack	= disable_local2_irq,
@@ -116,7 +116,7 @@ void disable_local3_irq(unsigned int irq
 }
 
 static struct irq_chip ip22_local3_irq_type = {
-	.typename	= "IP22 local 3",
+	.name		= "IP22 local 3",
 	.ack		= disable_local3_irq,
 	.mask		= disable_local3_irq,
 	.mask_ack	= disable_local3_irq,
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index 319f880..60ade76 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -333,7 +333,7 @@ static inline void disable_bridge_irq(un
 }
 
 static struct irq_chip bridge_irq_type = {
-	.typename	= "bridge",
+	.name		= "bridge",
 	.startup	= startup_bridge_irq,
 	.shutdown	= shutdown_bridge_irq,
 	.ack		= disable_bridge_irq,
diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index c20e989..9ce5136 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -181,7 +181,7 @@ static void disable_rt_irq(unsigned int
 }
 
 static struct irq_chip rt_irq_type = {
-	.typename	= "SN HUB RT timer",
+	.name		= "SN HUB RT timer",
 	.ack		= disable_rt_irq,
 	.mask		= disable_rt_irq,
 	.mask_ack	= disable_rt_irq,
diff --git a/arch/mips/sgi-ip32/ip32-irq.c b/arch/mips/sgi-ip32/ip32-irq.c
index ae06386..8c450d9 100644
--- a/arch/mips/sgi-ip32/ip32-irq.c
+++ b/arch/mips/sgi-ip32/ip32-irq.c
@@ -144,7 +144,7 @@ static void end_cpu_irq(unsigned int irq
 }
 
 static struct irq_chip ip32_cpu_interrupt = {
-	.typename = "IP32 CPU",
+	.name = "IP32 CPU",
 	.ack = disable_cpu_irq,
 	.mask = disable_cpu_irq,
 	.mask_ack = disable_cpu_irq,
@@ -193,7 +193,7 @@ static void end_crime_irq(unsigned int i
 }
 
 static struct irq_chip ip32_crime_interrupt = {
-	.typename = "IP32 CRIME",
+	.name = "IP32 CRIME",
 	.ack = mask_and_ack_crime_irq,
 	.mask = disable_crime_irq,
 	.mask_ack = mask_and_ack_crime_irq,
@@ -234,7 +234,7 @@ static void end_macepci_irq(unsigned int
 }
 
 static struct irq_chip ip32_macepci_interrupt = {
-	.typename = "IP32 MACE PCI",
+	.name = "IP32 MACE PCI",
 	.ack = disable_macepci_irq,
 	.mask = disable_macepci_irq,
 	.mask_ack = disable_macepci_irq,
@@ -347,7 +347,7 @@ static void end_maceisa_irq(unsigned irq
 }
 
 static struct irq_chip ip32_maceisa_interrupt = {
-	.typename = "IP32 MACE ISA",
+	.name = "IP32 MACE ISA",
 	.ack = mask_and_ack_maceisa_irq,
 	.mask = disable_maceisa_irq,
 	.mask_ack = mask_and_ack_maceisa_irq,
@@ -379,7 +379,7 @@ static void end_mace_irq(unsigned int ir
 }
 
 static struct irq_chip ip32_mace_interrupt = {
-	.typename = "IP32 MACE",
+	.name = "IP32 MACE",
 	.ack = disable_mace_irq,
 	.mask = disable_mace_irq,
 	.mask_ack = disable_mace_irq,
diff --git a/arch/mips/sibyte/bcm1480/irq.c b/arch/mips/sibyte/bcm1480/irq.c
index 2e8f6b2..1dc5d05 100644
--- a/arch/mips/sibyte/bcm1480/irq.c
+++ b/arch/mips/sibyte/bcm1480/irq.c
@@ -82,7 +82,7 @@ extern char sb1250_duart_present[];
 #endif
 
 static struct irq_chip bcm1480_irq_type = {
-	.typename = "BCM1480-IMR",
+	.name = "BCM1480-IMR",
 	.ack = ack_bcm1480_irq,
 	.mask = disable_bcm1480_irq,
 	.mask_ack = ack_bcm1480_irq,
diff --git a/arch/mips/sibyte/sb1250/irq.c b/arch/mips/sibyte/sb1250/irq.c
index 82ce753..1482394 100644
--- a/arch/mips/sibyte/sb1250/irq.c
+++ b/arch/mips/sibyte/sb1250/irq.c
@@ -67,7 +67,7 @@ extern char sb1250_duart_present[];
 #endif
 
 static struct irq_chip sb1250_irq_type = {
-	.typename = "SB1250-IMR",
+	.name = "SB1250-IMR",
 	.ack = ack_sb1250_irq,
 	.mask = disable_sb1250_irq,
 	.mask_ack = ack_sb1250_irq,
diff --git a/arch/mips/sni/irq.c b/arch/mips/sni/irq.c
index 8511bcc..039e8e5 100644
--- a/arch/mips/sni/irq.c
+++ b/arch/mips/sni/irq.c
@@ -37,7 +37,7 @@ static void end_pciasic_irq(unsigned int
 }
 
 static struct irq_chip pciasic_irq_type = {
-	.typename = "ASIC-PCI",
+	.name = "ASIC-PCI",
 	.ack = disable_pciasic_irq,
 	.mask = disable_pciasic_irq,
 	.mask_ack = disable_pciasic_irq,
diff --git a/arch/mips/tx4927/common/tx4927_irq.c b/arch/mips/tx4927/common/tx4927_irq.c
index ed4a19a..e7f3e5b 100644
--- a/arch/mips/tx4927/common/tx4927_irq.c
+++ b/arch/mips/tx4927/common/tx4927_irq.c
@@ -120,7 +120,7 @@ static void tx4927_irq_pic_disable(unsig
 
 #define TX4927_CP0_NAME "TX4927-CP0"
 static struct irq_chip tx4927_irq_cp0_type = {
-	.typename	= TX4927_CP0_NAME,
+	.name		= TX4927_CP0_NAME,
 	.ack		= tx4927_irq_cp0_disable,
 	.mask		= tx4927_irq_cp0_disable,
 	.mask_ack	= tx4927_irq_cp0_disable,
@@ -129,7 +129,7 @@ static struct irq_chip tx4927_irq_cp0_ty
 
 #define TX4927_PIC_NAME "TX4927-PIC"
 static struct irq_chip tx4927_irq_pic_type = {
-	.typename	= TX4927_PIC_NAME,
+	.name		= TX4927_PIC_NAME,
 	.ack		= tx4927_irq_pic_disable,
 	.mask		= tx4927_irq_pic_disable,
 	.mask_ack	= tx4927_irq_pic_disable,
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
index b54b529..dcce88f 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
@@ -228,7 +228,7 @@ static void toshiba_rbtx4927_irq_isa_mas
 
 #define TOSHIBA_RBTX4927_IOC_NAME "RBTX4927-IOC"
 static struct irq_chip toshiba_rbtx4927_irq_ioc_type = {
-	.typename = TOSHIBA_RBTX4927_IOC_NAME,
+	.name = TOSHIBA_RBTX4927_IOC_NAME,
 	.ack = toshiba_rbtx4927_irq_ioc_disable,
 	.mask = toshiba_rbtx4927_irq_ioc_disable,
 	.mask_ack = toshiba_rbtx4927_irq_ioc_disable,
@@ -241,7 +241,7 @@ static struct irq_chip toshiba_rbtx4927_
 #ifdef CONFIG_TOSHIBA_FPCIB0
 #define TOSHIBA_RBTX4927_ISA_NAME "RBTX4927-ISA"
 static struct irq_chip toshiba_rbtx4927_irq_isa_type = {
-	.typename = TOSHIBA_RBTX4927_ISA_NAME,
+	.name = TOSHIBA_RBTX4927_ISA_NAME,
 	.ack = toshiba_rbtx4927_irq_isa_mask_and_ack,
 	.mask = toshiba_rbtx4927_irq_isa_disable,
 	.mask_ack = toshiba_rbtx4927_irq_isa_mask_and_ack,
@@ -490,13 +490,13 @@ void toshiba_rbtx4927_irq_dump(char *key
 	{
 		u32 i, j = 0;
 		for (i = 0; i < NR_IRQS; i++) {
-			if (strcmp(irq_desc[i].chip->typename, "none")
+			if (strcmp(irq_desc[i].chip->name, "none")
 			    == 0)
 				continue;
 
 			if ((i >= 1)
-			    && (irq_desc[i - 1].chip->typename ==
-				irq_desc[i].chip->typename)) {
+			    && (irq_desc[i - 1].chip->name ==
+				irq_desc[i].chip->name)) {
 				j++;
 			} else {
 				j = 0;
@@ -510,7 +510,7 @@ void toshiba_rbtx4927_irq_dump(char *key
 			     (u32) (irq_desc[i].action ? irq_desc[i].
 				    action->handler : 0),
 			     irq_desc[i].depth,
-			     irq_desc[i].chip->typename, j);
+			     irq_desc[i].chip->name, j);
 		}
 	}
 #endif
diff --git a/arch/mips/tx4938/common/irq.c b/arch/mips/tx4938/common/irq.c
index a347b42..3a2dbfc 100644
--- a/arch/mips/tx4938/common/irq.c
+++ b/arch/mips/tx4938/common/irq.c
@@ -49,7 +49,7 @@ static void tx4938_irq_pic_disable(unsig
 
 #define TX4938_CP0_NAME "TX4938-CP0"
 static struct irq_chip tx4938_irq_cp0_type = {
-	.typename = TX4938_CP0_NAME,
+	.name = TX4938_CP0_NAME,
 	.ack = tx4938_irq_cp0_disable,
 	.mask = tx4938_irq_cp0_disable,
 	.mask_ack = tx4938_irq_cp0_disable,
@@ -58,7 +58,7 @@ static struct irq_chip tx4938_irq_cp0_ty
 
 #define TX4938_PIC_NAME "TX4938-PIC"
 static struct irq_chip tx4938_irq_pic_type = {
-	.typename = TX4938_PIC_NAME,
+	.name = TX4938_PIC_NAME,
 	.ack = tx4938_irq_pic_disable,
 	.mask = tx4938_irq_pic_disable,
 	.mask_ack = tx4938_irq_pic_disable,
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/irq.c b/arch/mips/tx4938/toshiba_rbtx4938/irq.c
index b6f363d..2e96dbb 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/irq.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/irq.c
@@ -92,7 +92,7 @@ static void toshiba_rbtx4938_irq_ioc_dis
 
 #define TOSHIBA_RBTX4938_IOC_NAME "RBTX4938-IOC"
 static struct irq_chip toshiba_rbtx4938_irq_ioc_type = {
-	.typename = TOSHIBA_RBTX4938_IOC_NAME,
+	.name = TOSHIBA_RBTX4938_IOC_NAME,
 	.ack = toshiba_rbtx4938_irq_ioc_disable,
 	.mask = toshiba_rbtx4938_irq_ioc_disable,
 	.mask_ack = toshiba_rbtx4938_irq_ioc_disable,
diff --git a/arch/mips/vr41xx/common/icu.c b/arch/mips/vr41xx/common/icu.c
index c075261..97d7d9a 100644
--- a/arch/mips/vr41xx/common/icu.c
+++ b/arch/mips/vr41xx/common/icu.c
@@ -428,7 +428,7 @@ static void enable_sysint1_irq(unsigned
 }
 
 static struct irq_chip sysint1_irq_type = {
-	.typename	= "SYSINT1",
+	.name		= "SYSINT1",
 	.ack		= disable_sysint1_irq,
 	.mask		= disable_sysint1_irq,
 	.mask_ack	= disable_sysint1_irq,
@@ -446,7 +446,7 @@ static void enable_sysint2_irq(unsigned
 }
 
 static struct irq_chip sysint2_irq_type = {
-	.typename	= "SYSINT2",
+	.name		= "SYSINT2",
 	.ack		= disable_sysint2_irq,
 	.mask		= disable_sysint2_irq,
 	.mask_ack	= disable_sysint2_irq,
