Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2012 02:06:17 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:58252 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903681Ab2EOAFC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 May 2012 02:05:02 +0200
Received: by dadm1 with SMTP id m1so7456784dad.36
        for <multiple recipients>; Mon, 14 May 2012 17:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wZ+r606Caxx+x6PtXzR3EjM5YYCCY5w6nSrlY95OrOI=;
        b=LhMg2Ezd31v8n2bpbtXYhLM1AB1VRJH+aQG1GN5Qji0tKr4CQR55zk2w452vzy/WGu
         winSnGlsZ8MLQlDyDWqk45yvIx1ak0NjQy68HAtEq0GpKOk5ABDp5mZc1eXkreELoHr9
         y3C+cR3PNU8SwCelY8v3Ahv6Gk5tN36Ar9/a2qH5bNA4c8/tJVkQEjJ2Rf4XQmvwDmdA
         JCsiLJLTEDg75SB3iB+tSGAv5abCPdr4ET7hWkdbOVIvg8tXJMFuvHFKLu6nDty4wXw4
         ags7ZPtn1sUXItn1iVmZb+M/gE/DekmumM1UXPYnCyuyCNUcGN1H29b3AjPPTNKvdnlv
         hKmA==
Received: by 10.68.203.40 with SMTP id kn8mr27247256pbc.162.1337040295665;
        Mon, 14 May 2012 17:04:55 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id pu9sm23687524pbc.36.2012.05.14.17.04.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 May 2012 17:04:53 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q4F04qNK016065;
        Mon, 14 May 2012 17:04:52 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q4F04qrm016064;
        Mon, 14 May 2012 17:04:52 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH v2 3/5] MIPS: Octeon: Use board_cache_error_setup for cache error handler setup.
Date:   Mon, 14 May 2012 17:04:48 -0700
Message-Id: <1337040290-16015-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1337040290-16015-1-git-send-email-ddaney.cavm@gmail.com>
References: <1337040290-16015-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/mm/c-octeon.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index 47037ec..44e69e7 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -21,6 +21,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/r4kcache.h>
+#include <asm/traps.h>
 #include <asm/mmu_context.h>
 #include <asm/war.h>
 
@@ -248,6 +249,11 @@ static void __cpuinit probe_octeon(void)
 	}
 }
 
+static void  __cpuinit octeon_cache_error_setup(void)
+{
+	extern char except_vec2_octeon;
+	set_handler(0x100, &except_vec2_octeon, 0x80);
+}
 
 /**
  * Setup the Octeon cache flush routines
@@ -255,12 +261,6 @@ static void __cpuinit probe_octeon(void)
  */
 void __cpuinit octeon_cache_init(void)
 {
-	extern unsigned long ebase;
-	extern char except_vec2_octeon;
-
-	memcpy((void *)(ebase + 0x100), &except_vec2_octeon, 0x80);
-	octeon_flush_cache_sigtramp(ebase + 0x100);
-
 	probe_octeon();
 
 	shm_align_mask = PAGE_SIZE - 1;
@@ -280,6 +280,8 @@ void __cpuinit octeon_cache_init(void)
 
 	build_clear_page();
 	build_copy_page();
+
+	board_cache_error_setup = octeon_cache_error_setup;
 }
 
 /**
-- 
1.7.2.3
