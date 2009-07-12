Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jul 2009 18:42:20 +0200 (CEST)
Received: from rv-out-0708.google.com ([209.85.198.241]:57267 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492214AbZGLQmN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 12 Jul 2009 18:42:13 +0200
Received: by rv-out-0708.google.com with SMTP id l33so456475rvb.24
        for <multiple recipients>; Sun, 12 Jul 2009 09:42:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject
         :message-id:from:date;
        bh=TYTDlvPb2zRz165SCSpKYO4kYLv3G8GacH8fm2vrl+0=;
        b=lMaVvmF4uvt8IRJYgkD407rEuBB2eqS8Sd7L2bjpg7ectfMhRAdWZbip71I5owl6lN
         ZDahX1nMuvS13xBJsyul02lFnIwNboqZ0gOwZWaIUt9fBqFejt7sonnpbIq7imGfz+EI
         +dvUZ9xK/qEECHcW3YORDjitUN4EbYMKESIPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:message-id:from:date;
        b=hxeKKrC28DMg7HSkQoZbFi7e4wqBTnP6ULDzX2bCEPoSKR2dDHazAjOPD2eKaa7zkT
         +uDe4J9Xi482d7uWse2JgVOJMKhkQH2ZBnUQkZN5Rh4uKxOBznEjOR3UGo/w5jAq8B7r
         HDV8zTthTeFhmrpAvmmhYAPn0AWm0/5l0o5IE=
Received: by 10.140.165.21 with SMTP id n21mr2264325rve.268.1247416929755;
        Sun, 12 Jul 2009 09:42:09 -0700 (PDT)
Received: from localhost (71-17-214-13.sktn.hsdb.sasknet.sk.ca [71.17.214.13])
        by mx.google.com with ESMTPS id g22sm12744918rvb.5.2009.07.12.09.42.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Jul 2009 09:42:09 -0700 (PDT)
Received: from shane by localhost with local (Exim 4.63)
	(envelope-from <shane@localhost>)
	id 1MQ27q-00068L-IA; Sun, 12 Jul 2009 10:42:06 -0600
To:	Andrew_Hughes@pmc-sierra.com, florian@openwrt.org,
	linux-mips@linux-mips.org, Marc_St-Jean@pmc-sierra.com,
	ralf@linux-mips.org
Subject: [PATCH] Simplify and correct interrupt handling for MSP4200
Message-Id: <E1MQ27q-00068L-IA@localhost>
From:	Shane McDonald <mcdonald.shane@gmail.com>
Date:	Sun, 12 Jul 2009 10:42:06 -0600
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

The current interrupt handling code for the MSP4200 always
masks an interrupt before acknowledging it.  This is not required,
as that will be handled by the level interrupt handler.  This
change simplifies the MSP4200 code to remove the masking in the
ack routine, and makes sure that the minimum required operation
is performed for masking and acking, rather than always both
masking and acking the interrupt.

Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
---
 arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c b/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
index 66f6f85..61f3902 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
@@ -45,13 +45,6 @@ static inline void mask_msp_slp_irq(unsigned int irq)
  */
 static inline void ack_msp_slp_irq(unsigned int irq)
 {
-	mask_msp_slp_irq(irq);
-
-	/*
-	 * only really necessary for 18, 16-14 and sometimes 3:0 (since
-	 * these can be edge sensitive) but it doesn't hurt  for the others.
-	 */
-
 	/* check for PER interrupt range */
 	if (irq < MSP_PER_INTBASE)
 		*SLP_INT_STS_REG = (1 << (irq - MSP_SLP_INTBASE));
@@ -62,8 +55,7 @@ static inline void ack_msp_slp_irq(unsigned int irq)
 static struct irq_chip msp_slp_irq_controller = {
 	.name = "MSP_SLP",
 	.ack = ack_msp_slp_irq,
-	.mask = ack_msp_slp_irq,
-	.mask_ack = ack_msp_slp_irq,
+	.mask = mask_msp_slp_irq,
 	.unmask = unmask_msp_slp_irq,
 };
 
-- 
1.6.2.4
