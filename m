Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2018 16:50:00 +0200 (CEST)
Received: from conuserg-10.nifty.com ([210.131.2.77]:31099 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993973AbeDPOtCyvofU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2018 16:49:02 +0200
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w3GElqtu017749;
        Mon, 16 Apr 2018 23:47:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w3GElqtu017749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1523890079;
        bh=AL+AYw4+X1BQcUmTpdgvByIJRIFE7yRBsMSNpOqkwEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u5BxkN4kzTtJ+DX+AcGYz6ix1UGYTl3pizjODDgPfmJ8BK/zBrYho7kfUHhkJuakf
         NUfWnzRJIcdVA3sgN7ThdCZVS08hKJwsmihMpIYl15hNi76Uuh8ubfbBL1H7U84065
         lndyVZ1rLeyYgMwqLmmkuuDMsR3A62a5/SMF/+9LDFswrzcBfEultjSv8HefbCKByt
         uOCUtoifR1Yyc3Lhnze8zZbkuY8HlkQe9RMurtHDcGv9vux4PAdwM4jTjLC+EZGVeo
         tu0cIGaIWL9BNfl2mtnHtC2lUha++d/Odyyuo3tMO4zKnK4QvsMyVlSWv46qkwD9nX
         yqRQC+DbfaeDw==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] MIPS: boot: merge build rules of vmlinux.*.itb by using pattern rule
Date:   Mon, 16 Apr 2018 23:47:46 +0900
Message-Id: <1523890067-13641-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63563
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

Merge the build rule of vmlinux.{gz,bz2,lzma,lzo}.itb, and also move
'targets' close to the related code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/boot/Makefile | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 91d9fe8..d102d53 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -105,12 +105,6 @@ $(obj)/uImage: $(obj)/uImage.$(suffix-y)
 # Flattened Image Tree (.itb) images
 #
 
-targets += vmlinux.itb
-targets += vmlinux.gz.itb
-targets += vmlinux.bz2.itb
-targets += vmlinux.lzma.itb
-targets += vmlinux.lzo.itb
-
 ifeq ($(ADDR_BITS),32)
 	itb_addr_cells = 1
 endif
@@ -157,6 +151,12 @@ $(obj)/vmlinux.lzma.its: $(obj)/vmlinux.its.S $(obj)/vmlinux.bin.lzma FORCE
 $(obj)/vmlinux.lzo.its: $(obj)/vmlinux.its.S $(obj)/vmlinux.bin.lzo FORCE
 	$(call if_changed,cpp_its_S,lzo,vmlinux.bin.lzo)
 
+targets += vmlinux.itb
+targets += vmlinux.gz.itb
+targets += vmlinux.bz2.itb
+targets += vmlinux.lzma.itb
+targets += vmlinux.lzo.itb
+
 quiet_cmd_itb-image = ITB     $@
       cmd_itb-image = \
 		env PATH="$(objtree)/scripts/dtc:$(PATH)" \
@@ -169,14 +169,5 @@ quiet_cmd_itb-image = ITB     $@
 $(obj)/vmlinux.itb: $(obj)/vmlinux.its $(obj)/vmlinux.bin FORCE
 	$(call if_changed,itb-image,$<)
 
-$(obj)/vmlinux.gz.itb: $(obj)/vmlinux.gz.its $(obj)/vmlinux.bin.gz FORCE
-	$(call if_changed,itb-image,$<)
-
-$(obj)/vmlinux.bz2.itb: $(obj)/vmlinux.bz2.its $(obj)/vmlinux.bin.bz2 FORCE
-	$(call if_changed,itb-image,$<)
-
-$(obj)/vmlinux.lzma.itb: $(obj)/vmlinux.lzma.its $(obj)/vmlinux.bin.lzma FORCE
-	$(call if_changed,itb-image,$<)
-
-$(obj)/vmlinux.lzo.itb: $(obj)/vmlinux.lzo.its $(obj)/vmlinux.bin.lzo FORCE
+$(obj)/vmlinux.%.itb: $(obj)/vmlinux.%.its $(obj)/vmlinux.bin.% FORCE
 	$(call if_changed,itb-image,$<)
-- 
2.7.4
