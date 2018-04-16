Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2018 16:50:35 +0200 (CEST)
Received: from conuserg-10.nifty.com ([210.131.2.77]:31125 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994621AbeDPOtD6NIgU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2018 16:49:03 +0200
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w3GElqtr017749;
        Mon, 16 Apr 2018 23:47:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w3GElqtr017749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1523890076;
        bh=A1Gn6EVXs/augMnXta7rJ5tKBPekzAV8iaSCKb3cg08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MdU+HiMlCj6q23aOrwjSN5m83qSRsbVxxa2eTPxmgafncUeyJtsC8vcLtXgN6ro8J
         GpRrMKZHuPMlngUwBoBkOuVeMwST5lnrUYtz4mltYq24297N6wxyvcHBLVm4mMV/Yn
         6Wmn9K3XMcUz6KqXrxcRGM9u+Yvm/MQgvFhm/ulMNeiq53xmtppOZeHILMwZGbmbdD
         bPijsj76/PhmIrKzWGYTkFnrN5dd6PLZhtiTw5094FFh3zrUjFM9q/wDwvABs6DmGj
         m6/46Y3hlVFOJUbYNCe2+MG3I8d26iihrTl27wdpSiBvq4FN/eSjCK/xgUYd/OMOl1
         saWDU9ah7XL3A==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] MIPS: boot: fix build rule of vmlinux.its.S
Date:   Mon, 16 Apr 2018 23:47:43 +0900
Message-Id: <1523890067-13641-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63565
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

As Documentation/kbuild/makefile.txt says, it is a typical mistake
to forget the FORCE prerequisite for the rule invoked by if_changed.

Add the FORCE to the prerequisite, but it must be filtered-out from
the files passed to the 'cat' command.  Because this rule generates
.vmlinux.its.S.cmd, vmlinux.its.S must be specified as targets so
that the .cmd file is included.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/boot/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 981bcf8..6c7054e 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -118,10 +118,12 @@ ifeq ($(ADDR_BITS),64)
 	itb_addr_cells = 2
 endif
 
+targets += vmlinux.its.S
+
 quiet_cmd_its_cat = CAT     $@
-      cmd_its_cat = cat $^ >$@
+      cmd_its_cat = cat $(filter-out $(PHONY), $^) >$@
 
-$(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS))
+$(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS)) FORCE
 	$(call if_changed,its_cat)
 
 quiet_cmd_cpp_its_S = ITS     $@
-- 
2.7.4
