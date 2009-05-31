Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 19:31:27 +0100 (BST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:34590 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024309AbZEaSbJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 31 May 2009 19:31:09 +0100
Received: by mail-ew0-f219.google.com with SMTP id 19so7634149ewy.0
        for <multiple recipients>; Sun, 31 May 2009 11:31:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=fpfpIehskgRNF+asZ+oqzdATRKkGzNnu4iPk2hdgKR4=;
        b=GnQEpYfSKRn9ewjPrHv2JO1vNlKdDKGR83GIObbKP6BVFBI4UFVgzdX8dmrEd/Xoip
         fqA6VK1dddWE4qpcFqdgGlrLWwLPjSOiHvo86a31sCWOKW8Pb3gspRuRjs3ahhg3pCx/
         Lb+SmpWs7Q3UgRCfwrxgVBf8MmfLaeRaGAmVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=eyJgDlBcyfE2/PbREHYcUdEaPeszbeJ3K6bZXpcuUGgiVz71usib5bH3UGdtLiw0V8
         5soVniCNiNqtZy0jzM7Lq1tnjVX7Y0MTpoxneCAiYfowFSM6YiPxXL3glXFhDGd0+N/2
         fGJaWsIwNNt7PqRm9jnhvDG69jzvoUEjeJu4M=
Received: by 10.210.39.2 with SMTP id m2mr3012289ebm.30.1243794668780;
        Sun, 31 May 2009 11:31:08 -0700 (PDT)
Received: from ?192.168.1.20? (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 7sm6220010eyb.55.2009.05.31.11.31.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 11:31:08 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sun, 31 May 2009 20:31:05 +0200
Subject: [PATCH 09/10] bcm63xx: enable SSB bus support in defconfig
MIME-Version: 1.0
X-UID:	141
X-Length: 2166
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905312031.06050.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch enables the SSB bus support in the
default configuration.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/configs/bcm63xx_defconfig b/arch/mips/configs/bcm63xx_defconfig
index fc99a10..ea00c18 100644
--- a/arch/mips/configs/bcm63xx_defconfig
+++ b/arch/mips/configs/bcm63xx_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.30-rc6
-# Sun May 31 19:34:53 2009
+# Sun May 31 20:17:18 2009
 #
 CONFIG_MIPS=y
 
@@ -661,7 +661,18 @@ CONFIG_SSB_POSSIBLE=y
 #
 # Sonics Silicon Backplane
 #
-# CONFIG_SSB is not set
+CONFIG_SSB=y
+CONFIG_SSB_SPROM=y
+CONFIG_SSB_PCIHOST_POSSIBLE=y
+CONFIG_SSB_PCIHOST=y
+# CONFIG_SSB_B43_PCI_BRIDGE is not set
+CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
+# CONFIG_SSB_PCMCIAHOST is not set
+# CONFIG_SSB_SILENT is not set
+# CONFIG_SSB_DEBUG is not set
+CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
+# CONFIG_SSB_DRIVER_PCICORE is not set
+# CONFIG_SSB_DRIVER_MIPS is not set
 
 #
 # Multifunction device drivers
@@ -739,6 +750,7 @@ CONFIG_USB_EHCI_BIG_ENDIAN_MMIO=y
 # CONFIG_USB_ISP116X_HCD is not set
 # CONFIG_USB_ISP1760_HCD is not set
 CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_HCD_SSB is not set
 CONFIG_USB_OHCI_BIG_ENDIAN_DESC=y
 CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
 CONFIG_USB_OHCI_LITTLE_ENDIAN=y
