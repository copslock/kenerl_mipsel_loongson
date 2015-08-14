Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 06:23:37 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:48449 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006209AbbHNEXe0Nv7V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Aug 2015 06:23:34 +0200
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t7E4MmHY003438
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 14 Aug 2015 04:22:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t7E4Mmv5013534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 14 Aug 2015 04:22:48 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t7E4Mi3X013055;
        Fri, 14 Aug 2015 04:22:44 GMT
Received: from linux-siqj.site (/10.154.123.183)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Aug 2015 21:22:44 -0700
From:   Yinghai Lu <yinghai@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Jon Medhurst <tixy@linaro.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@arm.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Ralf Baechle <ralf@linux-mips.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-mips@linux-mips.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        Fengguang Wu <fengguang.wu@intel.com>,
        stable <stable@vger.kernel.org>
Subject: [PATCH v2] lib/decompressors: Use real out buf size for gunzip with kernel
Date:   Thu, 13 Aug 2015 21:22:24 -0700
Message-Id: <1439526144-3243-1-git-send-email-yinghai@kernel.org>
X-Mailer: git-send-email 1.8.4.5
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Return-Path: <yinghai@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yinghai@kernel.org
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

When loading x86 64bit kernel above 4GiB with patched grub2, got kernel
gunzip error.

| early console in decompress_kernel
| decompress_kernel:
|       input: [0x807f2143b4-0x807ff61aee]
|      output: [0x807cc00000-0x807f3ea29b] 0x027ea29c: output_len
| boot via startup_64
| KASLR using RDTSC...
|  new output: [0x46fe000000-0x470138cfff] 0x0338d000: output_run_size
|  decompress: [0x46fe000000-0x47007ea29b] <=== [0x807f2143b4-0x807ff61aee]
|
| Decompressing Linux... gz...
|
| uncompression error
|
| -- System halted

the new buffer is at 0x46fe000000ULL, decompressor_gzip is using
0xffffffb901ffffff as out_len. gunzip in lib/zlib_inflate/inflate.c
cap that len to 0x01ffffff and decompress fails later.

We could hit this problem with crashkernel booting that uses kexec
loading kernel above 4GiB.

We have decompress_* support:
    1. inbuf[]/outbuf[] for kernel preboot.
    2. inbuf[]/flush() for initramfs
    3. fill()/flush() for initrd.
This bug only affect kernel preboot path that use outbuf[].

Add __decompress and take real out_buf_len for gunzip instead of guessing
wrong buf size.

-v2: fix unused warning on sh/arm/m32r from Fengguang.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Fixes: 1431574a1c4 (lib/decompressors: fix "no limit" output buffer length)
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Jon Medhurst <tixy@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-arm-kernel@lists.infradead.org
Cc: uclinux-h8-devel@lists.sourceforge.jp
Cc: linux-mips@linux-mips.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: stable <stable@vger.kernel.org>

---
 arch/arm/boot/compressed/decompress.c  |    2 +-
 arch/h8300/boot/compressed/misc.c      |    2 +-
 arch/m32r/boot/compressed/misc.c       |    3 ++-
 arch/mips/boot/compressed/decompress.c |    4 ++--
 arch/s390/boot/compressed/misc.c       |    2 +-
 arch/sh/boot/compressed/misc.c         |    2 +-
 arch/unicore32/boot/compressed/misc.c  |    4 ++--
 arch/x86/boot/compressed/misc.c        |    3 ++-
 lib/decompress_bunzip2.c               |    6 +++---
 lib/decompress_inflate.c               |   31 ++++++++++++++++++++++++++-----
 lib/decompress_unlz4.c                 |    6 +++---
 lib/decompress_unlzma.c                |    7 +++----
 lib/decompress_unlzo.c                 |   13 ++++++++++++-
 lib/decompress_unxz.c                  |   12 +++++++++++-
 14 files changed, 70 insertions(+), 27 deletions(-)

