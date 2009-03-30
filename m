Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2009 20:55:02 +0100 (BST)
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:42391 "EHLO
	gw02.mail.saunalahti.fi") by ftp.linux-mips.org with ESMTP
	id S20027453AbZC3Txv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Mar 2009 20:53:51 +0100
Received: from localhost.localdomain (a88-114-245-69.elisa-laajakaista.fi [88.114.245.69])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id BDACE139601;
	Mon, 30 Mar 2009 22:53:47 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: [PATCH 3/4] [MIPS] ip32: fix needlessly global symbols in arch/mips/sgi-ip32/ip32-irq.c
Date:	Mon, 30 Mar 2009 22:53:25 +0300
Message-Id: <1238442806-11013-4-git-send-email-dmitri.vorobiev@movial.com>
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1238442806-11013-1-git-send-email-dmitri.vorobiev@movial.com>
References: <1238442806-11013-1-git-send-email-dmitri.vorobiev@movial.com>
Return-Path: <dmitri.vorobiev@movial.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.com
Precedence: bulk
X-list: linux-mips

The following symbols are needlessly defined global: cpuerr_irq and
memerr_irq. This patch makes the symbols static.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
---
 arch/mips/sgi-ip32/ip32-irq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/sgi-ip32/ip32-irq.c b/arch/mips/sgi-ip32/ip32-irq.c
index 0d6b666..7abd649 100644
--- a/arch/mips/sgi-ip32/ip32-irq.c
+++ b/arch/mips/sgi-ip32/ip32-irq.c
@@ -112,14 +112,14 @@ static void inline flush_mace_bus(void)
 extern irqreturn_t crime_memerr_intr(int irq, void *dev_id);
 extern irqreturn_t crime_cpuerr_intr(int irq, void *dev_id);
 
-struct irqaction memerr_irq = {
+static struct irqaction memerr_irq = {
 	.handler = crime_memerr_intr,
 	.flags = IRQF_DISABLED,
 	.mask = CPU_MASK_NONE,
 	.name = "CRIME memory error",
 };
 
-struct irqaction cpuerr_irq = {
+static struct irqaction cpuerr_irq = {
 	.handler = crime_cpuerr_intr,
 	.flags = IRQF_DISABLED,
 	.mask = CPU_MASK_NONE,
-- 
1.5.6.3
