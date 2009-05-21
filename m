Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 18:50:29 +0100 (BST)
Received: from mail-ew0-f171.google.com ([209.85.219.171]:36166 "EHLO
	mail-ew0-f171.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025367AbZEURuB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 May 2009 18:50:01 +0100
Received: by ewy19 with SMTP id 19so1481167ewy.0
        for <multiple recipients>; Thu, 21 May 2009 10:49:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=M2oMXw6rbZZwBdrOycte7UM09wAwEBvhvpCe/fk9vGE=;
        b=VE1I83x0jjCtHMDTQwZCwVpNbOY0LRz4VUVVXC4E2PqdYs84ziPgkTUgW4O8mNMGAG
         hOocNmGigBcUs+lsh29X7M/DtNzAcE8WyW6QXTNoAhhM2f5c9cJTyWPvQZOXqcoCxUlv
         n1iS05yFOJEzlrHegXiZow1sLTrqw136Nk/0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=krAQXzwP1O1tfnsCzkSD7BJpFewuuzs/MzSZ7OnhTEtf+TJUgkMmg9AfQl3CvlseLE
         C4Vc3MvTazwiPVT+xCQrc9chCANRskysiY8xe8dP+VXERPNONOt7ObO23ECp2PGtxW6h
         Q5azJNHsCEyAeV21UByBmKvY+A63pP0qU5bcY=
Received: by 10.210.105.8 with SMTP id d8mr1599117ebc.61.1242928190123;
        Thu, 21 May 2009 10:49:50 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 5sm5152728eyf.28.2009.05.21.10.49.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 May 2009 10:49:49 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Thu, 21 May 2009 19:49:47 +0200
Subject: [PATCH 2/2] rb532: check irq number when handling GPIO interrupts
MIME-Version: 1.0
X-UID:	115
X-Length: 1953
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905211949.47486.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch makes sure that we are not going to clear
or change the interrupt status of a GPIO interrupt
superior to 13 as this is the maximum number of GPIO
interrupt source (p.232 of the RC32434 reference manual).

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/rb532/irq.c b/arch/mips/rb532/irq.c
index 53eeb5e..afdcafc 100644
--- a/arch/mips/rb532/irq.c
+++ b/arch/mips/rb532/irq.c
@@ -151,7 +151,8 @@ static void rb532_disable_irq(unsigned int irq_nr)
 		mask |= intr_bit;
 		WRITE_MASK(addr, mask);
 
-		if (group == GPIO_MAPPED_IRQ_GROUP)
+		/* There is a maximum of 13 GPIO interrupts */
+		if (group == GPIO_MAPPED_IRQ_GROUP && irq_nr <= (GROUP4_IRQ_BASE + 13))
 			rb532_gpio_set_istat(0, irq_nr - GPIO_MAPPED_IRQ_BASE);
 
 		/*
@@ -174,7 +175,7 @@ static int rb532_set_type(unsigned int irq_nr, unsigned type)
 	int gpio = irq_nr - GPIO_MAPPED_IRQ_BASE;
 	int group = irq_to_group(irq_nr);
 
-	if (group != GPIO_MAPPED_IRQ_GROUP)
+	if (group != GPIO_MAPPED_IRQ_GROUP || irq_nr > (GROUP4_IRQ_BASE + 13))
 		return (type == IRQ_TYPE_LEVEL_HIGH) ? 0 : -EINVAL;
 
 	switch (type) {
