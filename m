Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 May 2012 10:09:24 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:42245 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903551Ab2E3IIx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 May 2012 10:08:53 +0200
Received: by mail-pb0-f49.google.com with SMTP id rq13so7614914pbb.36
        for <multiple recipients>; Wed, 30 May 2012 01:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=2IsjCw25CWWg723CR3JC8Hp93aTY52slx5T6pAgklbs=;
        b=ubGVenaXxd7ZLC2gVoZUeMiKUAokoksY3az4RmcwZHarN6dXYb7KgA+mUwgTMJ46di
         t5ls0VhkxVtfoxFKraIOJQQIleg1dfQyHxa+1IWVGRcuIWfSSFXjqhr/xH1uq+LjYy5A
         xgV1oT39Qf1BTnwNWuvfumA62fu4R+okjEKan1gtkpBso78R1VvqBIIL5jHF6zTFXV5s
         aZc059zOatB59cwmiGQJ6JiwDMx0vGwhQPC91dyI7FccpaPP88/4NWyYmpOnbvE5LRAf
         bQE7N/r88SafphJ+QDLxEQOxZlZ5Idqu87Ijfb4BL6uTgiBCFZNHw/IGVhBa8/ZdexHv
         fNSQ==
Received: by 10.68.203.35 with SMTP id kn3mr16931517pbc.163.1338365332387;
        Wed, 30 May 2012 01:08:52 -0700 (PDT)
Received: from sdk (UQ1-221-171-23-195.tky.mesh.ad.jp. [221.171.23.195])
        by mx.google.com with ESMTPS id ok6sm16315823pbb.29.2012.05.30.01.08.49
        (version=SSLv3 cipher=OTHER);
        Wed, 30 May 2012 01:08:51 -0700 (PDT)
Date:   Wed, 30 May 2012 17:06:26 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: fix duplicate config ARCH_SPARSEMEM_ENABLE
Message-Id: <20120530170626.fe754584.yuasa@linux-mips.org>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 33480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/Kconfig               |    1 +
 arch/mips/cavium-octeon/Kconfig |    4 ----
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5e0f477..5c13f08 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1432,6 +1432,7 @@ config CPU_CAVIUM_OCTEON
 	select WEAK_ORDERING
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
+	select ARCH_SPARSEMEM_ENABLE
 	help
 	  The Cavium Octeon processor is a highly integrated chip containing
 	  many ethernet hardware widgets for networking tasks. The processor
diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index f9e275a..2f4f6d5 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -82,10 +82,6 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
 	help
 	  Lock the kernel's implementation of memcpy() into L2.
 
-config ARCH_SPARSEMEM_ENABLE
-	def_bool y
-	select SPARSEMEM_STATIC
-
 config IOMMU_HELPER
 	bool
 
-- 
1.7.0.4
