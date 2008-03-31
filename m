Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2008 00:07:37 +0200 (CEST)
Received: from smtp02.mtu.ru ([62.5.255.49]:10456 "EHLO smtp02.mtu.ru")
	by lappi.linux-mips.net with ESMTP id S1100128AbYCaWHG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2008 00:07:06 +0200
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id A412E456AF;
	Tue,  1 Apr 2008 02:05:16 +0400 (MSD)
Received: from localhost.localdomain (ppp85-140-79-111.pppoe.mtu-net.ru [85.140.79.111])
	by smtp02.mtu.ru (Postfix) with ESMTP id 1CC7B4470B;
	Tue,  1 Apr 2008 02:03:41 +0400 (MSD)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] [MIPS] malta_int.c: make 4 variables static
Date:	Tue,  1 Apr 2008 02:03:25 +0400
Message-Id: <1207001005-2633-7-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1207001005-2633-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1207001005-2633-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

The following variables defined in arch/mips/mips-boards/malta/malta_int.c
can become static: msc_irqmap[], msc_nr_irqs, msc_eicirqmap[], and
msc_nr_eicirqs. This patch makes them static.

Successfully build-tested using default configs for Malta, Atlas
and SEAD boards.

Runtime test successfully performed by booting the Malta 4Kc board
up to the shell prompt.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mips-boards/malta/malta_int.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mips-boards/malta/malta_int.c b/arch/mips/mips-boards/malta/malta_int.c
index dbe60eb..b51a70b 100644
--- a/arch/mips/mips-boards/malta/malta_int.c
+++ b/arch/mips/mips-boards/malta/malta_int.c
@@ -273,13 +273,13 @@ static struct irqaction corehi_irqaction = {
 	.name = "CoreHi"
 };
 
-msc_irqmap_t __initdata msc_irqmap[] = {
+static msc_irqmap_t __initdata msc_irqmap[] = {
 	{MSC01C_INT_TMR,		MSC01_IRQ_EDGE, 0},
 	{MSC01C_INT_PCI,		MSC01_IRQ_LEVEL, 0},
 };
-int __initdata msc_nr_irqs = ARRAY_SIZE(msc_irqmap);
+static int __initdata msc_nr_irqs = ARRAY_SIZE(msc_irqmap);
 
-msc_irqmap_t __initdata msc_eicirqmap[] = {
+static msc_irqmap_t __initdata msc_eicirqmap[] = {
 	{MSC01E_INT_SW0,		MSC01_IRQ_LEVEL, 0},
 	{MSC01E_INT_SW1,		MSC01_IRQ_LEVEL, 0},
 	{MSC01E_INT_I8259A,		MSC01_IRQ_LEVEL, 0},
@@ -291,7 +291,7 @@ msc_irqmap_t __initdata msc_eicirqmap[] = {
 	{MSC01E_INT_PERFCTR,		MSC01_IRQ_LEVEL, 0},
 	{MSC01E_INT_CPUCTR,		MSC01_IRQ_LEVEL, 0}
 };
-int __initdata msc_nr_eicirqs = ARRAY_SIZE(msc_eicirqmap);
+static int __initdata msc_nr_eicirqs = ARRAY_SIZE(msc_eicirqmap);
 
 void __init arch_init_irq(void)
 {
-- 
1.5.3