Index: linux-2.6/arch/arm/boot/compressed/decompress.c
===================================================================
--- linux-2.6.orig/arch/arm/boot/compressed/decompress.c
+++ linux-2.6/arch/arm/boot/compressed/decompress.c
@@ -57,5 +57,5 @@ extern char * strstr(const char * s1, co
 
 int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x))
 {
-	return decompress(input, len, NULL, NULL, output, NULL, error);
+	return __decompress(input, len, NULL, NULL, output, 0, NULL, error);
 }
Index: linux-2.6/arch/h8300/boot/compressed/misc.c
===================================================================
--- linux-2.6.orig/arch/h8300/boot/compressed/misc.c
+++ linux-2.6/arch/h8300/boot/compressed/misc.c
@@ -70,5 +70,5 @@ void decompress_kernel(void)
 	free_mem_ptr = (unsigned long)&_end;
 	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
 
-	decompress(input_data, input_len, NULL, NULL, output, NULL, error);
+	__decompress(input_data, input_len, NULL, NULL, output, 0, NULL, error);
 }
Index: linux-2.6/arch/m32r/boot/compressed/misc.c
===================================================================
--- linux-2.6.orig/arch/m32r/boot/compressed/misc.c
+++ linux-2.6/arch/m32r/boot/compressed/misc.c
@@ -86,6 +86,7 @@ decompress_kernel(int mmu_on, unsigned c
 	free_mem_end_ptr = free_mem_ptr + BOOT_HEAP_SIZE;
 
 	puts("\nDecompressing Linux... ");
-	decompress(input_data, input_len, NULL, NULL, output_data, NULL, error);
+	__decompress(input_data, input_len, NULL, NULL, output_data, 0,
+			NULL, error);
 	puts("done.\nBooting the kernel.\n");
 }
Index: linux-2.6/arch/mips/boot/compressed/decompress.c
===================================================================
--- linux-2.6.orig/arch/mips/boot/compressed/decompress.c
+++ linux-2.6/arch/mips/boot/compressed/decompress.c
@@ -111,8 +111,8 @@ void decompress_kernel(unsigned long boo
 	puts("\n");
 
 	/* Decompress the kernel with according algorithm */
-	decompress((char *)zimage_start, zimage_size, 0, 0,
-		   (void *)VMLINUX_LOAD_ADDRESS_ULL, 0, error);
+	__decompress((char *)zimage_start, zimage_size, 0, 0,
+		   (void *)VMLINUX_LOAD_ADDRESS_ULL, 0, 0, error);
 
 	/* FIXME: should we flush cache here? */
 	puts("Now, booting the kernel...\n");
Index: linux-2.6/arch/s390/boot/compressed/misc.c
===================================================================
--- linux-2.6.orig/arch/s390/boot/compressed/misc.c
+++ linux-2.6/arch/s390/boot/compressed/misc.c
@@ -167,7 +167,7 @@ unsigned long decompress_kernel(void)
 #endif
 
 	puts("Uncompressing Linux... ");
-	decompress(input_data, input_len, NULL, NULL, output, NULL, error);
+	__decompress(input_data, input_len, NULL, NULL, output, 0, NULL, error);
 	puts("Ok, booting the kernel.\n");
 	return (unsigned long) output;
 }
Index: linux-2.6/arch/sh/boot/compressed/misc.c
===================================================================
--- linux-2.6.orig/arch/sh/boot/compressed/misc.c
+++ linux-2.6/arch/sh/boot/compressed/misc.c
@@ -132,7 +132,7 @@ void decompress_kernel(void)
 
 	puts("Uncompressing Linux... ");
 	cache_control(CACHE_ENABLE);
-	decompress(input_data, input_len, NULL, NULL, output, NULL, error);
+	__decompress(input_data, input_len, NULL, NULL, output, 0, NULL, error);
 	cache_control(CACHE_DISABLE);
 	puts("Ok, booting the kernel.\n");
 }
