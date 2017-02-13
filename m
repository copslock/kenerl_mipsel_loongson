Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2017 21:38:34 +0100 (CET)
Received: from smtp6-g21.free.fr ([212.27.42.6]:16639 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993874AbdBMUi1UBNWF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Feb 2017 21:38:27 +0100
Received: from localhost.localdomain (unknown [78.54.29.3])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPA id E9444780217;
        Mon, 13 Feb 2017 21:38:16 +0100 (CET)
From:   Alban <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Alban Bedel <albeu@free.fr>, Ralf Baechle <ralf@linux-mips.org>,
        Jonas Gorski <jogo@openwrt.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] MIPS: Allow compressed images to be loaded at any address
Date:   Mon, 13 Feb 2017 21:38:08 +0100
Message-Id: <1487018290-10451-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.7.4
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

From: Alban Bedel <albeu@free.fr>

Compressed images (vmlinuz.bin) have to be loaded at a specific
address that differ from the address normaly used for vmlinux.bin.
This is because the decompressor just write its output at the address
vmlinux.bin should be loaded at, and it shouldn't overwrite itself.
This limitation mean that the bootloader must be configured differently
when loading a vmlinux.bin or a vmlinuz.bin image, this is annoying
and a source of error.

To workaround this we extend the compressed loader to cope with being
loaded at (nearly) any address. During the early init a jump is used
to compute the offset between the current address and the linked
address, if they differ the whole image is first copied to the linked
address before proceeding.

Some load address won't work, for example if there is an overlap with
the range where vmlinuz.bin should be loaded. However for the typical
case of using the vmlinux.bin address that won't be the case.

Signed-off-by: Alban Bedel <albeu@free.fr>
Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
---
Changelog:
v2: * Rework the code as suggested by Jonas Gorski to autodetect the
      load address and remove the need for a Kconfig option.
---
 arch/mips/boot/compressed/head.S | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
index 409cb48..3c25a96 100644
--- a/arch/mips/boot/compressed/head.S
+++ b/arch/mips/boot/compressed/head.S
@@ -25,6 +25,29 @@ start:
 	move	s2, a2
 	move	s3, a3
 
+	/* Get the offset between the current address and linked address */
+	PTR_LA	t0, reloc_label
+	bal	reloc_label
+	 nop
+reloc_label:
+	subu	t0, ra, t0
+
+	/* If there is no offset no reloc is needed */
+	beqz	t0, clear_bss
+	 nop
+
+	/* Move the text, data section and DTB to the correct address */
+	PTR_LA	a0, .text
+	addu	a1, t0, a0
+	PTR_LA	a2, _edata
+copy_vmlinuz:
+	lw	a3, 0(a1)
+	sw	a3, 0(a0)
+	addiu	a0, a0, 4
+	bne	a2, a0, copy_vmlinuz
+	 addiu	a1, a1, 4
+
+clear_bss:
 	/* Clear BSS */
 	PTR_LA	a0, _edata
 	PTR_LA	a2, _end
-- 
2.7.4
