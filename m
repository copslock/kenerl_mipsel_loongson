Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 15:20:07 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:38101 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491104Ab1BQOUE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 15:20:04 +0100
Received: by fxm19 with SMTP id 19so2569401fxm.36
        for <multiple recipients>; Thu, 17 Feb 2011 06:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=8VbqB4HUwSSNGrjWF7nh4WuLZOEbYgMoAYnui4kVdEE=;
        b=Sph+3jcV5N8ywFwgVywWwA2uV5d0s8jykH88jXP6jpCqb4MzUFiSfJX7qlyfsPT4Fp
         +fLdp8rERrUT+dYK/YZcyRBTIl+xKoNxc7XeXbqWRMQUaZqctf5uDP4Hwx1A/fEg0CfP
         y/2u0JBBtMU4kWXGJKIiGWPe46kXvCpSkHEfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Ubn7TXXYk1LdoEdaSvsSanzKm+ZL/nimrjm8IXNC/Pm3I0hMmRcUVCiaSoRkvWRXxa
         z95xzThK+Xvv9xZ3Pbv5sx6hkKQsMkNzutiSyiHsGuOuxWm0vpSoZYSvuVEPPNdjKni2
         7mE80UHl9/aZxRPhkzLTaFKJdWUclbA7ScWVA=
Received: by 10.223.83.208 with SMTP id g16mr2462370fal.52.1297952398899;
        Thu, 17 Feb 2011 06:19:58 -0800 (PST)
Received: from localhost.localdomain (t35.niisi.ras.ru [193.232.173.35])
        by mx.google.com with ESMTPS id n1sm459498fam.40.2011.02.17.06.19.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 06:19:58 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Antony Pavlov <antonynpavlov@gmail.com>
Subject: [PATCH] MIPS: Octeon: Kconfig: fix helper dependency
Date:   Thu, 17 Feb 2011 17:28:26 +0300
Message-Id: <1297952906-1099-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
Precedence: bulk
X-list: linux-mips

The option CAVIUM_OCTEON_HELPER does not depend
on CPU_CAVIUM_OCTEON option.
So my .config file for MIPS Malta board contains

 CONFIG_MIPS_MALTA=y
 ...
 # CONFIG_CAVIUM_OCTEON_SIMULATOR is not set
 # CONFIG_CAVIUM_OCTEON_REFERENCE_BOARD is not set
 ...
 CONFIG_CAVIUM_OCTEON_HELPER=y

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/cavium-octeon/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index caae228..a6a2f3c 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -97,7 +97,7 @@ config ARCH_SPARSEMEM_ENABLE
 
 config CAVIUM_OCTEON_HELPER
 	def_bool y
-	depends on OCTEON_ETHERNET || PCI
+	depends on CPU_CAVIUM_OCTEON && (OCTEON_ETHERNET || PCI)
 
 config IOMMU_HELPER
 	bool
-- 
1.7.1