Index: linux-2.6/arch/unicore32/boot/compressed/misc.c
===================================================================
--- linux-2.6.orig/arch/unicore32/boot/compressed/misc.c
+++ linux-2.6/arch/unicore32/boot/compressed/misc.c
@@ -119,8 +119,8 @@ unsigned long decompress_kernel(unsigned
 	output_ptr = get_unaligned_le32(tmp);
 
 	arch_decomp_puts("Uncompressing Linux...");
-	decompress(input_data, input_data_end - input_data, NULL, NULL,
-			output_data, NULL, error);
+	__decompress(input_data, input_data_end - input_data, NULL, NULL,
+			output_data, 0, NULL, error);
 	arch_decomp_puts(" done, booting the kernel.\n");
 	return output_ptr;
 }
Index: linux-2.6/arch/x86/boot/compressed/misc.c
===================================================================
--- linux-2.6.orig/arch/x86/boot/compressed/misc.c
+++ linux-2.6/arch/x86/boot/compressed/misc.c
@@ -448,7 +448,8 @@ asmlinkage __visible void *decompress_ke
 #endif
 
 	debug_putstr("\nDecompressing Linux... ");
-	decompress(input_data, input_len, NULL, NULL, output, NULL, error);
+	__decompress(input_data, input_len, NULL, NULL, output, output_len,
+			NULL, error);
 	parse_elf(output);
 	/*
 	 * 32-bit always performs relocations. 64-bit relocations are only
Index: linux-2.6/lib/decompress_bunzip2.c
===================================================================
--- linux-2.6.orig/lib/decompress_bunzip2.c
+++ linux-2.6/lib/decompress_bunzip2.c
@@ -743,12 +743,12 @@ exit_0:
 }
 
 #ifdef PREBOOT
-STATIC int INIT decompress(unsigned char *buf, long len,
+STATIC int INIT __decompress(unsigned char *buf, long len,
 			long (*fill)(void*, unsigned long),
 			long (*flush)(void*, unsigned long),
-			unsigned char *outbuf,
+			unsigned char *outbuf, long olen,
 			long *pos,
-			void(*error)(char *x))
+			void (*error)(char *x))
 {
 	return bunzip2(buf, len - 4, fill, flush, outbuf, pos, error);
 }
Index: linux-2.6/lib/decompress_inflate.c
===================================================================
--- linux-2.6.orig/lib/decompress_inflate.c
+++ linux-2.6/lib/decompress_inflate.c
@@ -1,4 +1,5 @@
 #ifdef STATIC
+#define PREBOOT
 /* Pre-boot environment: included */
 
 /* prevent inclusion of _LINUX_KERNEL_H in pre-boot environment: lots
@@ -33,23 +34,23 @@ static long INIT nofill(void *buffer, un
 }
 
 /* Included from initramfs et al code */
