Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:30:43 +0100 (CET)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36746 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012451AbcBJA34vgkkx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:29:56 +0100
Received: by mail-pa0-f66.google.com with SMTP id sv5so156444pab.3
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GNC8Unfiq2NvYYS7dMu/fQAtZR6pkX8nuuCnvS+rmww=;
        b=S6cf+b8lx5uu5R697pvsgGbnaI/CmS6XkPbtWosgzjoZXxHCONnKOnsr8oL4R7/KC/
         T9BxZfq9/55jb9v9Vit700UvIlPT6mRM9TaCVxywSBEpY77gq6g7PbVTArsfBtqwxMmW
         rFNDyz0rXJpyDtvHUvDvrMsCFgriAqzIUNlNg2Hdp+ymYaEesTuyaA6P7Q8yN4fkHNIN
         kHVqJ9ca4pX0qr3XGu0GJZMH0PKjK3bQVV7glRq+G9OfCt7PZ4pEGXJTyV26zIDZllOK
         ZHHSgD0OyXWUIxf7Pi6TWXlxse6byXvYf5M/nJYsqgTSyloB4rB3DmFjWRBbTWbngonK
         FgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GNC8Unfiq2NvYYS7dMu/fQAtZR6pkX8nuuCnvS+rmww=;
        b=H0fAV/IjJR9viL1Ggu3s3G4y59Vl76NyW0DiDR1wDIDg2pnndEHL3bNM5Wp9kRMLHi
         12pUm3bVGfoBjax2mGS4LvkuYfT6QBFJ4WI+bjQQuoDPUonZfISUkfvq5RnAgKpUiWF6
         km4iV7+0s0rsUPB/3B60YGKYp5ksEIfoLsNryX1d/3cWah9Jd8f/nlbCRVoYO0d4aEcK
         f+sKsKN3rtwV6y6+z8Y7V4IuTFPCeSdtT5B+/vOqIvOxF0+xQkVG74w+TnKSjlUpjiu5
         V0BM1hni8y6cykBUTybkRxa4yTK6yQgPth1yEmhIokep8MkgofpCQB3/6DDQJMmqRIuw
         +0ow==
X-Gm-Message-State: AG10YOQThV6eFG7Qe2cB6JTAcTc3iFUbZiDR/H5U5kKjOtkAvUvp5vFioPreE00aZWeMTA==
X-Received: by 10.66.63.8 with SMTP id c8mr38250409pas.147.1455064187886;
        Tue, 09 Feb 2016 16:29:47 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id s90sm429295pfa.49.2016.02.09.16.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 16:29:47 -0800 (PST)
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
Subject: [PATCH net-next v8 02/19] test_bitmap: unit tests for lib/bitmap.c
Date:   Tue,  9 Feb 2016 16:29:11 -0800
Message-Id: <1455064168-5102-3-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51941
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

This is mainly testing bitmap construction and conversion to/from u32[]
for now.

Tested:
  qemu i386, x86_64, ppc, ppc64 BE and LE, ARM.

Signed-off-by: David Decotigny <decot@googlers.com>
---
 lib/Kconfig.debug                     |   8 +
 lib/Makefile                          |   1 +
 lib/test_bitmap.c                     | 358 ++++++++++++++++++++++++++++++++++
 tools/testing/selftests/lib/Makefile  |   2 +-
 tools/testing/selftests/lib/bitmap.sh |  10 +
 5 files changed, 378 insertions(+), 1 deletion(-)
 create mode 100644 lib/test_bitmap.c
 create mode 100644 tools/testing/selftests/lib/bitmap.sh

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ecb9e75..f890ee5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1738,6 +1738,14 @@ config TEST_KSTRTOX
 config TEST_PRINTF
 	tristate "Test printf() family of functions at runtime"
 
+config TEST_BITMAP
+	tristate "Test bitmap_*() family of functions at runtime"
+	default n
+	help
+	  Enable this option to test the bitmap functions at boot.
+
+	  If unsure, say N.
+
 config TEST_RHASHTABLE
 	tristate "Perform selftest on resizable hash table"
 	default n
