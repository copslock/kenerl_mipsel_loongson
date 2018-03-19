Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2018 19:15:15 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:59038 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992678AbeCSSOnGxYNx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2018 19:14:43 +0100
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 893EBF37;
        Mon, 19 Mar 2018 18:14:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtech.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtech.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>, james.hogan@imgtec.com,
        petar.jovanovic@imgtec.com, goran.ferenc@imgtec.com,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 064/134] MIPS: r2-on-r6-emu: Fix BLEZL and BGTZL identification
Date:   Mon, 19 Mar 2018 19:05:47 +0100
Message-Id: <20180319171858.532633977@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63058
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>


[ Upstream commit 5bba7aa4958e271c3ffceb70d47d3206524cf489 ]

Fix the problem of inaccurate identification of instructions BLEZL and
BGTZL in R2 emulation code by making sure all necessary encoding
specifications are met.

Previously, certain R6 instructions could be identified as BLEZL or
BGTZL. R2 emulation routine didn't take into account that both BLEZL
and BGTZL instructions require their rt field (bits 20 to 16 of
instruction encoding) to be 0, and that, at same time, if the value in
that field is not 0, the encoding may represent a legitimate MIPS R6
instruction.

This means that a problem could occur after emulation optimization,
when emulation routine tried to pipeline emulation, picked up a next
candidate, and subsequently misrecognized an R6 instruction as BLEZL
or BGTZL.

It should be said that for single pass strategy, the problem does not
happen because CPU doesn't trap on branch-compacts which share opcode
space with BLEZL/BGTZL (but have rt field != 0, of course).

Signed-off-by: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtech.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtech.com>
Reported-by: Douglas Leung <douglas.leung@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Cc: james.hogan@imgtec.com
Cc: petar.jovanovic@imgtec.com
Cc: goran.ferenc@imgtec.com
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15456/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/mips-r2-to-r6-emul.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -1097,10 +1097,20 @@ repeat:
 		}
 		break;
 
-	case beql_op:
-	case bnel_op:
 	case blezl_op:
 	case bgtzl_op:
+		/*
+		 * For BLEZL and BGTZL, rt field must be set to 0. If this
+		 * is not the case, this may be an encoding of a MIPS R6
+		 * instruction, so return to CPU execution if this occurs
+		 */
+		if (MIPSInst_RT(inst)) {
+			err = SIGILL;
+			break;
+		}
+		/* fall through */
+	case beql_op:
+	case bnel_op:
 		if (delay_slot(regs)) {
 			err = SIGILL;
 			break;
