Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2018 16:49:15 +0200 (CEST)
Received: from conuserg-10.nifty.com ([210.131.2.77]:30880 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994585AbeDPOszVAswU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2018 16:48:55 +0200
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w3GElqtt017749;
        Mon, 16 Apr 2018 23:47:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w3GElqtt017749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1523890078;
        bh=+LIyBHl6CDpAxuRA2zGVM6UGQysWvPHTC6AVTENRJJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v0+wRhKS+OhyYM9HgB0UfOyMVEYxQPupgZ1QcODlN/OMXgPE+NcpJVHCPmFwugLAp
         tArJIyRzTLp8u7jRgPEZS7hAbBXzxcO+0M78V0QCgr+i00dRm29ln35ccAEI/54mqf
         U3GGI9ax8QUZHnA0L6urb/l4g7tXHVRUKgFeiV8OMbLjVnb1x4U4EaOcOE5bW68n2R
         8kuDg83g1P9uQTMZIyJTl6lqjnXnVv33MS7VmADIn2VNzPH4X3OvKk3yGbZvj4a4iI
         1H+H5M9CvHESUmSXI2Zarimw1roLPWjrnj0tldBI0oKOskwLSak6T+0S0WjmbzMAYf
         mfLR0QMzVMXcw==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] MIPS: boot: add missing targets for vmlinux.*.its
Date:   Mon, 16 Apr 2018 23:47:45 +0900
Message-Id: <1523890067-13641-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

The build rule of vmlinux.*.its is invoked by $(call if_changed,...)
but it always rebuilds the target needlessly due to missing targets.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/boot/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 30512ab..91d9fe8 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -126,6 +126,12 @@ quiet_cmd_its_cat = CAT     $@
 $(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS)) FORCE
 	$(call if_changed,its_cat)
 
+targets += vmlinux.its
+targets += vmlinux.gz.its
+targets += vmlinux.bz2.its
+targets += vmlinux.lzmo.its
+targets += vmlinux.lzo.its
+
 quiet_cmd_cpp_its_S = ITS     $@
       cmd_cpp_its_S = $(CPP) -P -C -o $@ $< \
 		        -DKERNEL_NAME="\"Linux $(KERNELRELEASE)\"" \
-- 
2.7.4
