Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2018 16:49:02 +0200 (CEST)
Received: from conuserg-10.nifty.com ([210.131.2.77]:30881 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994553AbeDPOszSvjjU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2018 16:48:55 +0200
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w3GElqtv017749;
        Mon, 16 Apr 2018 23:47:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w3GElqtv017749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1523890080;
        bh=CYPFusBhS8V9N+DmVeG5V++6ZLl4j07EeJcsetbKx8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lWKM97y9xEuDDb1MqFSJF3B7dcmRaP0rmx2WKjAWIJb3aRiX+qz6H5TPwbXXICQF8
         njpMNCAa6i3VyEbPqbkhfGcQ/TAWz+78i3sJ9RhnhBtdOC7YmUfhF1G+tTsfRFvY6q
         zocHwbACaVSbuiQMnsvH2L0kfQcAuvc9bXn2v3ozYY+AArdHt4EZLmMxGOloWV9jty
         2c5cFOF5TMqNSjbGWgTYDqzSIoNaxrw+EMW4NvDOOD1ecHu073r3X8tLN2ksjRh2Ph
         6NmTNX121chIYyFBnLwmwl7fxMulkuyfr/8wGTQsB9nFmzdq4ytZNyDAlkY5X4GzCv
         Ir6wr2FdpAxnQ==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] MIPS: boot: rebuild ITB when contained DTB is updated
Date:   Mon, 16 Apr 2018 23:47:47 +0900
Message-Id: <1523890067-13641-8-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63559
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

Since now, the unnecessary rebuild of ITB has been fixed.  Another
problem to be taken care of is, missed rebuild of ITB.

For example, board-boston.its.S includes boston.dtb by the /incbin/
directive.  If boston.dtb is updated, vmlinux.*.dtb must be rebuilt.
Currently, the dependency between ITB and contained DTB files is not
described anywhere.  Previously, this problem was hidden since
vmlinux.*.itb was always rebuilt even if nothing is updated.  By
fixing the spurious rebuild, this is a real problem now.

Use the same strategy for automatic generation of the header file
dependency.  DTC works as a backend of mkimage, and DTC supports -d
option.  It outputs the dependencies, including binary files pulled
by the /incbin/ directive.

The implementation is simpler than cmd_dtc in scripts/Makefile.lib
since we do not need CPP here.  Just pass -d $(depfile) to DTC, and
let the resulted $(depfile) processed by fixdep.

It might be unclear why "$(obj)/dts/%.dtb: ;" is needed.  With this
commit, *.cmd files will contain dependency on DTB files.  In the
next invocation of build, the *.cmd files will be included, then
Make will try to find a rule to update *.dtb files.  Unfortunately,
it is found in scripts/Makefile.lib.  The build rule of $(obj)/%.dtb
is invoked by if_changed_dep, so it needs to include *.cmd files
of DTB, but they are not included because we are in arch/mips/boot,
but those *.cmd files reside in arch/mips/boot/dts/*/.  Cancel the
pattern rule in scripts/Makefile.lib to suppress unneeded rebuilding
of DTB.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/boot/Makefile | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index d102d53..f8dce5b 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -163,11 +163,18 @@ quiet_cmd_itb-image = ITB     $@
 		$(CONFIG_SHELL) $(MKIMAGE) \
 		-D "-I dts -O dtb -p 500 \
 			--include $(objtree)/arch/mips \
-			--warning no-unit_address_vs_reg" \
+			--warning no-unit_address_vs_reg \
+			-d $(depfile)" \
 		-f $(2) $@
 
 $(obj)/vmlinux.itb: $(obj)/vmlinux.its $(obj)/vmlinux.bin FORCE
-	$(call if_changed,itb-image,$<)
+	$(call if_changed_dep,itb-image,$<)
 
 $(obj)/vmlinux.%.itb: $(obj)/vmlinux.%.its $(obj)/vmlinux.bin.% FORCE
-	$(call if_changed,itb-image,$<)
+	$(call if_changed_dep,itb-image,$<)
+
+# The -d option of DTC outputs dependencies of binaries included by the
+# /incbin/ directive.  When .*.cmd files are included, Kbuild tries to
+# update *.dtb because it sees a pattern rule defined in scripts/Makefile.lib.
+# The rule must be cancelled by a more specific rule.
+$(obj)/dts/%.dtb: ;
-- 
2.7.4
