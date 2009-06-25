Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jun 2009 10:38:21 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.145]:58174 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492750AbZFYIiP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Jun 2009 10:38:15 +0200
Received: by ey-out-1920.google.com with SMTP id 13so94603eye.54
        for <multiple recipients>; Thu, 25 Jun 2009 01:34:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KLhTHuNXiEanKq1C2RrQNeavvFAZBwlAeAY5mljX27U=;
        b=PFld6uUQ/fNucUQ0pOp2qIQFBaiqaeThjzui6WhD13v0P4ITIgmm4YvVhMsLMtgM1m
         VXX6tXnZTymAnpWNuSgwRiKUfqVi/Ze7aRmQgKQ7OuDY+Jlp6V3dWF5crc95pHK1Xo1s
         uzQgMMge47bLTxRz8Sc2L9MsyFXZu6/Oyu3dg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=TD1+8NStSL7WXRRKhUpU56+jM+HB6w8Ruf1SbuZkEZCbwC6DWV/KTiogpIbw0ndOQR
         DsqX8vVro4jVNktZhXO8j726w0geo1OODsRDRAe2qATi8twohNXzaFRZ8kdgbcQpQR9J
         U9KpzYt2Sx8kPJ7xS3YNPIjp2u7nVw3T2ToeI=
Received: by 10.210.28.18 with SMTP id b18mr1757711ebb.99.1245918876461;
        Thu, 25 Jun 2009 01:34:36 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 5sm851507eyf.57.2009.06.25.01.34.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 01:34:35 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Thu, 25 Jun 2009 10:34:31 +0200
Subject: [PATCH] Make Broadcom SoC naming options consistent
MIME-Version: 1.0
X-UID:	486
X-Length: 1544
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>, Maxim Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906251034.32811.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Ralf, Maxime,

This patch applies to the linux-bcm63xx.git tree. Thanks
--
From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] Make Broadcom SoC naming consistent

This patch makes the Broadcom SoC naming configuration
symbols consistent and to follow the Broadcom BCMXXXX
naming convention (commercial naming).

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d104dd2..8fdbc8f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -40,7 +40,7 @@ config BASLER_EXCITE
 	  Basler Vision Technologies AG.
 
 config BCM47XX
-	bool "BCM47XX based boards"
+	bool "Broadcom BCM47XX based boards"
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
@@ -61,7 +61,7 @@ config BCM47XX
 	 Support for BCM47XX based boards
 
 config BCM63XX
-	bool "Broadcom 63xx based boards"
+	bool "Broadcom BCM63XX based boards"
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
