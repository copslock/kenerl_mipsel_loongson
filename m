Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 21:02:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29555 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993359AbdFBTCqj2nOh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 21:02:46 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 77DE87AF93F18;
        Fri,  2 Jun 2017 20:02:36 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 20:02:40
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] MIPS: .its targets depend on vmlinux
Date:   Fri, 2 Jun 2017 12:02:08 -0700
Message-ID: <20170602190209.23196-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The .its targets require information about the kernel binary, such as
its entry point, which is extracted from the vmlinux ELF. We therefore
require that the ELF is built before the .its files are generated.
Declare this requirement in the Makefile such that make will ensure this
is always the case, otherwise in corner cases we can hit issues as the
.its is generated with an incorrect (either invalid or stale) entry
point.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: cf2a5e0bb4c6 ("MIPS: Support generating Flattened Image Trees (.itb)")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable <stable@vger.kernel.org> # v4.9+
---

 arch/mips/boot/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 2728a9a9c7c5..145b5ce8eb7e 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -128,19 +128,19 @@ quiet_cmd_cpp_its_S = ITS     $@
 			-DADDR_BITS=$(ADDR_BITS) \
 			-DADDR_CELLS=$(itb_addr_cells)
 
-$(obj)/vmlinux.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S FORCE
+$(obj)/vmlinux.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S $(VMLINUX) FORCE
 	$(call if_changed_dep,cpp_its_S,none,vmlinux.bin)
 
-$(obj)/vmlinux.gz.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S FORCE
+$(obj)/vmlinux.gz.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S $(VMLINUX) FORCE
 	$(call if_changed_dep,cpp_its_S,gzip,vmlinux.bin.gz)
 
-$(obj)/vmlinux.bz2.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S FORCE
+$(obj)/vmlinux.bz2.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S $(VMLINUX)  FORCE
 	$(call if_changed_dep,cpp_its_S,bzip2,vmlinux.bin.bz2)
 
-$(obj)/vmlinux.lzma.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S FORCE
+$(obj)/vmlinux.lzma.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S $(VMLINUX) FORCE
 	$(call if_changed_dep,cpp_its_S,lzma,vmlinux.bin.lzma)
 
-$(obj)/vmlinux.lzo.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S FORCE
+$(obj)/vmlinux.lzo.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S $(VMLINUX) FORCE
 	$(call if_changed_dep,cpp_its_S,lzo,vmlinux.bin.lzo)
 
 quiet_cmd_itb-image = ITB     $@
-- 
2.13.0
