Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Aug 2015 00:10:35 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41315 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011577AbbHHWKbaHaZf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Aug 2015 00:10:31 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9FD43279;
        Sat,  8 Aug 2015 22:10:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.1 012/123] MIPS: Fix erroneous JR emulation for MIPS R6
Date:   Sat,  8 Aug 2015 15:08:10 -0700
Message-Id: <20150808220718.265353690@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <20150808220717.771230091@linuxfoundation.org>
References: <20150808220717.771230091@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48736
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

4.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit 143fefc8f315cd10e046e6860913c421c3385cb1 upstream.

Commit 5f9f41c474befb4ebbc40b27f65bb7d649241581 ("MIPS: kernel: Prepare
the JR instruction for emulation on MIPS R6") added support for
emulating the JR instruction on MIPS R6 cores but that introduced a bug
which could be triggered when hitting a JALR opcode because the code used
the wrong field in the 'r_format' struct to determine the instruction
opcode. This lead to crashes because an emulated JALR instruction was
treated as a JR one when the R6 emulator was turned off.

Fixes: 5f9f41c474be ("MIPS: kernel: Prepare the JR instruction for emulation on MIPS R6")
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10583/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/math-emu/cp1emu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -451,7 +451,7 @@ static int isBranchInstr(struct pt_regs
 			/* Fall through */
 		case jr_op:
 			/* For R6, JR already emulated in jalr_op */
-			if (NO_R6EMU && insn.r_format.opcode == jr_op)
+			if (NO_R6EMU && insn.r_format.func == jr_op)
 				break;
 			*contpc = regs->regs[insn.r_format.rs];
 			return 1;
