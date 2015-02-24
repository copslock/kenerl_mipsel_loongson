Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 00:35:52 +0100 (CET)
Received: from mail-ig0-f180.google.com ([209.85.213.180]:46397 "EHLO
        mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006911AbbBXXfunjjgQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Feb 2015 00:35:50 +0100
Received: by mail-ig0-f180.google.com with SMTP id b16so1526604igk.1;
        Tue, 24 Feb 2015 15:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=lci4VZr2lE/PFdH76IUMjC7WAG14dLbeIjtGnlNA7FY=;
        b=FpM8KDFxQFbo1Rxq36DLztgacGqWy8WiT2cMwjXDQGf8RkwBel2VfyhWxyVYsscOYQ
         K5gCqfVwPpLVSJoWpnlPZEtpcraO+GA+xODgVF/l5VYJF1DKJyRvN9j9zdR12P+jrBu7
         DQMFArJLC0dq0JqrHRRYSgbU1ldMTyL/hYPNMTa3+3Y5Vxi1q8kJQWZbw4UiUIbUQcRY
         +AgAoxpxYRM0rJ46HeMHQlFwORvzL5cLDF+iOUY1CsHy8gFABsmInGlyoZwhPf/B5EWn
         Z75akhu7ABHwpt6LnacGlff9B2OHhTiKxqZzLFwcV2IUzWlcsWNItu47qS1UvV83inJI
         eU/g==
X-Received: by 10.107.8.213 with SMTP id h82mr789215ioi.89.1424820945490;
        Tue, 24 Feb 2015 15:35:45 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id a196sm2065147ioe.41.2015.02.24.15.35.40
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 24 Feb 2015 15:35:44 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id t1ONZddt020143;
        Tue, 24 Feb 2015 15:35:39 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id t1ONZb1T020142;
        Tue, 24 Feb 2015 15:35:37 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Expand __swp_offset() to carry 40 significant bits for 64-bit kernel.
Date:   Tue, 24 Feb 2015 15:35:34 -0800
Message-Id: <1424820934-20108-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45943
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

With CONFIG_MIGRATION, the PFN of the migrating pages is stored in
__swp_offset(), so we must have enough bits to store the largest
possible PFN.  OCTEON NUMA systems have 41 bits of physical address
space, so with 4K pages (12-bits), we need at least 29 bits to store
the PFN.

The current width of 24-bits is too narrow, so expand it all the way
out to 40-bits.  This leaves the low order 16 bits as zero which does
not interfere with any of the PTE bits.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/pgtable-64.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 1659bb9..cf661a2 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -279,14 +279,14 @@ extern void pgd_init(unsigned long page);
 extern void pmd_init(unsigned long page, unsigned long pagetable);
 
 /*
- * Non-present pages:  high 24 bits are offset, next 8 bits type,
- * low 32 bits zero.
+ * Non-present pages:  high 40 bits are offset, next 8 bits type,
+ * low 16 bits zero.
  */
 static inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
-{ pte_t pte; pte_val(pte) = (type << 32) | (offset << 40); return pte; }
+{ pte_t pte; pte_val(pte) = (type << 16) | (offset << 24); return pte; }
 
-#define __swp_type(x)		(((x).val >> 32) & 0xff)
-#define __swp_offset(x)		((x).val >> 40)
+#define __swp_type(x)		(((x).val >> 16) & 0xff)
+#define __swp_offset(x)		((x).val >> 24)
 #define __swp_entry(type, offset) ((swp_entry_t) { pte_val(mk_swap_pte((type), (offset))) })
 #define __pte_to_swp_entry(pte) ((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
-- 
1.7.11.7
