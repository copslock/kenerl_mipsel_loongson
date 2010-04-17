Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Apr 2010 20:17:48 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.152]:48911 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491984Ab0DQSRo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Apr 2010 20:17:44 +0200
Received: by fg-out-1718.google.com with SMTP id 19so1670103fgg.6
        for <linux-mips@linux-mips.org>; Sat, 17 Apr 2010 11:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=N+vfASzRkSWbdsQ/HN/1Fa6EgsWc2Jz5ZD+EmHq+5wI=;
        b=OKU6P7WyFPS4B9oJWvZM+ojDi+kCI/w2OlcVoaJO5bwxfKU6/2UpiA2bHrLXkzeVdN
         gh56kJlNf7SBtAxaZtmlmaJudSal26hXB9JcKNMHWHImLpge9iZuK2vvbXwh1XLh1oaq
         Ws0Mx0rnJqUBIRXuwHNBO0cwY4zhE06C83uLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dAAFwI+czV0jW5vNEO/0qxYU5E2Tq8thNcA9o0VLOsH7F+vuxz/EL5UMloat3kRwBL
         gunqFbcbLoflNREOjWTA2XCHdcQsGHDPqff4F5Dn+SL5v3NUPnPQRlEFrUwM1WxSrUVP
         gt5N9HAeDqoxDNrKMt679Bms2/S7litzBCceo=
Received: by 10.223.60.206 with SMTP id q14mr1499670fah.93.1271528264317;
        Sat, 17 Apr 2010 11:17:44 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 21sm6694202fks.23.2010.04.17.11.17.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 11:17:43 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v2] MIPS: Alchemy: db1200: PCMCIA carddetects must not be auto-enabled.
Date:   Sat, 17 Apr 2010 20:17:40 +0200
Message-Id: <1271528260-13749-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Same issues as SD carddetects:  One of both is always screaming,
and the handlers take care to shut one up and enable the other.
To avoid messages about "unbalanced interrupt enable/disable" they
must not be automatically enabled when initally requested.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v2: remove the now unnecessary locks in the socket driver irq setup code.

The error it fixes doesn't show with the defconfig but I believe this is
just because of fortunate timings:  build without networking chip support
and its there.

Please apply to 2.6.34-rc if still possible!

 arch/mips/alchemy/devboards/db1200/setup.c |   10 +++++++---
 drivers/pcmcia/db1xxx_ss.c                 |   12 +++---------
 2 files changed, 10 insertions(+), 12 deletions(-)

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
index 6206408..0f4cc3f 100644
--- a/drivers/pcmcia/db1xxx_ss.c
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -146,7 +146,6 @@ static irqreturn_t db1200_pcmcia_cdirq(int irq, void *data)
 static int db1x_pcmcia_setup_irqs(struct db1x_pcmcia_sock *sock)
 {
 	int ret;
-	unsigned long flags;
 
 	if (sock->stschg_irq != -1) {
 		ret = request_irq(sock->stschg_irq, db1000_pcmcia_stschgirq,
@@ -162,8 +161,6 @@ static int db1x_pcmcia_setup_irqs(struct db1x_pcmcia_sock *sock)
 	 * active one disabled.
 	 */
 	if (sock->board_type == BOARD_TYPE_DB1200) {
-		local_irq_save(flags);
-
 		ret = request_irq(sock->insert_irq, db1200_pcmcia_cdirq,
 				  IRQF_DISABLED, "pcmcia_insert", sock);
 		if (ret)
@@ -173,17 +170,14 @@ static int db1x_pcmcia_setup_irqs(struct db1x_pcmcia_sock *sock)
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
