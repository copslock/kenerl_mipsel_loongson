Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 23:11:08 +0200 (CEST)
Received: from mail-pb0-f48.google.com ([209.85.160.48]:37554 "EHLO
        mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835278Ab3FMVLGgmowA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jun 2013 23:11:06 +0200
Received: by mail-pb0-f48.google.com with SMTP id ma3so5297542pbc.21
        for <multiple recipients>; Thu, 13 Jun 2013 14:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=la+k1k+NlRo+AlU3ynj7ZZgqAnfcLLA1gvyRqdfeJz0=;
        b=U3J5jP5cYO0dfcQNETZcpq8RhqHy7dlyVftBfIj8hbmUqHgfWBkG+QmTLFKyGENev1
         b+z5YA15dXoUm8puZge80HzfWosM24W6lhQO1FbzDUbi5Wiv0VAB5geGmnv7oPAwU5EM
         p8cMvyig74oBb30Arq0RLhDd1B69U66LrQiowbUXfEdRbit2zSuNOxPeOqE2vwEorf4w
         2f2AD4OR9Q+7UEcPNW2oDR0MDv/x1F6N7sSVkKgAwNjTls5KG0xj0isPpIm9ZPtYjdl4
         vVRtDCzZNwmpioRpNq4SWcGQ39/cGVL98LZeW+wHhlCwqh0xuFNqy89GQ3hB1tkCZ5/U
         eIJw==
X-Received: by 10.68.198.69 with SMTP id ja5mr2589680pbc.183.1371157859656;
        Thu, 13 Jun 2013 14:10:59 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id at1sm24713552pbc.10.2013.06.13.14.10.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 14:10:58 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5DLAuqt017100;
        Thu, 13 Jun 2013 14:10:56 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5DLAtKt017099;
        Thu, 13 Jun 2013 14:10:55 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS/OCTEON: Override default address space layout.
Date:   Thu, 13 Jun 2013 14:10:47 -0700
Message-Id: <1371157847-17066-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

OCTEON II cannot execute code in the default CAC_BASE space, so we
supply a value (0x8000000000000000) that does work.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/mach-cavium-octeon/spaces.h | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/spaces.h

diff --git a/arch/mips/include/asm/mach-cavium-octeon/spaces.h b/arch/mips/include/asm/mach-cavium-octeon/spaces.h
new file mode 100644
index 0000000..daa91ac
--- /dev/null
+++ b/arch/mips/include/asm/mach-cavium-octeon/spaces.h
@@ -0,0 +1,24 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012 Cavium, Inc.
+ */
+#ifndef _ASM_MACH_CAVIUM_OCTEON_SPACES_H
+#define _ASM_MACH_CAVIUM_OCTEON_SPACES_H
+
+#include <linux/const.h>
+
+#ifdef CONFIG_64BIT
+/* They are all the same and some OCTEON II cores cannot handle 0xa8.. */
+#define CAC_BASE		_AC(0x8000000000000000, UL)
+#define UNCAC_BASE		_AC(0x8000000000000000, UL)
+#define IO_BASE			_AC(0x8000000000000000, UL)
+
+
+#endif /* CONFIG_64BIT */
+
+#include <asm/mach-generic/spaces.h>
+
+#endif /* _ASM_MACH_CAVIUM_OCTEON_SPACES_H */
-- 
1.7.11.7
