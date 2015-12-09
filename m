Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 19:00:23 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36835 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008244AbbLISAWBlwsm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 19:00:22 +0100
Received: by pfbc17 with SMTP id c17so3521719pfb.3
        for <linux-mips@linux-mips.org>; Wed, 09 Dec 2015 10:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BlZlwV2BGyL6uToKDIZ1MCxzbOIyJfzXV7+Iix86Gok=;
        b=s5ZeANNmQzXXP6e7LUeYrwMWMFw/Z5JfkK+CjTtQ5Lrs9DW2MukzGkHLsAwsyZU6eC
         HnCnGOUN357t7PnZ5PAg5TSRJ0ztwbrulijLBUiD3bLohsWBXu/JbgKzVJAwTG0Ox7lk
         h61FmwMHKUcYz/sA/MIten4odg1ZvzVv0Wu9/0dzdl1TXLYpI7eBCBVHINA/9SZsYaxr
         Kg1X0KaSEIFjW5rCqrhoh1Vdy/WWx161iTEWbByBs/SfgTZLc7hFYQn0b7ntGtFSRcBS
         SZ48c4gJ7WWidNhqGprI380XrGdmKS6kFvtvWZI+LyGlZwXsEYV2mrsy/KWdE+CjYSzc
         l/eA==
X-Received: by 10.98.19.130 with SMTP id 2mr60559pft.93.1449684015962;
        Wed, 09 Dec 2015 10:00:15 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id 82sm13056535pfn.76.2015.12.09.10.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Dec 2015 10:00:15 -0800 (PST)
From:   David Decotigny <ddecotig@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mips@linux-mips.org,
        fcoe-devel@open-fcoe.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Decotigny <decot@googlers.com>
Subject: [PATCH net-next v4 01/19] lib/bitmap.c: conversion routines to/from u32 array
Date:   Wed,  9 Dec 2015 09:59:11 -0800
Message-Id: <1449683969-7305-2-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.6.0.rc2.230.g3dd15c0
In-Reply-To: <1449683969-7305-1-git-send-email-ddecotig@gmail.com>
References: <1449683969-7305-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddecotig@gmail.com
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

From: David Decotigny <decot@googlers.com>

Aimed at transferring bitmaps to/from user-space in a 32/64-bit agnostic
way.

Tested:
  unit tests (next patch) on qemu i386, x86_64, ppc, ppc64 BE and LE,
  ARM.

Signed-off-by: David Decotigny <decot@googlers.com>
---
 include/linux/bitmap.h |  6 ++++
 lib/bitmap.c           | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 9653fdb..f7dc158 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -59,6 +59,8 @@
  * bitmap_find_free_region(bitmap, bits, order)	Find and allocate bit region
  * bitmap_release_region(bitmap, pos, order)	Free specified bit region
  * bitmap_allocate_region(bitmap, pos, order)	Allocate specified bit region
+ * bitmap_from_u32array(dst, nbits, buf, nwords) *dst = *buf (nwords 32b words)
+ * bitmap_to_u32array(buf, nwords, src, nbits)	*buf = *dst (nwords 32b words)
  */
 
 /*
@@ -163,6 +165,10 @@ extern void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 extern int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order);
 extern void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order);
 extern int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order);
+extern void bitmap_from_u32array(unsigned long *bitmap, unsigned int nbits,
+				 const u32 *buf, unsigned int nwords);
+extern void bitmap_to_u32array(u32 *buf, unsigned int nwords,
+			       const unsigned long *bitmap, unsigned int nbits);
 #ifdef __BIG_ENDIAN
 extern void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int nbits);
 #else
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 8148143..e1cc648 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -12,6 +12,8 @@
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
 
 #include <asm/page.h>
 #include <asm/uaccess.h>
@@ -1060,6 +1062,90 @@ int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
 EXPORT_SYMBOL(bitmap_allocate_region);
 
 /**
+ * bitmap_from_u32array - copy the contents of a u32 array of bits to bitmap
+ *	@bitmap: array of unsigned longs, the destination bitmap, non NULL
+ *	@nbits: number of bits in @bitmap
+ *	@buf: array of u32 (in host byte order), the source bitmap, non NULL
+ *	@nwords: number of u32 words in @buf
+ *
+ * copy min(nbits, 32*nwords) bits from @buf to @bitmap, remaining
+ * bits between nword and nbits in @bitmap (if any) are cleared. In
+ * last word of @bitmap, the bits beyond nbits (if any) are kept
+ * unchanged.
+ */
+void bitmap_from_u32array(unsigned long *bitmap, unsigned int nbits,
+			  const u32 *buf, unsigned int nwords)
+{
+	unsigned int k;
+	const u32 *src = buf;
+
+	for (k = 0; k < BITS_TO_LONGS(nbits); ++k) {
+		unsigned long part = 0;
+
+		if (nwords) {
+			part = *src++;
+			nwords--;
+		}
+
+#if BITS_PER_LONG == 64
+		if (nwords) {
+			part |= ((unsigned long) *src++) << 32;
+			nwords--;
+		}
+#endif
+
+		if (k < nbits/BITS_PER_LONG)
+			bitmap[k] = part;
+		else {
+			unsigned long mask = BITMAP_LAST_WORD_MASK(nbits);
+
+			bitmap[k] = (bitmap[k] & ~mask) | (part & mask);
+		}
+	}
+}
+EXPORT_SYMBOL(bitmap_from_u32array);
+
+/**
+ * bitmap_to_u32array - copy the contents of bitmap to a u32 array of bits
+ *	@buf: array of u32 (in host byte order), the dest bitmap, non NULL
+ *	@nwords: number of u32 words in @buf
+ *	@bitmap: array of unsigned longs, the source bitmap, non NULL
+ *	@nbits: number of bits in @bitmap
+ *
+ * copy min(nbits, 32*nwords) bits from @bitmap to @buf. Remaining
+ * bits after nbits in @buf (if any) are cleared.
+ */
+void bitmap_to_u32array(u32 *buf, unsigned int nwords,
+			const unsigned long *bitmap, unsigned int nbits)
+{
+	unsigned int k = 0;
+	u32 *dst = buf;
+
+	while (nwords) {
+		unsigned long part = 0;
+
+		if (k < BITS_TO_LONGS(nbits)) {
+			part = bitmap[k];
+			if (k >= nbits/BITS_PER_LONG)
+				part &= BITMAP_LAST_WORD_MASK(nbits);
+			k++;
+		}
+
+		*dst++ = part & 0xffffffffUL;
+		nwords--;
+
+#if BITS_PER_LONG == 64
+		if (nwords) {
+			part >>= 32;
+			*dst++ = part & 0xffffffffUL;
+			nwords--;
+		}
+#endif
+	}
+}
+EXPORT_SYMBOL(bitmap_to_u32array);
+
+/**
  * bitmap_copy_le - copy a bitmap, putting the bits into little-endian order.
  * @dst:   destination buffer
  * @src:   bitmap to copy
-- 
2.6.0.rc2.230.g3dd15c0
