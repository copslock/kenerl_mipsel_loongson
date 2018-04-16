Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2018 16:50:51 +0200 (CEST)
Received: from conuserg-10.nifty.com ([210.131.2.77]:33019 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994647AbeDPOugjTz-U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2018 16:50:36 +0200
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w3GElqts017749;
        Mon, 16 Apr 2018 23:47:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w3GElqts017749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1523890077;
        bh=pI9UFcmEN1R83QisQeFG7TZ4AKIPXzdBpHWLiqIFT/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zpwxI8tDLFYG5ihckdZl2aPTqTXlegvMuFh0DNcyRMKMDIPOKtX7S5EkSCwjXNcOU
         OFn3fFnqqcbmCiE5jCe9/D4piEe3nF1wte8ZAL5uOlg9uxMnvZG+cTNel22A0I3nmw
         Z3nssVa3mv28pw7hFb4lCzfcUJ2/7bxFN+0QBJ/J+/HVqK1j5oVvdaus3sA1hAZ5+l
         JXV9vCzW+TArNkVi1Y8D4Ujv/hWMRZZNsRDn2/UfJOW/wmg61FJs5wVbB6f/2VFFiV
         HYi/mSW1P5hWgY9Zn3+asjPRJFMSlrnqfSbsQTi0y/b4lp2ECVycsYVs/r1WwSQwTa
         WI3h97lhMz6ng==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] MIPS: boot: correct prerequisite image of vmlinux.*.its
Date:   Mon, 16 Apr 2018 23:47:44 +0900
Message-Id: <1523890067-13641-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63566
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

vmlinux.*.its does not directly depend on $(VMLINUX) but
vmlinux.bin.*

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/boot/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 6c7054e..30512ab 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -136,19 +136,19 @@ quiet_cmd_cpp_its_S = ITS     $@
 			-DADDR_BITS=$(ADDR_BITS) \
 			-DADDR_CELLS=$(itb_addr_cells)
 
-$(obj)/vmlinux.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
+$(obj)/vmlinux.its: $(obj)/vmlinux.its.S $(obj)/vmlinux.bin FORCE
 	$(call if_changed,cpp_its_S,none,vmlinux.bin)
 
-$(obj)/vmlinux.gz.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
+$(obj)/vmlinux.gz.its: $(obj)/vmlinux.its.S $(obj)/vmlinux.bin.gz FORCE
 	$(call if_changed,cpp_its_S,gzip,vmlinux.bin.gz)
 
-$(obj)/vmlinux.bz2.its: $(obj)/vmlinux.its.S $(VMLINUX)  FORCE
+$(obj)/vmlinux.bz2.its: $(obj)/vmlinux.its.S $(obj)/vmlinux.bin.bz2 FORCE
 	$(call if_changed,cpp_its_S,bzip2,vmlinux.bin.bz2)
 
-$(obj)/vmlinux.lzma.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
+$(obj)/vmlinux.lzma.its: $(obj)/vmlinux.its.S $(obj)/vmlinux.bin.lzma FORCE
 	$(call if_changed,cpp_its_S,lzma,vmlinux.bin.lzma)
 
-$(obj)/vmlinux.lzo.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
+$(obj)/vmlinux.lzo.its: $(obj)/vmlinux.its.S $(obj)/vmlinux.bin.lzo FORCE
 	$(call if_changed,cpp_its_S,lzo,vmlinux.bin.lzo)
 
 quiet_cmd_itb-image = ITB     $@
-- 
2.7.4
