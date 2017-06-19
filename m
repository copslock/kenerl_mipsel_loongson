Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 17:33:15 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:45700 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992936AbdFSPdFfMkGH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jun 2017 17:33:05 +0200
Received: from localhost (unknown [106.120.91.188])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D3241B5D;
        Mon, 19 Jun 2017 15:32:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 28/30] MIPS: Fix bnezc/jialc return address calculation
Date:   Mon, 19 Jun 2017 23:21:02 +0800
Message-Id: <20170619152034.774803859@linuxfoundation.org>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170619152033.211450261@linuxfoundation.org>
References: <20170619152033.211450261@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58609
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 1a73d9310e093fc3adffba4d0a67b9fab2ee3f63 upstream.

The code handling the pop76 opcode (ie. bnezc & jialc instructions) in
__compute_return_epc_for_insn() needs to set the value of $31 in the
jialc case, which is encoded with rs = 0. However its check to
differentiate bnezc (rs != 0) from jialc (rs = 0) was unfortunately
backwards, meaning that if we emulate a bnezc instruction we clobber $31
& if we emulate a jialc instruction it actually behaves like a jic
instruction.

Fix this by inverting the check of rs to match the way the instructions
are actually encoded.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 28d6f93d201d ("MIPS: Emulate the new MIPS R6 BNEZC and JIALC instructions")
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16178/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/branch.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -816,8 +816,10 @@ int __compute_return_epc_for_insn(struct
 			break;
 		}
 		/* Compact branch: BNEZC || JIALC */
-		if (insn.i_format.rs)
+		if (!insn.i_format.rs) {
+			/* JIALC: set $31/ra */
 			regs->regs[31] = epc + 4;
+		}
 		regs->cp0_epc += 8;
 		break;
 #endif
