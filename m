Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 11:12:34 +0200 (CEST)
Received: from mail-bk0-f48.google.com ([209.85.214.48]:64014 "EHLO
        mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817975Ab3DJJMcMSZMe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Apr 2013 11:12:32 +0200
Received: by mail-bk0-f48.google.com with SMTP id jf3so106062bkc.21
        for <multiple recipients>; Wed, 10 Apr 2013 02:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:content-type:content-transfer-encoding;
        bh=bLOyTgV8oJppMuSBzQX0xflaDVPILd3FrcFD2/2e2mQ=;
        b=e7nlw8e3uJ9nFKolTXN0+pCPjrl0i7ZHHsKQTzNIQZpSh9+uHUEerLqQIXODV18yt1
         iP0uK2DjrrDr+jRDns6YXT8zw+RD2aQw5QoiLcX6wJWY6adZTx21nF4i0//9xiGmkj39
         Hv9k1zN8zn8MWv53/A8+hvfkXpnYe4h8pZLB3nRT2TSstH+iDQHHn1nGiaZkURcIX1/a
         Q3aYB6nnhAEJYR2coaSeH71o71gUkGe98AMuEiBX8F04/SwD4mxtlYMTYU2gZc4lSLVG
         NFoIpyYl/+cmBj9LMevey2SNWejxCyiUWrKp0HOGeNJIjuMGcoo0OXX1xU3ptXNwLWT0
         uMpQ==
X-Received: by 10.204.240.145 with SMTP id la17mr402226bkb.68.1365585146439;
        Wed, 10 Apr 2013 02:12:26 -0700 (PDT)
Received: from [0.0.0.0] ([62.159.77.166])
        by mx.google.com with ESMTPS id b21sm15338079bkw.12.2013.04.10.02.12.24
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 02:12:25 -0700 (PDT)
Message-ID: <51652CF5.1080009@gmail.com>
Date:   Wed, 10 Apr 2013 11:12:21 +0200
From:   Wladislav Wiebe <wladislav.kw@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
MIME-Version: 1.0
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
CC:     linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Makefile: workaround printk recursion bug
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <wladislav.kw@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wladislav.kw@gmail.com
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


From: Wladislav Wiebe <wladislav.kw@gmail.com>

Function tracing is broken due to removal of selecting FRAME_POINTER with
FUNCTION_TRACER as result of commit: b732d439cb43336cd6d7e804ecb2c81193ef63b0

Latest commit ad8c396936e328f5344e1881afde9e28d5f2045f "MIPS: Unbreak
function tracer for 64-bit kernel." fixes just the early startup hang,
but on MIPS64/CAVIUM_OCTEON2 are still random printk recursion bugs
which cause also Kernel hangs, especially on late startup phase when
network drivers get loaded. This patch enable for CAVIUM_OCTEON2/64 Bit
architecture -fno-omit-frame-pointer cflag when FUNCTION_TRACER get
enabled. This will fix random Kernel hangs with "BUG: recent printk
recursion!" from linux/kernel/printk.c.

Maybe there exist a other solution in mcount handling, since in the
commit message from Al Cooper is mentioned that "MIPS frame pointers are
generally considered to be useless because they cannot be used to unwind
the stack. Unfortunately the MIPS function tracing code has bugs that
are masked by the use of frame pointers. This commit fixes the bugs so
that MIPS frame pointers don't need to be enabled."

But this is just a solution for MIPS32 - on a symmetric multiprocessing
@MIPS64/CAVIUM_OCTEON2 it doesn't work properly.

Signed-off-by: Wladislav Wiebe <wladislav.kw@gmail.com>
---
 arch/mips/Makefile |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 6f7978f..8befe31 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -119,6 +119,15 @@ cflags-$(CONFIG_SB1XXX_CORELIS)	+= $(call cc-option,-mno-sched-prolog) \
 				   -fno-omit-frame-pointer

 #
+# FTrace depended compiler options, currently only needed by MIPS64/OCTEON2.
+#
+ifdef CONFIG_64BIT
+ifdef CONFIG_CAVIUM_OCTEON2
+cflags-$(CONFIG_FUNCTION_TRACER) += $(call cc-option,-fno-omit-frame-pointer)
+endif
+endif
+
+#
 # CPU-dependent compiler/assembler options for optimization.
 #
 cflags-$(CONFIG_CPU_R3000)	+= -march=r3000
-- 
1.7.9.5
