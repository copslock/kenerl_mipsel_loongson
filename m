Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2012 01:00:25 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:50785 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903565Ab2C1XAM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2012 01:00:12 +0200
Received: by obbup16 with SMTP id up16so2411193obb.36
        for <multiple recipients>; Wed, 28 Mar 2012 16:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=PWwSiNGSK3R1HjiUmoifTeyTmO8FkwUFqtpqrlky3w8=;
        b=BJzZmohpa46kV57/G26FUNJhnjLzXYct1mhGtONzmly9/aa9NYIjC08mc8Y4aewObS
         2saKfRsAzEOL19hvBwV2IWEGyCTxejgvaFEd4BGybDLoZQ7UqgYwSL++kQVdTtJwfHFQ
         zPNOBO63KXsM7Rl3XxyqupimDL6gpaXmbHyw0V8O8vbCWtDa/eIE0WQmX5jJSgqAJoSG
         G1OnG6YqAeHw/gWcxosOlwHmitBKFQJYXd0Omt8l230Dbz1eLpHOgQcIVeJ09z5+Ij1m
         AxrsiWbwlnaeGuf886rZPrXIbIHbeXTyeoCsYZjvZ5TcwiSAQHKukCL7YXJKW/XMW5J8
         NG7g==
Received: by 10.182.110.102 with SMTP id hz6mr4882386obb.58.1332975606190;
        Wed, 28 Mar 2012 16:00:06 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id o9sm4389768obd.21.2012.03.28.16.00.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 16:00:05 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q2SN02tP008853;
        Wed, 28 Mar 2012 16:00:03 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q2SN00rY008850;
        Wed, 28 Mar 2012 16:00:00 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Remove get_current_pgd().
Date:   Wed, 28 Mar 2012 15:59:58 -0700
Message-Id: <1332975598-8819-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <ddaney@caviumnetworks.com>

It is unused in the tree.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/mmu_context.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index 145bb81..50e0ac9 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -43,12 +43,6 @@ static inline void tlbmiss_handler_setup_pgd(unsigned long pgd)
 		write_c0_xcontext((unsigned long) smp_processor_id() << 51); \
 	} while (0)
 
-
-static inline unsigned long get_current_pgd(void)
-{
-	return PHYS_TO_XKSEG_CACHED((read_c0_context() >> 11) & ~0xfffUL);
-}
-
 #else /* CONFIG_MIPS_PGD_C0_CONTEXT: using  pgd_current*/
 
 /*
-- 
1.7.2.3
