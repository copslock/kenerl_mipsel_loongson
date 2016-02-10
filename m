Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:30:05 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36153 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012431AbcBJA34v3AWx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:29:56 +0100
Received: by mail-pf0-f196.google.com with SMTP id e127so170305pfe.3
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X0X+ysdVtg85mjMcLaHpIMb57m+WFmXjefzfXfhjngs=;
        b=tunYcXPi6gW4Mw2xwygCtiK6zqC0CC92I1kaT+oXKbTkscem20DrYs27KMkpt0LMgR
         d+hEx3XYx/xswUZ8Ufs2kmNS9WNk9hcZAqaC+l+vIWHB4aWPdjrxpnUbqaSTzKl1q1jY
         aCBH3+fx9E1LMCkPAbbkukoo3wMKXPQwSnuu53ch7mb1QNB9puzCyossHHsc7wVX5vm7
         zclDn2ZBAHK6QqvlVE385M9OB5Qt6VUGH5aHHJaw+bzY91hsBbids64rkxCb55jA/4zc
         +4DWVJrT44mv2uO45aBva+5GxhYNwpfO5+zOxK2qGbNQsiPuQMRhlX0ttz0YL6fhhHqd
         UWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X0X+ysdVtg85mjMcLaHpIMb57m+WFmXjefzfXfhjngs=;
        b=RbwotvHK8cfZIGUWh+3O/5/RtbqUb4A9Aea3kiBij9ULZPoHHMqiXQDElyRhnFLq4M
         4prQwp79OU+nKehwg0ekrMmYz/lU/Z51SMK8pXJf0ggIRQI2aOvNZgfwIgTn4CNS3xDk
         c1qHkaQ5Gw3J0SvpmppCOwo2c7Ex7bCOxLbZdsQhWP6zvAmvqLgGEpkrHBA4WP0UIzh9
         Md2tHfZAgb+NWq9DBg5H1V6bEsGa+9R6Ok4bY0TrKYZoP7JVHHIVE3kmSDBi9L+m+FP+
         TwzYrpQ2DHQhpWfJVZnpBKCesJFe/7lm17oTAl1fuWakrp3LhQLs8ayf4Xumn56ggZ5t
         09Yw==
X-Gm-Message-State: AG10YORawCBfkKF18eyu4OwerQAkyAr7KXP+lHAzTTsWPUdjjKcXaIBytMzE3PLmxs7TIw==
X-Received: by 10.98.72.24 with SMTP id v24mr53861567pfa.15.1455064186303;
        Tue, 09 Feb 2016 16:29:46 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id s90sm429295pfa.49.2016.02.09.16.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 16:29:45 -0800 (PST)
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
Subject: [PATCH net-next v8 01/19] lib/bitmap.c: conversion routines to/from u32 array
Date:   Tue,  9 Feb 2016 16:29:10 -0800
Message-Id: <1455064168-5102-2-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51939
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
 include/linux/bitmap.h | 10 ++++++
 lib/bitmap.c           | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 9653fdb..e9b0b9a 100644
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
@@ -163,6 +165,14 @@ extern void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 extern int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order);
 extern void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order);
 extern int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order);
+extern unsigned int bitmap_from_u32array(unsigned long *bitmap,
+					 unsigned int nbits,
+					 const u32 *buf,
+					 unsigned int nwords);
+extern unsigned int bitmap_to_u32array(u32 *buf,
+				       unsigned int nwords,
+				       const unsigned long *bitmap,
+				       unsigned int nbits);
 #ifdef __BIG_ENDIAN
 extern void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int nbits);
 #else
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 8148143..c66da50 100644
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
@@ -1060,6 +1062,93 @@ int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
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
+ *
+ * Return the number of bits effectively copied.
+ */
+unsigned int
+bitmap_from_u32array(unsigned long *bitmap, unsigned int nbits,
+		     const u32 *buf, unsigned int nwords)
+{
+	unsigned int dst_idx, src_idx;
+
+	for (src_idx = dst_idx = 0; dst_idx < BITS_TO_LONGS(nbits); ++dst_idx) {
+		unsigned long part = 0;
+
+		if (src_idx < nwords)
+			part = buf[src_idx++];
+
+#if BITS_PER_LONG == 64
+		if (src_idx < nwords)
+			part |= ((unsigned long) buf[src_idx++]) << 32;
+#endif
+
+		if (dst_idx < nbits/BITS_PER_LONG)
+			bitmap[dst_idx] = part;
+		else {
+			unsigned long mask = BITMAP_LAST_WORD_MASK(nbits);
+
+			bitmap[dst_idx] = (bitmap[dst_idx] & ~mask)
+				| (part & mask);
+		}
+	}
+
+	return min_t(unsigned int, nbits, 32*nwords);
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
+ *
+ * Return the number of bits effectively copied.
+ */
+unsigned int
+bitmap_to_u32array(u32 *buf, unsigned int nwords,
+		   const unsigned long *bitmap, unsigned int nbits)
+{
+	unsigned int dst_idx = 0, src_idx = 0;
+
+	while (dst_idx < nwords) {
+		unsigned long part = 0;
+
+		if (src_idx < BITS_TO_LONGS(nbits)) {
+			part = bitmap[src_idx];
+			if (src_idx >= nbits/BITS_PER_LONG)
+				part &= BITMAP_LAST_WORD_MASK(nbits);
+			src_idx++;
+		}
+
+		buf[dst_idx++] = part & 0xffffffffUL;
+
+#if BITS_PER_LONG == 64
+		if (dst_idx < nwords) {
+			part >>= 32;
+			buf[dst_idx++] = part & 0xffffffffUL;
+		}
+#endif
+	}
+
+	return min_t(unsigned int, nbits, 32*nwords);
+}
+EXPORT_SYMBOL(bitmap_to_u32array);
+
+/**
  * bitmap_copy_le - copy a bitmap, putting the bits into little-endian order.
  * @dst:   destination buffer
  * @src:   bitmap to copy
-- 
2.7.0.rc3.207.g0ac5344
