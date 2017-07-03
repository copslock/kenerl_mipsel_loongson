Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2017 15:49:42 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41448 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994881AbdGCNtevgIli (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jul 2017 15:49:34 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 571B2596;
        Mon,  3 Jul 2017 13:49:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karl Beldan <karl.beldan+oss@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.11 36/84] MIPS: head: Reorder instructions missing a delay slot
Date:   Mon,  3 Jul 2017 15:35:16 +0200
Message-Id: <20170703133405.291250546@linuxfoundation.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170703133402.874816941@linuxfoundation.org>
References: <20170703133402.874816941@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59001
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

4.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karl Beldan <karl.beldan@gmail.com>

commit 25d8b92e0af75d72ce8b99e63e5a449cc0888efa upstream.

In this sequence the 'move' is assumed in the delay slot of the 'beq',
but head.S is in reorder mode and the former gets pushed one 'nop'
farther by the assembler.

The corrected behavior made booting with an UHI supplied dtb erratic.

Fixes: 15f37e158892 ("MIPS: store the appended dtb address in a variable")
Signed-off-by: Karl Beldan <karl.beldan+oss@gmail.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: Jonas Gorski <jogo@openwrt.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/16614/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/head.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -106,8 +106,8 @@ NESTED(kernel_entry, 16, sp)			# kernel
 	beq		t0, t1, dtb_found
 #endif
 	li		t1, -2
-	beq		a0, t1, dtb_found
 	move		t2, a1
+	beq		a0, t1, dtb_found
 
 	li		t2, 0
 dtb_found:
