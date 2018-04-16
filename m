Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2018 16:50:22 +0200 (CEST)
Received: from conuserg-10.nifty.com ([210.131.2.77]:31122 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994614AbeDPOtDwLyXU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2018 16:49:03 +0200
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w3GElqtp017749;
        Mon, 16 Apr 2018 23:47:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w3GElqtp017749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1523890074;
        bh=F06LX9b18Des9LUgr8HfK4zymALQVUMW+ZLKK7UOatg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wuE00ELCJ4Jq9j2pFOCOyxtIFAEtjz8LQYqBN7fesk5oWkgDk276iZPffCgrtouN/
         0uhgHTtLVC/Hsfg07ijiOD+0SgGpU02YM/h0zO1Dlq7dhlIhH9w2/Qs5Q842u4i8g+
         iuOqxvf2Y6jgLdCQnKjpYNynhGlmU4Lj+gByCqbcsvpvDXl7B718Dvx5HOqF6yU91k
         17KLUnlY37iBF59LiarRkb6w3jGSx1I5n0Sn5PxRRmgsk6w/5QmvHGGvNR/LmrgSwP
         sromBbh/6QckuHfIyNCW4AFfIsc89IZI8yJ5Y1g5ryDK6p7O6zN99TqOZWyRpofR6L
         TyokVcnWCG3AA==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] Revert "MIPS: boot: Define __ASSEMBLY__ for its.S build"
Date:   Mon, 16 Apr 2018 23:47:41 +0900
Message-Id: <1523890067-13641-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63564
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

This reverts commit 0f9da844d87796ac31b04e81ee95e155e9043132.

It is true that commit 0f9da844d877 ("MIPS: boot: Define __ASSEMBLY__
for its.S build") fixed the build error, but it should not have
defined __ASSEMBLY__ just for textual substitution in arbitrary data.
The file is image tree source in this case, but the purpose of using
CPP is to replace some macros.

I merged a better solution, commit a95b37e20db9 ("kbuild: get
<linux/compiler_types.h> out of <linux/kconfig.h>").  The original
fix-up is no longer needed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/boot/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index c22da16..1bd5c4f 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -126,7 +126,6 @@ $(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS
 
 quiet_cmd_cpp_its_S = ITS     $@
       cmd_cpp_its_S = $(CPP) $(cpp_flags) -P -C -o $@ $< \
-			-D__ASSEMBLY__ \
 		        -DKERNEL_NAME="\"Linux $(KERNELRELEASE)\"" \
 			-DVMLINUX_BINARY="\"$(3)\"" \
 			-DVMLINUX_COMPRESSION="\"$(2)\"" \
-- 
2.7.4