-STATIC int INIT gunzip(unsigned char *buf, long len,
+STATIC int INIT __gunzip(unsigned char *buf, long len,
 		       long (*fill)(void*, unsigned long),
 		       long (*flush)(void*, unsigned long),
-		       unsigned char *out_buf,
+		       unsigned char *out_buf, long out_len,
 		       long *pos,
 		       void(*error)(char *x)) {
 	u8 *zbuf;
 	struct z_stream_s *strm;
 	int rc;
-	size_t out_len;
 
 	rc = -1;
 	if (flush) {
 		out_len = 0x8000; /* 32 K */
 		out_buf = malloc(out_len);
 	} else {
-		out_len = ((size_t)~0) - (size_t)out_buf; /* no limit */
+		if (!out_len)
+			out_len = ((size_t)~0) - (size_t)out_buf; /* no limit */
 	}
 	if (!out_buf) {
 		error("Out of memory while allocating output buffer");
@@ -181,4 +182,24 @@ gunzip_nomem1:
 	return rc; /* returns Z_OK (0) if successful */
 }
 
-#define decompress gunzip
+#ifndef PREBOOT
+STATIC int INIT gunzip(unsigned char *buf, long len,
+		       long (*fill)(void*, unsigned long),
+		       long (*flush)(void*, unsigned long),
+		       unsigned char *out_buf,
+		       long *pos,
+		       void (*error)(char *x))
+{
+	return __gunzip(buf, len, fill, flush, out_buf, 0, pos, error);
+}
+#else
+STATIC int INIT __decompress(unsigned char *buf, long len,
+			   long (*fill)(void*, unsigned long),
+			   long (*flush)(void*, unsigned long),
+			   unsigned char *out_buf, long out_len,
+			   long *pos,
+			   void (*error)(char *x))
+{
+	return __gunzip(buf, len, fill, flush, out_buf, out_len, pos, error);
+}
+#endif
Index: linux-2.6/lib/decompress_unlz4.c
===================================================================
--- linux-2.6.orig/lib/decompress_unlz4.c
+++ linux-2.6/lib/decompress_unlz4.c
@@ -196,12 +196,12 @@ exit_0:
 }
 
 #ifdef PREBOOT
-STATIC int INIT decompress(unsigned char *buf, long in_len,
+STATIC int INIT __decompress(unsigned char *buf, long in_len,
 			      long (*fill)(void*, unsigned long),
 			      long (*flush)(void*, unsigned long),
-			      unsigned char *output,
+			      unsigned char *output, long out_len,
 			      long *posp,
-			      void(*error)(char *x)
+			      void (*error)(char *x)
 	)
 {
 	return unlz4(buf, in_len - 4, fill, flush, output, posp, error);
Index: linux-2.6/lib/decompress_unlzma.c
===================================================================
--- linux-2.6.orig/lib/decompress_unlzma.c
+++ linux-2.6/lib/decompress_unlzma.c
@@ -667,13 +667,12 @@ exit_0:
 }
 
 #ifdef PREBOOT
-STATIC int INIT decompress(unsigned char *buf, long in_len,
+STATIC int INIT __decompress(unsigned char *buf, long in_len,
 			      long (*fill)(void*, unsigned long),
 			      long (*flush)(void*, unsigned long),
-			      unsigned char *output,
+			      unsigned char *output, long out_len,
 			      long *posp,
-			      void(*error)(char *x)
-	)
+			      void (*error)(char *x))
 {
 	return unlzma(buf, in_len - 4, fill, flush, output, posp, error);
 }
Index: linux-2.6/lib/decompress_unlzo.c
===================================================================
--- linux-2.6.orig/lib/decompress_unlzo.c
+++ linux-2.6/lib/decompress_unlzo.c
@@ -31,6 +31,7 @@
  */
 
 #ifdef STATIC
+#define PREBOOT
 #include "lzo/lzo1x_decompress_safe.c"
 #else
 #include <linux/decompress/unlzo.h>
@@ -287,4 +288,14 @@ exit:
 	return ret;
 }
 
-#define decompress unlzo
+#ifdef PREBOOT
+STATIC int INIT __decompress(unsigned char *buf, long len,
+			   long (*fill)(void*, unsigned long),
+			   long (*flush)(void*, unsigned long),
+			   unsigned char *out_buf, long olen,
+			   long *pos,
+			   void (*error)(char *x))
+{
+	return unlzo(buf, len, fill, flush, out_buf, pos, error);
+}
+#endif
Index: linux-2.6/lib/decompress_unxz.c
===================================================================
--- linux-2.6.orig/lib/decompress_unxz.c
+++ linux-2.6/lib/decompress_unxz.c
@@ -394,4 +394,14 @@ error_alloc_state:
  * This macro is used by architecture-specific files to decompress
  * the kernel image.
  */
-#define decompress unxz
+#ifdef XZ_PREBOOT
+STATIC int INIT __decompress(unsigned char *buf, long len,
+			   long (*fill)(void*, unsigned long),
+			   long (*flush)(void*, unsigned long),
+			   unsigned char *out_buf, long olen,
+			   long *pos,
+			   void (*error)(char *x))
+{
+	return unxz(buf, len, fill, flush, out_buf, pos, error);
+}
+#endif
