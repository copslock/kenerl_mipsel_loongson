Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 18:50:04 +0100 (BST)
Received: from mail-ew0-f171.google.com ([209.85.219.171]:61850 "EHLO
	mail-ew0-f171.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025366AbZEURt5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 May 2009 18:49:57 +0100
Received: by ewy19 with SMTP id 19so1481127ewy.0
        for <multiple recipients>; Thu, 21 May 2009 10:49:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=M0N1KWeGtOhMCq5RksF6ud9+AISF+eAc4maEZG2BRkQ=;
        b=fsh++wB7nz8M+z9Y+WJ8McSUedMJvruuBCR9aMIiIuf2PKTGGrURjUiqa5Nln6pg4u
         ci7ZVxrFwe47Gtjf0ZP2dOTzu88p/SeU5ZCbdiDtKYxB3gwcuXX4iQHVIdlgRrXFQ1ua
         5xo8PiYbebcb+o8/RDhDJ8zwToH02nx0T7/K4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=bmQ8+gSarBGF35o5m1aCLM4T4r0AGiE8CvqjE1udcRwNUAiSChrMfu/C0Zsfvl/KUo
         WRa/M/zz2x2ienCe3lJebaPYBltK4GMsz17bact0xQKHHJWpiQkMMqQ1oOEbyjpqZDbX
         vNeP+YJqyv9jxbWYqwDZeHbFar95TOyLZqPus=
Received: by 10.210.142.6 with SMTP id p6mr959636ebd.33.1242928185879;
        Thu, 21 May 2009 10:49:45 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 5sm1895348eyf.48.2009.05.21.10.49.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 May 2009 10:49:45 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Thu, 21 May 2009 19:49:39 +0200
Subject: [PATCH 1/2] rb532: cleanup cpu-features-overrides
MIME-Version: 1.0
X-UID:	114
X-Length: 1499
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905211949.41057.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Remove commented out definitions.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h 
b/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h
index f3bc7ef..c3e4d3a 100644
--- a/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h
@@ -53,11 +53,6 @@
 #define cpu_has_smartmips		0
 
 #define cpu_has_vtag_icache		0
-/* #define cpu_has_dc_aliases		? */
-/* #define cpu_has_ic_fills_f_dc	? */
-/* #define cpu_has_pindexed_dcache	? */
-
-/* #define cpu_icache_snoops_remote_store	? */
 
 #define cpu_has_mips32r1		1
 #define cpu_has_mips32r2		0
