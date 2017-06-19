Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 17:31:26 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:45312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993879AbdFSPayMyHXH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jun 2017 17:30:54 +0200
Received: from localhost (unknown [106.120.91.188])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D9BEEB6C;
        Mon, 19 Jun 2017 15:30:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.9 56/60] MIPS: .its targets depend on vmlinux
Date:   Mon, 19 Jun 2017 23:17:50 +0800
Message-Id: <20170619151646.827425953@linuxfoundation.org>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170619151644.680979056@linuxfoundation.org>
References: <20170619151644.680979056@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit bcd7c45e0d5a82be9a64b90050f0e09d41a50758 upstream.

The .its targets require information about the kernel binary, such as
its entry point, which is extracted from the vmlinux ELF. We therefore
require that the ELF is built before the .its files are generated.
Declare this requirement in the Makefile such that make will ensure this
is always the case, otherwise in corner cases we can hit issues as the
.its is generated with an incorrect (either invalid or stale) entry
point.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: cf2a5e0bb4c6 ("MIPS: Support generating Flattened Image Trees (.itb)")
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16179/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/boot/Makefile |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

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
