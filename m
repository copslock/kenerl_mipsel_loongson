Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 21:10:43 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:49445 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903864Ab1KPUKj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 21:10:39 +0100
Received: by iapp10 with SMTP id p10so1256086iap.36
        for <multiple recipients>; Wed, 16 Nov 2011 12:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=rcOMpGhU1sjDcrIen4OUNu8dNFqVlk5FyJv4W+qQ9nc=;
        b=fbPblJ/FSo/xnAlFSWrK7nI1/OfT5FhXOrLK6DN5kH59SwlREuhVLr0lEhGVGAWV0E
         MOkkJUMvFtpOTZEZ4mBayBbaRl7BFfSoSrJJCodWJ2Gupp4FxADlwi3eYnoexgSHqqoc
         yHUKlt6/HpXRrRc9dQYk5Z5Y3Lg7eYsLRlsdI=
Received: by 10.42.41.143 with SMTP id p15mr34244025ice.9.1321474232606;
        Wed, 16 Nov 2011 12:10:32 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id l28sm7040025ibc.3.2011.11.16.12.10.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 12:10:32 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAGKAT10013758;
        Wed, 16 Nov 2011 12:10:29 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAGKATtl013757;
        Wed, 16 Nov 2011 12:10:29 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Octeon: Unconditionally build __cvmx_helper_errata_qlm_disable_2nd_order_cdr
Date:   Wed, 16 Nov 2011 12:10:28 -0800
Message-Id: <1321474228-13726-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 31704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13804

From: David Daney <david.daney@cavium.com>

It is needed in !OCTEON_ETHERNET and !PCI too.  Since most people will
probably have both of these defined in any real configuration, there
is not really any size bloat from doing this.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/Kconfig            |    4 ----
 arch/mips/cavium-octeon/executive/Makefile |    2 +-
 2 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index cad555e..f9e275a 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -86,10 +86,6 @@ config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_STATIC
 
-config CAVIUM_OCTEON_HELPER
-	def_bool y
-	depends on OCTEON_ETHERNET || PCI
-
 config IOMMU_HELPER
 	bool
 
diff --git a/arch/mips/cavium-octeon/executive/Makefile b/arch/mips/cavium-octeon/executive/Makefile
index eec0b88..b6d6e84 100644
--- a/arch/mips/cavium-octeon/executive/Makefile
+++ b/arch/mips/cavium-octeon/executive/Makefile
@@ -16,4 +16,4 @@ obj-y += cvmx-pko.o cvmx-spi.o cvmx-cmd-queue.o \
 	cvmx-helper-loop.o cvmx-helper-spi.o cvmx-helper-util.o \
 	cvmx-interrupt-decodes.o cvmx-interrupt-rsl.o
 
-obj-$(CONFIG_CAVIUM_OCTEON_HELPER) += cvmx-helper-errata.o cvmx-helper-jtag.o
+obj-y += cvmx-helper-errata.o cvmx-helper-jtag.o
-- 
1.7.2.3
