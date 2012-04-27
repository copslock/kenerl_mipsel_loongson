Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 20:33:45 +0200 (CEST)
Received: from mail-pz0-f48.google.com ([209.85.210.48]:42380 "EHLO
        mail-pz0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903615Ab2D0Scx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Apr 2012 20:32:53 +0200
Received: by dakb39 with SMTP id b39so1178895dak.35
        for <multiple recipients>; Fri, 27 Apr 2012 11:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yYT+I2de8roh2DzcvLx5npBSG1fXAWk0MxotrzrwM34=;
        b=v95U+pxQq5vYJmXgh8GBeBfNX5fhsRhU0LgmvDUqIhlrrU79b7rB9raJgXIgeqP5lo
         L2e4+bgYjk1GAlJJP6fr8bYHBv3wu1OWu2fbmJhEdUnfaSFa23TNr2Kmy1ILVNaj5Fbo
         4Tf+evn0VDI5r+ZE4opwGrnDMqYcrWdBNOcn9XrckQ/7UNyN3IDTsIC4PqN/ysoniAAG
         WIu7XvVB/trZMhLRwBcJIeKuMfQ9HyzhMb8YpWPgO84x/WszjQMHxp03EPOe97N7nnDB
         MhnRMIjpBUv0vhUIFhsk09vC+r0XeKfDlQl+enIWkNjC74+ZaskthyYGFKj+390MoOXc
         IjIA==
Received: by 10.68.219.226 with SMTP id pr2mr17501934pbc.66.1335551566607;
        Fri, 27 Apr 2012 11:32:46 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id wf6sm7177724pbc.8.2012.04.27.11.32.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Apr 2012 11:32:45 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3RIWivX019626;
        Fri, 27 Apr 2012 11:32:44 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3RIWiIg019625;
        Fri, 27 Apr 2012 11:32:44 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 1/8] MIPS: OCTEON: Add detection of cnf71xx parts.
Date:   Fri, 27 Apr 2012 11:32:33 -0700
Message-Id: <1335551560-19581-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1335551560-19581-1-git-send-email-ddaney.cavm@gmail.com>
References: <1335551560-19581-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Also add cvmx_get_octeon_family().

Both of these are needed by the upcoming register definition refresh
patch.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/octeon/octeon-model.h |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/octeon/octeon-model.h b/arch/mips/include/asm/octeon/octeon-model.h
index 4e338a4..59d9426 100644
--- a/arch/mips/include/asm/octeon/octeon-model.h
+++ b/arch/mips/include/asm/octeon/octeon-model.h
@@ -61,6 +61,16 @@
 #define OM_MATCH_5XXX_FAMILY_MODELS     0x20000000
 /* Match all cn6XXX Octeon models. */
 #define OM_MATCH_6XXX_FAMILY_MODELS     0x40000000
+/* Match all cnf7XXX Octeon models. */
+#define OM_MATCH_F7XXX_FAMILY_MODELS    0x80000000
+
+/*
+ * CNF7XXX models with new revision encoding
+ */
+#define OCTEON_CNF71XX_PASS1_0  0x000d9400
+
+#define OCTEON_CNF71XX          (OCTEON_CNF71XX_PASS1_0 | OM_IGNORE_REVISION)
+#define OCTEON_CNF71XX_PASS1_X  (OCTEON_CNF71XX_PASS1_0 | OM_IGNORE_MINOR_REVISION)
 
 /*
  * CN6XXX models with new revision encoding
@@ -313,6 +323,14 @@ static inline int __octeon_is_model_runtime__(uint32_t model)
 const char *octeon_model_get_string(uint32_t chip_id);
 const char *octeon_model_get_string_buffer(uint32_t chip_id, char *buffer);
 
+/*
+ * Return the octeon family, i.e., ProcessorID of the PrID register.
+ */
+static inline uint32_t cvmx_get_octeon_family(void)
+{
+	return (cvmx_get_proc_id() & OCTEON_FAMILY_MASK);
+}
+
 #include "octeon-feature.h"
 
 #endif /* __OCTEON_MODEL_H__ */
-- 
1.7.2.3
