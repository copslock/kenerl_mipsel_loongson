Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2018 16:49:30 +0200 (CEST)
Received: from conuserg-10.nifty.com ([210.131.2.77]:30882 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993997AbeDPOszSRSWU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2018 16:48:55 +0200
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w3GElqtq017749;
        Mon, 16 Apr 2018 23:47:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w3GElqtq017749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1523890075;
        bh=oI55uYqr0ZldDMV7KaPiWVBquuUvS9m0s8FRGZ8XxEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EyVhZFQLQhRcd8nv4DsNv6J/PJYXgC7zJ5niPh4Cw7btqwwvrshzz6NcgFbzmdQ5L
         rReyBooEFv+7DM4fT7WfrLqHa/OpdNb3u0UfEyyAj1xa6RW62zIZUOU5bWBQclQ1jG
         eM8bHXMaKcnrWVZY0ekg4Hn4Q/4FVRqj6/YaBy5JOy9eVs2YRfLi1jl1724eOvjOw5
         5gRDnTFyphOhh9PPEBd4DXmAK27OLALSNWKx1gKxkmoAwycOExhtNF2rFsVxEet1X/
         DLUC+SziiHeE49pXrP3TbpeKRNn9qmD9CVw7TfWmkeR4EqjiC+MGhRfg3GOpwP9g7D
         Pi/r5pBqpcpkA==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] MIPS: boot: do not include $(cpp_flags) for preprocessing ITS
Date:   Mon, 16 Apr 2018 23:47:42 +0900
Message-Id: <1523890067-13641-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63561
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

$(CPP) is used here to perform macro replacement in ITS.  Do not
pass $(cpp_flags) because it pulls in more options for dependency
file generation etc. but none of which is necessary here.  ITS files
do not include any header file, so $(call if_change,...) is enough.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/boot/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 1bd5c4f..981bcf8 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -125,7 +125,7 @@ $(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS
 	$(call if_changed,its_cat)
 
 quiet_cmd_cpp_its_S = ITS     $@
-      cmd_cpp_its_S = $(CPP) $(cpp_flags) -P -C -o $@ $< \
+      cmd_cpp_its_S = $(CPP) -P -C -o $@ $< \
 		        -DKERNEL_NAME="\"Linux $(KERNELRELEASE)\"" \
 			-DVMLINUX_BINARY="\"$(3)\"" \
 			-DVMLINUX_COMPRESSION="\"$(2)\"" \
@@ -135,19 +135,19 @@ quiet_cmd_cpp_its_S = ITS     $@
 			-DADDR_CELLS=$(itb_addr_cells)
 
 $(obj)/vmlinux.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
-	$(call if_changed_dep,cpp_its_S,none,vmlinux.bin)
+	$(call if_changed,cpp_its_S,none,vmlinux.bin)
 
 $(obj)/vmlinux.gz.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
-	$(call if_changed_dep,cpp_its_S,gzip,vmlinux.bin.gz)
+	$(call if_changed,cpp_its_S,gzip,vmlinux.bin.gz)
 
 $(obj)/vmlinux.bz2.its: $(obj)/vmlinux.its.S $(VMLINUX)  FORCE
-	$(call if_changed_dep,cpp_its_S,bzip2,vmlinux.bin.bz2)
+	$(call if_changed,cpp_its_S,bzip2,vmlinux.bin.bz2)
 
 $(obj)/vmlinux.lzma.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
-	$(call if_changed_dep,cpp_its_S,lzma,vmlinux.bin.lzma)
+	$(call if_changed,cpp_its_S,lzma,vmlinux.bin.lzma)
 
 $(obj)/vmlinux.lzo.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
-	$(call if_changed_dep,cpp_its_S,lzo,vmlinux.bin.lzo)
+	$(call if_changed,cpp_its_S,lzo,vmlinux.bin.lzo)
 
 quiet_cmd_itb-image = ITB     $@
       cmd_itb-image = \
-- 
2.7.4
