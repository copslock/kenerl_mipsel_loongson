Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Apr 2010 17:42:14 +0200 (CEST)
Received: from mail-ew0-f211.google.com ([209.85.219.211]:39489 "EHLO
        mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492149Ab0DUPmJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Apr 2010 17:42:09 +0200
Received: by ewy3 with SMTP id 3so83071ewy.26
        for <multiple recipients>; Wed, 21 Apr 2010 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=nz1H8OAAWSk+gU3jL+IfKrtjoc/gxEumUZSKB7EdA+k=;
        b=opoqPYU+5PPoBMFi6Pj8qPNmGQ5Dwls9MNqcnkliESXX3hjCVb/hFn3xEaFv/EIu6o
         3hsDn03LVA4q3qoenOBnlVjt1Mm+ETCxB447LSoNZ66phwCxRZPyilh0awWSMnfg0TrF
         fTOiiA159QwAdXwLpugtYcEbWP/C7PDEwhsYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=lDeTfAUChBW5v3Ii1uOp9cIOwa9jVZ4TltrU1u69tl+tiXCDOk7tbImGDBEO0fO6L1
         9kLxmj/Baj7Gfa0iBuO6i+AaqgvPrsc4wSUaPZRX+i78rZI3oXgoAxj4X6bm/5ne+GM6
         Eqa3KN+p2fE93SiBd+84K5KsgyXSZarjEczbA=
Received: by 10.103.81.39 with SMTP id i39mr1466116mul.28.1271864523699;
        Wed, 21 Apr 2010 08:42:03 -0700 (PDT)
Received: from localhost.localdomain (p5496D614.dip.t-dialin.net [84.150.214.20])
        by mx.google.com with ESMTPS id j10sm3341751mue.18.2010.04.21.08.42.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Apr 2010 08:42:02 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v3] MIPS: Alchemy: db1200: PCMCIA carddetects must not be auto-enabled.
Date:   Wed, 21 Apr 2010 17:41:59 +0200
Message-Id: <1271864519-4516-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Same issues as SD carddetects:  One of both is always triggering
and the handlers take care to shut it up and enable the other.
To avoid messages about "unbalanced interrupt enable/disable" they
must not be automatically enabled when initally requested.

This was not an issue with the db1200_defconfig due to fortunate timings;
on a build without network chip support the warnings appear.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v3: rebase on top of latest linus git (db1xxx_ss.c changed).
v2: remove the now unnecessary locks in the socket driver irq setup code.

Please apply to 2.6.34-rc if still possible!

 arch/mips/alchemy/devboards/db1200/setup.c |   10 +++++++---
 drivers/pcmcia/db1xxx_ss.c                 |   16 ++++------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200/setup.c b/arch/mips/alchemy/devboards/db1200/setup.c
index be7e92e..8876195 100644
--- a/arch/mips/alchemy/devboards/db1200/setup.c
+++ b/arch/mips/alchemy/devboards/db1200/setup.c
@@ -66,12 +66,16 @@ static int __init db1200_arch_init(void)
 	set_irq_type(AU1200_GPIO7_INT, IRQF_TRIGGER_LOW);
 	bcsr_init_irq(DB1200_INT_BEGIN, DB1200_INT_END, AU1200_GPIO7_INT);
 
-	/* do not autoenable these: CPLD has broken edge int handling,
-	 * and the CD handler setup requires manual enabling to work
-	 * around that.
+	/* insert/eject pairs: one of both is always screaming.  To avoid
+	 * issues they must not be automatically enabled when initially
+	 * requested.
 	 */
 	irq_to_desc(DB1200_SD0_INSERT_INT)->status |= IRQ_NOAUTOEN;
 	irq_to_desc(DB1200_SD0_EJECT_INT)->status |= IRQ_NOAUTOEN;
+	irq_to_desc(DB1200_PC0_INSERT_INT)->status |= IRQ_NOAUTOEN;
+	irq_to_desc(DB1200_PC0_EJECT_INT)->status |= IRQ_NOAUTOEN;
+	irq_to_desc(DB1200_PC1_INSERT_INT)->status |= IRQ_NOAUTOEN;
+	irq_to_desc(DB1200_PC1_EJECT_INT)->status |= IRQ_NOAUTOEN;
 
 	return 0;
 }
diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
index 2d48196..0f4cc3f 100644
--- a/drivers/pcmcia/db1xxx_ss.c
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -146,7 +146,6 @@ static irqreturn_t db1200_pcmcia_cdirq(int irq, void *data)
 static int db1x_pcmcia_setup_irqs(struct db1x_pcmcia_sock *sock)
 {
 	int ret;
-	unsigned long flags;
 
 	if (sock->stschg_irq != -1) {
 		ret = request_irq(sock->stschg_irq, db1000_pcmcia_stschgirq,
@@ -162,30 +161,23 @@ static int db1x_pcmcia_setup_irqs(struct db1x_pcmcia_sock *sock)
 	 * active one disabled.
 	 */
 	if (sock->board_type == BOARD_TYPE_DB1200) {
-		local_irq_save(flags);
-
 		ret = request_irq(sock->insert_irq, db1200_pcmcia_cdirq,
 				  IRQF_DISABLED, "pcmcia_insert", sock);
-		if (ret) {
-			local_irq_restore(flags);
+		if (ret)
 			goto out1;
-		}
 
 		ret = request_irq(sock->eject_irq, db1200_pcmcia_cdirq,
 				  IRQF_DISABLED, "pcmcia_eject", sock);
 		if (ret) {
 			free_irq(sock->insert_irq, sock);
-			local_irq_restore(flags);
 			goto out1;
 		}
 
-		/* disable the currently active one */
+		/* enable the currently silent one */
 		if (db1200_card_inserted(sock))
-			disable_irq_nosync(sock->insert_irq);
+			enable_irq(sock->eject_irq);
 		else
-			disable_irq_nosync(sock->eject_irq);
-
-		local_irq_restore(flags);
+			enable_irq(sock->insert_irq);
 	} else {
 		/* all other (older) Db1x00 boards use a GPIO to show
 		 * card detection status:  use both-edge triggers.
-- 
1.7.0.4
