Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Mar 2010 17:57:50 +0100 (CET)
Received: from mail-bw0-f226.google.com ([209.85.218.226]:46587 "EHLO
        mail-bw0-f226.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491182Ab0CAQ5q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Mar 2010 17:57:46 +0100
Received: by bwz26 with SMTP id 26so2059174bwz.27
        for <linux-mips@linux-mips.org>; Mon, 01 Mar 2010 08:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ZhrEtnGrw5lNGsbHf5cjn6M+g2LxCITIL1NSHneOyU0=;
        b=mQQjhAOvggnwaQtjdkGWWrY/sV+Da5jZDAS+ghEjQ0eXU3xHjJ/fKu56CpzFdemUlJ
         lKjEVM7jx0tiE52BQ9WUv9NV+Eqy3xUnYHfsRRR7IpXeCZ+0om3hOiiE1p/b8LQ78SuB
         IULsrBcIH/aSRT2oSyDzZfflI4CdfkxAMC7fw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=l0ZweTv9UemvDeGXfjc2d1t8StdvtWVWCLQt3J7eXAv9DeZldXMxlshC6PMb07+b5P
         oi71/nB3Xph3bw6G0OCRg4ZCfLZDU3SPrHFLLlDxvsDw8ElthB70j/l+OFwXIqLs3SQO
         A0RE6n0/j02SIWr7aEnQWPswohb+OGs9rmgjU=
Received: by 10.204.33.210 with SMTP id i18mr3142630bkd.119.1267462658554;
        Mon, 01 Mar 2010 08:57:38 -0800 (PST)
Received: from localhost.localdomain (p5496CB22.dip.t-dialin.net [84.150.203.34])
        by mx.google.com with ESMTPS id 14sm2144589bwz.14.2010.03.01.08.57.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 08:57:37 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-PCMCIA <linux-pcmcia@lists.infradead.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] pcmcia: alchemy: fixup wrong comments
Date:   Mon,  1 Mar 2010 17:58:38 +0100
Message-Id: <1267462718-17383-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Commit 11b897cf84c37e6522db914793677e933ef311fb  changed expected
pcmcia area addresses from the 32bit pseudo to the real 36bit
addresses, but did not update the comments.
---
Applies to current linus-git.

 drivers/pcmcia/db1xxx_ss.c  |   19 ++++---------------
 drivers/pcmcia/xxs1500_ss.c |   16 +++-------------
 2 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
index 3889cf0..9254ab0 100644
--- a/drivers/pcmcia/db1xxx_ss.c
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -42,7 +42,6 @@ struct db1x_pcmcia_sock {
 	int		nr;		/* socket number */
 	void		*virt_io;
 
-	/* the "pseudo" addresses of the PCMCIA space. */
 	phys_addr_t	phys_io;
 	phys_addr_t	phys_attr;
 	phys_addr_t	phys_mem;
@@ -437,7 +436,7 @@ static int __devinit db1x_pcmcia_socket_probe(struct platform_device *pdev)
 	 * This includes IRQs for Carddetection/ejection, the card
 	 *  itself and optional status change detection.
 	 * Also, the memory areas covered by a socket.  For these
-	 *  we require the 32bit "pseudo" addresses (see the au1000.h
+	 *  we require the real 36bit addresses (see the au1000.h
 	 *  header for more information).
 	 */
 
@@ -459,11 +458,7 @@ static int __devinit db1x_pcmcia_socket_probe(struct platform_device *pdev)
 
 	ret = -ENODEV;
 
-	/*
-	 * pseudo-attr:  The 32bit address of the PCMCIA attribute space
-	 * for this socket (usually the 36bit address shifted 4 to the
-	 * right).
-	 */
+	/* 36bit PCMCIA Attribute area address */
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcmcia-attr");
 	if (!r) {
 		printk(KERN_ERR "pcmcia%d has no 'pseudo-attr' resource!\n",
@@ -472,10 +467,7 @@ static int __devinit db1x_pcmcia_socket_probe(struct platform_device *pdev)
 	}
 	sock->phys_attr = r->start;
 
-	/*
-	 * pseudo-mem:  The 32bit address of the PCMCIA memory space for
-	 * this socket (usually the 36bit address shifted 4 to the right)
-	 */
+	/* 36bit PCMCIA Memory area address */
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcmcia-mem");
 	if (!r) {
 		printk(KERN_ERR "pcmcia%d has no 'pseudo-mem' resource!\n",
@@ -484,10 +476,7 @@ static int __devinit db1x_pcmcia_socket_probe(struct platform_device *pdev)
 	}
 	sock->phys_mem = r->start;
 
-	/*
-	 * pseudo-io:  The 32bit address of the PCMCIA IO space for this
-	 * socket (usually the 36bit address shifted 4 to the right).
-	 */
+	/* 36bit PCMCIA IO area address */
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcmcia-io");
 	if (!r) {
 		printk(KERN_ERR "pcmcia%d has no 'pseudo-io' resource!\n",
diff --git a/drivers/pcmcia/xxs1500_ss.c b/drivers/pcmcia/xxs1500_ss.c
index 61560cd..f9009d3 100644
--- a/drivers/pcmcia/xxs1500_ss.c
+++ b/drivers/pcmcia/xxs1500_ss.c
@@ -218,11 +218,7 @@ static int __devinit xxs1500_pcmcia_probe(struct platform_device *pdev)
 
 	ret = -ENODEV;
 
-	/*
-	 * pseudo-attr:  The 32bit address of the PCMCIA attribute space
-	 * for this socket (usually the 36bit address shifted 4 to the
-	 * right).
-	 */
+	/* 36bit PCMCIA Attribute area address */
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcmcia-attr");
 	if (!r) {
 		dev_err(&pdev->dev, "missing 'pcmcia-attr' resource!\n");
@@ -230,10 +226,7 @@ static int __devinit xxs1500_pcmcia_probe(struct platform_device *pdev)
 	}
 	sock->phys_attr = r->start;
 
-	/*
-	 * pseudo-mem:  The 32bit address of the PCMCIA memory space for
-	 * this socket (usually the 36bit address shifted 4 to the right)
-	 */
+	/* 36bit PCMCIA Memory area address */
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcmcia-mem");
 	if (!r) {
 		dev_err(&pdev->dev, "missing 'pcmcia-mem' resource!\n");
@@ -241,10 +234,7 @@ static int __devinit xxs1500_pcmcia_probe(struct platform_device *pdev)
 	}
 	sock->phys_mem = r->start;
 
-	/*
-	 * pseudo-io:  The 32bit address of the PCMCIA IO space for this
-	 * socket (usually the 36bit address shifted 4 to the right).
-	 */
+	/* 36bit PCMCIA IO area address */
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcmcia-io");
 	if (!r) {
 		dev_err(&pdev->dev, "missing 'pcmcia-io' resource!\n");
-- 
1.7.0
