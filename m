Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Aug 2009 18:09:32 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:33132 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492812AbZHVQJ0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 22 Aug 2009 18:09:26 +0200
Received: by bwz4 with SMTP id 4so1099359bwz.0
        for <multiple recipients>; Sat, 22 Aug 2009 09:09:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=RsZHI9T3ZCqEGGdEig3/FJrY4tKQGvDviQTAT6LK3oo=;
        b=Qmi2tiBcyPE7/rhVRtxf7VkdvhsH9srqlAsOXbSQH7yk1w6D+gxnJNSiAP0XDIoW/O
         tcPJtlRgU3sfkZENC0Yom7o+hNVLOwnhk47SywqlILSpeeQm3pM611MdGctFLC8aPJcM
         R612c9ldyWFjLHSi6mdOTYmbFm58VOU/aF0vA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uRzoiVsvrrfJD1/p0qnD3khviRrBrUdUjJjvYJFCGO5DbYjzffjOdFE/7LceCxv646
         bn32ldd5zE4805RXMqFnwRrpaBzkUsuR82zc3qNKTWEmctfz+IWKBhjO0/8dwdbXy1XJ
         NnvTma1LI8e7A0HVXGrtFmxy3FV47Acij5edU=
Received: by 10.223.143.79 with SMTP id t15mr1613850fau.6.1250957361280;
        Sat, 22 Aug 2009 09:09:21 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id c28sm4086308fka.19.2009.08.22.09.09.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 Aug 2009 09:09:20 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] Alchemy: override loops_per_jiffy detection
Date:	Sat, 22 Aug 2009 18:09:12 +0200
Message-Id: <1250957352-14359-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.4
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

The loops_per_jiffy detection in generic calibrate_delay is a bit off
(by ~0.5% usually); calculate the correct value based on detected core
clock.  BogoMIPS value will now reflect cpu core clock correctly.

(Blatantly stolen from the SH port).

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/Kconfig                |    2 +-
 arch/mips/alchemy/common/setup.c |   11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3ca0fe1..56c8139 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -700,7 +700,7 @@ config GENERIC_HWEIGHT
 
 config GENERIC_CALIBRATE_DELAY
 	bool
-	default y
+	default y if !MACH_ALCHEMY
 
 config GENERIC_CLOCKEVENTS
 	bool
diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 3f036b3..5ea7e1a 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -74,6 +74,17 @@ void __init plat_mem_setup(void)
 	iomem_resource.end = IOMEM_RESOURCE_END;
 }
 
+void __cpuinit calibrate_delay(void)
+{
+	loops_per_jiffy = (get_au1x00_speed() >> 1) / HZ;
+
+	printk(KERN_INFO "Calibrating delay loop (skipped)... "
+			 "%lu.%02lu BogoMIPS PRESET (lpj=%lu)\n",
+			 loops_per_jiffy/(500000/HZ),
+			 (loops_per_jiffy/(5000/HZ)) % 100,
+			 loops_per_jiffy);
+}
+
 #if defined(CONFIG_64BIT_PHYS_ADDR)
 /* This routine should be valid for all Au1x based boards */
 phys_t __fixup_bigphys_addr(phys_t phys_addr, phys_t size)
-- 
1.6.3.3
