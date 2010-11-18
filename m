Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2010 09:05:59 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:41039 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492370Ab0KRIFu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Nov 2010 09:05:50 +0100
Received: by gyf1 with SMTP id 1so1793033gyf.36
        for <multiple recipients>; Thu, 18 Nov 2010 00:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=ajiYjWnuGVkXQOyYQEjdy3lao1fTBTDkTyWkesw02wY=;
        b=VOzKsYzu3yCRIFevrNk9xRYYY1MKw/d+P4fsR2XmZ4ctEuAZAa3c/RvP8REPTyqrf5
         fWrAcZKwoF6K/VXJSROAe5ABOpQmVYubtEWOISVAhGi0me+ebgeMAkobyloU1TOBJP1F
         1uGaSDoaqN9+zczX4fMXtuZF7HrdFAMDdoUoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=eOOXa9anJHTWSXZz/mILrhPMd6Tbf5X7Nt8fZWiuuwJYc0gktdQWNlXUchIAdoBpPr
         SCWgMuiRy3M3Y5i4HsyqJZM4fZX64Qi//zUtR9fnnu87VPCJPLb3k1SxxAKMqGcs41fp
         fS4T89nmB2MlGvVpaQ5/LLPkCTio1KKAcr6Tg=
Received: by 10.90.15.31 with SMTP id 31mr596998ago.10.1290067542761;
        Thu, 18 Nov 2010 00:05:42 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id j21sm84478yha.12.2010.11.18.00.05.39
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 00:05:42 -0800 (PST)
Subject: [PATCH] Select R4K timer lib for all MSP platforms
From:   Anoop P A <anoop.pa@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 18 Nov 2010 13:42:28 +0530
Message-ID: <1290067948.9091.14.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

>From c872cbbe5f475d3bb3cb7f821270cb466eead1f7 Mon Sep 17 00:00:00 2001
From: Anoop P A <anoop.pa@gmail.com>
Signed-off-by: Anoop P A <anoop.pa@gmail.com>
Date: Thu, 18 Nov 2010 01:33:36 +0530
Subject: [PATCH] Select R4K timer lib for all MSP platforms

---
 arch/mips/Kconfig                       |    2 ++
 arch/mips/pmc-sierra/Kconfig            |    4 ----
 arch/mips/pmc-sierra/msp71xx/msp_time.c |    2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7fc6bd1..168cdbe 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -316,6 +316,8 @@ config PNX8550_STB810
 config PMC_MSP
 	bool "PMC-Sierra MSP chipsets"
 	depends on EXPERIMENTAL
+	select CEVT_R4K
+	select CSRC_R4K
 	select DMA_NONCOHERENT
 	select SWAP_IO_SPACE
 	select NO_EXCEPT_FILL
diff --git a/arch/mips/pmc-sierra/Kconfig b/arch/mips/pmc-sierra/Kconfig
index c139988..8d79849 100644
--- a/arch/mips/pmc-sierra/Kconfig
+++ b/arch/mips/pmc-sierra/Kconfig
@@ -4,15 +4,11 @@ choice
 
 config PMC_MSP4200_EVAL
 	bool "PMC-Sierra MSP4200 Eval Board"
-	select CEVT_R4K
-	select CSRC_R4K
 	select IRQ_MSP_SLP
 	select HW_HAS_PCI
 
 config PMC_MSP4200_GW
 	bool "PMC-Sierra MSP4200 VoIP Gateway"
-	select CEVT_R4K
-	select CSRC_R4K
 	select IRQ_MSP_SLP
 	select HW_HAS_PCI
 
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_time.c
b/arch/mips/pmc-sierra/msp71xx/msp_time.c
index cca64e1..01df84c 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_time.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_time.c
@@ -81,7 +81,7 @@ void __init plat_time_init(void)
 	mips_hpt_frequency = cpu_rate/2;
 }
 
-unsigned int __init get_c0_compare_int(void)
+unsigned int __cpuinit get_c0_compare_int(void)
 {
 	return MSP_INT_VPE0_TIMER;
 }
-- 
1.7.0.4