diff --git a/lib/Makefile b/lib/Makefile
index a7c26a4..dda4039 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
+obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
new file mode 100644
index 0000000..e2cbd43
--- /dev/null
+++ b/lib/test_bitmap.c
@@ -0,0 +1,358 @@
+/*
+ * Test cases for printf facility.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/bitmap.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+static unsigned total_tests __initdata;
+static unsigned failed_tests __initdata;
+
+static char pbl_buffer[PAGE_SIZE] __initdata;
+
+
+static bool __init
+__check_eq_uint(const char *srcfile, unsigned int line,
+		const unsigned int exp_uint, unsigned int x)
+{
+	if (exp_uint != x) {
+		pr_warn("[%s:%u] expected %u, got %u\n",
+			srcfile, line, exp_uint, x);
+		return false;
+	}
+	return true;
+}
+
+
+static bool __init
+__check_eq_bitmap(const char *srcfile, unsigned int line,
+		  const unsigned long *exp_bmap, unsigned int exp_nbits,
+		  const unsigned long *bmap, unsigned int nbits)
+{
+	if (exp_nbits != nbits) {
+		pr_warn("[%s:%u] bitmap length mismatch: expected %u, got %u\n",
+			srcfile, line, exp_nbits, nbits);
+		return false;
+	}
+
+	if (!bitmap_equal(exp_bmap, bmap, nbits)) {
+		pr_warn("[%s:%u] bitmaps contents differ: expected \"%*pbl\", got \"%*pbl\"\n",
+			srcfile, line,
+			exp_nbits, exp_bmap, nbits, bmap);
+		return false;
+	}
+	return true;
+}
+
+static bool __init
+__check_eq_pbl(const char *srcfile, unsigned int line,
+	       const char *expected_pbl,
+	       const unsigned long *bitmap, unsigned int nbits)
+{
+	snprintf(pbl_buffer, sizeof(pbl_buffer), "%*pbl", nbits, bitmap);
+	if (strcmp(expected_pbl, pbl_buffer)) {
+		pr_warn("[%s:%u] expected \"%s\", got \"%s\"\n",
+			srcfile, line,
+			expected_pbl, pbl_buffer);
+		return false;
+	}
+	return true;
+}
+
+static bool __init
+__check_eq_u32_array(const char *srcfile, unsigned int line,
+		     const u32 *exp_arr, unsigned int exp_len,
+		     const u32 *arr, unsigned int len)
+{
+	if (exp_len != len) {
+		pr_warn("[%s:%u] array length differ: expected %u, got %u\n",
+			srcfile, line,
+			exp_len, len);
+		return false;
+	}
+
+	if (memcmp(exp_arr, arr, len*sizeof(*arr))) {
+		pr_warn("[%s:%u] array contents differ\n", srcfile, line);
+		print_hex_dump(KERN_WARNING, "  exp:  ", DUMP_PREFIX_OFFSET,
+			       32, 4, exp_arr, exp_len*sizeof(*exp_arr), false);
+		print_hex_dump(KERN_WARNING, "  got:  ", DUMP_PREFIX_OFFSET,
+			       32, 4, arr, len*sizeof(*arr), false);
+		return false;
+	}
+
+	return true;
+}
+
+#define __expect_eq(suffix, ...)					\
+	({								\
+		int result = 0;						\
+		total_tests++;						\
+		if (!__check_eq_ ## suffix(__FILE__, __LINE__,		\
+					   ##__VA_ARGS__)) {		\
+			failed_tests++;					\
+			result = 1;					\
+		}							\
+		result;							\
+	})
+
+#define expect_eq_uint(...)		__expect_eq(uint, ##__VA_ARGS__)
+#define expect_eq_bitmap(...)		__expect_eq(bitmap, ##__VA_ARGS__)
+#define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
+#define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
+
+static void __init test_zero_fill_copy(void)
+{
+	DECLARE_BITMAP(bmap1, 1024);
+	DECLARE_BITMAP(bmap2, 1024);
+
+	bitmap_zero(bmap1, 1024);
+	bitmap_zero(bmap2, 1024);
+
+	/* single-word bitmaps */
+	expect_eq_pbl("", bmap1, 23);
+
+	bitmap_fill(bmap1, 19);
+	expect_eq_pbl("0-18", bmap1, 1024);
+
+	bitmap_copy(bmap2, bmap1, 23);
+	expect_eq_pbl("0-18", bmap2, 1024);
+
+	bitmap_fill(bmap2, 23);
+	expect_eq_pbl("0-22", bmap2, 1024);
+
+	bitmap_copy(bmap2, bmap1, 23);
+	expect_eq_pbl("0-18", bmap2, 1024);
+
+	bitmap_zero(bmap1, 23);
+	expect_eq_pbl("", bmap1, 1024);
+
+	/* multi-word bitmaps */
+	bitmap_zero(bmap1, 1024);
+	expect_eq_pbl("", bmap1, 1024);
+
+	bitmap_fill(bmap1, 109);
+	expect_eq_pbl("0-108", bmap1, 1024);
+
+	bitmap_copy(bmap2, bmap1, 1024);
+	expect_eq_pbl("0-108", bmap2, 1024);
+
+	bitmap_fill(bmap2, 1024);
+	expect_eq_pbl("0-1023", bmap2, 1024);
+
+	bitmap_copy(bmap2, bmap1, 1024);
+	expect_eq_pbl("0-108", bmap2, 1024);
+
+	/* the following tests assume a 32- or 64-bit arch (even 128b
+	 * if we care)
+	 */
+
+	bitmap_fill(bmap2, 1024);
+	bitmap_copy(bmap2, bmap1, 109);  /* ... but 0-padded til word length */
+	expect_eq_pbl("0-108,128-1023", bmap2, 1024);
+
+	bitmap_fill(bmap2, 1024);
+	bitmap_copy(bmap2, bmap1, 97);  /* ... but aligned on word length */
+	expect_eq_pbl("0-108,128-1023", bmap2, 1024);
+
+	bitmap_zero(bmap2, 97);  /* ... but 0-padded til word length */
+	expect_eq_pbl("128-1023", bmap2, 1024);
+}
+
+static void __init test_bitmap_u32_array_conversions(void)
+{
+	DECLARE_BITMAP(bmap1, 1024);
+	DECLARE_BITMAP(bmap2, 1024);
+	u32 exp_arr[32], arr[32];
+	unsigned nbits;
+
+	for (nbits = 0 ; nbits < 257 ; ++nbits) {
+		const unsigned int used_u32s = DIV_ROUND_UP(nbits, 32);
+		unsigned int i, rv;
+
+		bitmap_zero(bmap1, nbits);
+		bitmap_set(bmap1, nbits, 1024 - nbits);  /* garbage */
+
+		memset(arr, 0xff, sizeof(arr));
+		rv = bitmap_to_u32array(arr, used_u32s, bmap1, nbits);
+		expect_eq_uint(nbits, rv);
+
+		memset(exp_arr, 0xff, sizeof(exp_arr));
+		memset(exp_arr, 0, used_u32s*sizeof(*exp_arr));
+		expect_eq_u32_array(exp_arr, 32, arr, 32);
+
+		bitmap_fill(bmap2, 1024);
+		rv = bitmap_from_u32array(bmap2, nbits, arr, used_u32s);
+		expect_eq_uint(nbits, rv);
+		expect_eq_bitmap(bmap1, 1024, bmap2, 1024);
+
+		for (i = 0 ; i < nbits ; ++i) {
+			/*
+			 * test conversion bitmap -> u32[]
+			 */
+
+			bitmap_zero(bmap1, 1024);
+			__set_bit(i, bmap1);
+			bitmap_set(bmap1, nbits, 1024 - nbits);  /* garbage */
+
+			memset(arr, 0xff, sizeof(arr));
+			rv = bitmap_to_u32array(arr, used_u32s, bmap1, nbits);
+			expect_eq_uint(nbits, rv);
+
+			/* 1st used u32 words contain expected bit set, the
+			 * remaining words are left unchanged (0xff)
+			 */
+			memset(exp_arr, 0xff, sizeof(exp_arr));
+			memset(exp_arr, 0, used_u32s*sizeof(*exp_arr));
+			exp_arr[i/32] = (1U<<(i%32));
+			expect_eq_u32_array(exp_arr, 32, arr, 32);
+
+
+			/* same, with longer array to fill
+			 */
+			memset(arr, 0xff, sizeof(arr));
+			rv = bitmap_to_u32array(arr, 32, bmap1, nbits);
+			expect_eq_uint(nbits, rv);
+
+			/* 1st used u32 words contain expected bit set, the
+			 * remaining words are all 0s
+			 */
+			memset(exp_arr, 0, sizeof(exp_arr));
+			exp_arr[i/32] = (1U<<(i%32));
+			expect_eq_u32_array(exp_arr, 32, arr, 32);
+
+			/*
+			 * test conversion u32[] -> bitmap
+			 */
+
+			/* the 1st nbits of bmap2 are identical to
+			 * bmap1, the remaining bits of bmap2 are left
+			 * unchanged (all 1s)
+			 */
+			bitmap_fill(bmap2, 1024);
+			rv = bitmap_from_u32array(bmap2, nbits,
+						  exp_arr, used_u32s);
+			expect_eq_uint(nbits, rv);
+
+			expect_eq_bitmap(bmap1, 1024, bmap2, 1024);
+
+			/* same, with more bits to fill
+			 */
+			memset(arr, 0xff, sizeof(arr));  /* garbage */
+			memset(arr, 0, used_u32s*sizeof(u32));
+			arr[i/32] = (1U<<(i%32));
+
+			bitmap_fill(bmap2, 1024);
+			rv = bitmap_from_u32array(bmap2, 1024, arr, used_u32s);
+			expect_eq_uint(used_u32s*32, rv);
+
+			/* the 1st nbits of bmap2 are identical to
+			 * bmap1, the remaining bits of bmap2 are cleared
+			 */
+			bitmap_zero(bmap1, 1024);
+			__set_bit(i, bmap1);
+			expect_eq_bitmap(bmap1, 1024, bmap2, 1024);
+
+
+			/*
+			 * test short conversion bitmap -> u32[] (1
+			 * word too short)
+			 */
+			if (used_u32s > 1) {
+				bitmap_zero(bmap1, 1024);
+				__set_bit(i, bmap1);
+				bitmap_set(bmap1, nbits,
+					   1024 - nbits);  /* garbage */
+				memset(arr, 0xff, sizeof(arr));
+
+				rv = bitmap_to_u32array(arr, used_u32s - 1,
+							bmap1, nbits);
+				expect_eq_uint((used_u32s - 1)*32, rv);
+
+				/* 1st used u32 words contain expected
+				 * bit set, the remaining words are
+				 * left unchanged (0xff)
+				 */
+				memset(exp_arr, 0xff, sizeof(exp_arr));
+				memset(exp_arr, 0,
+				       (used_u32s-1)*sizeof(*exp_arr));
+				if ((i/32) < (used_u32s - 1))
+					exp_arr[i/32] = (1U<<(i%32));
+				expect_eq_u32_array(exp_arr, 32, arr, 32);
+			}
+
+			/*
+			 * test short conversion u32[] -> bitmap (3
+			 * bits too short)
+			 */
+			if (nbits > 3) {
+				memset(arr, 0xff, sizeof(arr));  /* garbage */
+				memset(arr, 0, used_u32s*sizeof(*arr));
+				arr[i/32] = (1U<<(i%32));
+
+				bitmap_zero(bmap1, 1024);
+				rv = bitmap_from_u32array(bmap1, nbits - 3,
+							  arr, used_u32s);
+				expect_eq_uint(nbits - 3, rv);
+
+				/* we are expecting the bit < nbits -
+				 * 3 (none otherwise), and the rest of
+				 * bmap1 unchanged (0-filled)
+				 */
+				bitmap_zero(bmap2, 1024);
+				if (i < nbits - 3)
+					__set_bit(i, bmap2);
+				expect_eq_bitmap(bmap2, 1024, bmap1, 1024);
+
+				/* do the same with bmap1 initially
+				 * 1-filled
+				 */
+
+				bitmap_fill(bmap1, 1024);
+				rv = bitmap_from_u32array(bmap1, nbits - 3,
+							 arr, used_u32s);
+				expect_eq_uint(nbits - 3, rv);
+
+				/* we are expecting the bit < nbits -
+				 * 3 (none otherwise), and the rest of
+				 * bmap1 unchanged (1-filled)
+				 */
+				bitmap_zero(bmap2, 1024);
+				if (i < nbits - 3)
+					__set_bit(i, bmap2);
+				bitmap_set(bmap2, nbits-3, 1024 - nbits + 3);
+				expect_eq_bitmap(bmap2, 1024, bmap1, 1024);
+			}
+		}
+	}
+}
+
+static int __init test_bitmap_init(void)
+{
+	test_zero_fill_copy();
+	test_bitmap_u32_array_conversions();
+
+	if (failed_tests == 0)
+		pr_info("all %u tests passed\n", total_tests);
+	else
+		pr_warn("failed %u out of %u tests\n",
+			failed_tests, total_tests);
+
+	return failed_tests ? -EINVAL : 0;
+}
+
+static void __exit test_bitmap_cleanup(void)
+{
+}
+
+module_init(test_bitmap_init);
+module_exit(test_bitmap_cleanup);
+
+MODULE_AUTHOR("david decotigny <david.decotigny@googlers.com>");
+MODULE_LICENSE("GPL");
diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
index 47147b9..0836006 100644
--- a/tools/testing/selftests/lib/Makefile
+++ b/tools/testing/selftests/lib/Makefile
@@ -3,6 +3,6 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-TEST_PROGS := printf.sh
+TEST_PROGS := printf.sh bitmap.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/lib/bitmap.sh b/tools/testing/selftests/lib/bitmap.sh
new file mode 100644
index 0000000..2da187b
--- /dev/null
+++ b/tools/testing/selftests/lib/bitmap.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+# Runs bitmap infrastructure tests using test_bitmap kernel module
+
+if /sbin/modprobe -q test_bitmap; then
+	/sbin/modprobe -q -r test_bitmap
+	echo "bitmap: ok"
+else
+	echo "bitmap: [FAIL]"
+	exit 1
+fi
-- 
2.7.0.rc3.207.g0ac5344
