Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 12:22:36 +0200 (CEST)
Received: from mail-fx0-f221.google.com ([209.85.220.221]:45031 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492582AbZJNKWa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 12:22:30 +0200
Received: by fxm21 with SMTP id 21so9243932fxm.33
        for <multiple recipients>; Wed, 14 Oct 2009 03:22:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :organization:user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=yaXZkIPk++rQONqOjH07CE/jfy4ZSTiGZCk/nIZQ/DA=;
        b=XngL4te//kcBjblzdTwY9AIJVJkpFZ03jb2f8nQAhngEEHjZSmqIEnsSXZTlcyPKvD
         HKnz/clEevtR4WBFuX3cNboLfdC27Av6bBTi/YMn5fIQ3VFtNXObHfV0a8peNwnG7WF9
         U3czUnh3kGhMq4M1PrC6IqV8XQUfQ323aPLMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:content-type:content-transfer-encoding;
        b=Den8Y2dmS2ORdrTO7MUAs8vP7MuonNYpCY2Nh4i4fMCSMpdvKWOtkXSxXPUtfcZChG
         xytAocbECzCF+sPyjaGB3Op24pwEM+qI/LiKpEuPebu+ZIjmAf1J6LlxwuFPGvlVdEWX
         ylMkQGt2cAJiEgvJyXkUeDMU/75iwPeX0UFxc=
Received: by 10.103.125.23 with SMTP id c23mr3544970mun.41.1255515744611;
        Wed, 14 Oct 2009 03:22:24 -0700 (PDT)
Received: from ?0.0.0.0? (p5496B3DC.dip.t-dialin.net [84.150.179.220])
        by mx.google.com with ESMTPS id 7sm2254967mup.42.2009.10.14.03.22.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Oct 2009 03:22:24 -0700 (PDT)
Message-ID: <4AD5A65C.4060507@gmail.com>
Date:	Wed, 14 Oct 2009 12:22:20 +0200
From:	Manuel Lauss <manuel.lauss@googlemail.com>
Organization: Private
User-Agent: Thunderbird 2.0.0.23 (X11/20090828)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
CC:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: fix hang with high-frequency edge interrupts
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

The handle_edge_irq() flowhandler disables edge int sources which occur
too fast (i.e. another edge comes in before the irq handler function
had a chance to finish).  Currently, the mask_ack() callback does not
ack the edges in hardware, leading to an endless loop in the flowhandler
where it tries to shut up the irq source.

When I rewrote the alchemy IRQ code  I wrongly assumed the mask_ack()
callback was only used by the level flowhandler, hence it omitted the
(at the time pointless) edge acks.  Turned out I was wrong; so here
is a complete mask_ack implementation for Alchemy IC, which fixes
the above mentioned problem.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Can be easily triggered with a simple not-debounced switch attached to
an edge-triggered gpio.

 arch/mips/alchemy/common/irq.c |   34 ++++++++++++++++++++++++++--------
 1 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index c88c821..d670928 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -354,6 +354,28 @@ static void au1x_ic1_ack(unsigned int irq_nr)
 	au_sync();
 }

+static void au1x_ic0_maskack(unsigned int irq_nr)
+{
+	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
+
+	au_writel(1 << bit, IC0_WAKECLR);
+	au_writel(1 << bit, IC0_MASKCLR);
+	au_writel(1 << bit, IC0_RISINGCLR);
+	au_writel(1 << bit, IC0_FALLINGCLR);
+	au_sync();
+}
+
+static void au1x_ic1_maskack(unsigned int irq_nr)
+{
+	unsigned int bit = irq_nr - AU1000_INTC1_INT_BASE;
+
+	au_writel(1 << bit, IC1_WAKECLR);
+	au_writel(1 << bit, IC1_MASKCLR);
+	au_writel(1 << bit, IC1_RISINGCLR);
+	au_writel(1 << bit, IC1_FALLINGCLR);
+	au_sync();
+}
+
 static int au1x_ic1_setwake(unsigned int irq, unsigned int on)
 {
 	unsigned int bit = irq - AU1000_INTC1_INT_BASE;
@@ -379,25 +401,21 @@ static int au1x_ic1_setwake(unsigned int irq, unsigned int on)
 /*
  * irq_chips for both ICs; this way the mask handlers can be
  * as short as possible.
- *
- * NOTE: the ->ack() callback is used by the handle_edge_irq
- *	 flowhandler only, the ->mask_ack() one by handle_level_irq,
- *	 so no need for an irq_chip for each type of irq (level/edge).
  */
 static struct irq_chip au1x_ic0_chip = {
 	.name		= "Alchemy-IC0",
-	.ack		= au1x_ic0_ack,		/* edge */
+	.ack		= au1x_ic0_ack,
 	.mask		= au1x_ic0_mask,
-	.mask_ack	= au1x_ic0_mask,	/* level */
+	.mask_ack	= au1x_ic0_maskack,
 	.unmask		= au1x_ic0_unmask,
 	.set_type	= au1x_ic_settype,
 };

 static struct irq_chip au1x_ic1_chip = {
 	.name		= "Alchemy-IC1",
-	.ack		= au1x_ic1_ack,		/* edge */
+	.ack		= au1x_ic1_ack,
 	.mask		= au1x_ic1_mask,
-	.mask_ack	= au1x_ic1_mask,	/* level */
+	.mask_ack	= au1x_ic1_maskack,
 	.unmask		= au1x_ic1_unmask,
 	.set_type	= au1x_ic_settype,
 	.set_wake	= au1x_ic1_setwake,
-- 
1.6.5
