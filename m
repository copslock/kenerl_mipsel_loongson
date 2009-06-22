Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jun 2009 11:19:21 +0200 (CEST)
Received: from mail-ew0-f221.google.com ([209.85.219.221]:35512 "EHLO
	mail-ew0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491959AbZFVJTP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 Jun 2009 11:19:15 +0200
Received: by ewy21 with SMTP id 21so4021615ewy.0
        for <multiple recipients>; Mon, 22 Jun 2009 02:16:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bq7AQtDvAhbqkisXgjKzgZ4CxfzhnI2OgQA8wK3luEI=;
        b=WK50QNRViZKS7KZxUmw6SytnSL3NcN72gqolU/MgtEnnmMNfvxHLi7isq8uZejsHvb
         FvvQvWD+u4xfPhgTA0mIFSt3A75D/LYoAevamaYN1qt/WUFW6p742civhLQ7tcW2soLJ
         ag8uetiELoMu8SZTT1aq9u9rr0Yr9Zlw+hidM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=Ba3L9S8CIg3GsA4lW0oiPnsCDNL0QeBCmeU1GRFW4Cdmq622funoI71kpkhp07g/fZ
         oyXFmmd8U9NSiVUgBxLzOT5ansRA+VV04+XGCx0bWEG7IQgYpOxpM8o6MB5+QJhom8lt
         gxZbzi+MBCoinAYM5zUAg3SBxa1UvwNgB/qig=
Received: by 10.210.78.16 with SMTP id a16mr4608757ebb.6.1245662183117;
        Mon, 22 Jun 2009 02:16:23 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 10sm135365eyd.17.2009.06.22.02.16.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Jun 2009 02:16:22 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Mon, 22 Jun 2009 11:16:21 +0200
Subject: [PATCH 2/2] octeon: only build flash_setup code when CONFIG_MTD is set
MIME-Version: 1.0
X-UID:	344
X-Length: 1623
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	David Daney <ddaney@caviumnetworks.com>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906221116.21621.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch makes the flash_setup code be compiled only when
CONFIG_MTD is set, it does make sense to register a physmap
platform driver without the MTD subsystem being enabled.

CC: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 7c0528b..f1b401b 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -10,9 +10,10 @@
 #
 
 obj-y := setup.o serial.o octeon-irq.o csrc-octeon.o
-obj-y += dma-octeon.o flash_setup.o
+obj-y += dma-octeon.o
 obj-y += octeon-memcpy.o
 
+obj-$(CONFIG_MTD)		      += flash_setup.o
 obj-$(CONFIG_SMP)                     += smp.o
 obj-$(CONFIG_PCI)                     += pci-common.o
 obj-$(CONFIG_PCI)                     += pci.o
