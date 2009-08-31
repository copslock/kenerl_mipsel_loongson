Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Aug 2009 20:28:27 +0200 (CEST)
Received: from mail-ew0-f225.google.com ([209.85.219.225]:59556 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493321AbZHaS2T (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 31 Aug 2009 20:28:19 +0200
Received: by ewy25 with SMTP id 25so4145893ewy.33
        for <multiple recipients>; Mon, 31 Aug 2009 11:28:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=k4NF42aAer1bAizsDqHBs55d6oqDin8327YucO9OfWE=;
        b=QZwg3iH+q43hgbbmPtpcZzQJ8C83S+uB44xmJteOuxOH4yMocMOvB75F6E0u9THGMM
         jbb6mD/aymv0F6YrE4Ye9kNAUrPSB3exGUjHm7wN74WmSpiQEESmjkKaqPfYw1QZvXY9
         Rdf/7RrYZC3uSLZkWN4TXothxF76UnXQcnMXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=TLuKgSj/voIH2HUdRIUeWDuIhP6n8dsJSokq6hBlX5T6/aU+yv6nShT091zY66Bjlo
         6sxNwrcgVLClUdQEm2fWYxO6P4Yuv9OHXqitqTQn3oyoqOytOnqm9JXfgPcGVd8BUll5
         W1OzysWauP1KLwh2gfQL85mJjJtXrwFVjHxoE=
Received: by 10.211.146.17 with SMTP id y17mr5845847ebn.43.1251743293664;
        Mon, 31 Aug 2009 11:28:13 -0700 (PDT)
Received: from lenovo.localnet (39.87.196-77.rev.gaoland.net [77.196.87.39])
        by mx.google.com with ESMTPS id 5sm132176eyh.42.2009.08.31.11.28.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 31 Aug 2009 11:28:13 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Mon, 31 Aug 2009 20:28:10 +0200
Subject: [PATCH 2/2] bcm63xx: only set the proper GPIO overlay settings
MIME-Version: 1.0
X-UID:	1319
X-Length: 1573
To:	ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908312028.10931.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch makes the GPIO pin multiplexing configuration
read the initial GPIO mode register value instead of
setting it initially to 0, then setting the correct
bits, this is safer.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index cfe32af..6ae4242 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -634,7 +634,7 @@ void __init board_prom_init(void)
 	/* setup pin multiplexing depending on board enabled device,
 	 * this has to be done this early since PCI init is done
 	 * inside arch_initcall */
-	val = 0;
+	val = bcm_gpio_readl(GPIO_MODE_REG);
 
 #ifdef CONFIG_PCI
 	if (board.has_pci) {
