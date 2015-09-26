Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Sep 2015 22:57:26 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:56771 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008821AbbIZU5HDJSPg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Sep 2015 22:57:07 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 27431BF9;
        Sat, 26 Sep 2015 20:57:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.2 020/134] MIPS: math-emu: Emulate missing BC1{EQ,NE}Z instructions
Date:   Sat, 26 Sep 2015 13:54:32 -0700
Message-Id: <20150926205312.996453781@linuxfoundation.org>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <20150926205311.819185658@linuxfoundation.org>
References: <20150926205311.819185658@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49375
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

4.2-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit c909ca718e8f50cf484ef06a8dd935e738e8e53d upstream.

Commit c8a34581ec09 ("MIPS: Emulate the BC1{EQ,NE}Z FPU instructions")
added support for emulating the new R6 BC1{EQ,NE}Z branches but it missed
the case where the instruction that caused the exception was not on a DS.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Fixes: c8a34581ec09 ("MIPS: Emulate the BC1{EQ,NE}Z FPU instructions")
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10738/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/math-emu/cp1emu.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1181,6 +1181,24 @@ emul:
 			}
 			break;
 
+		case bc1eqz_op:
+		case bc1nez_op:
+			if (!cpu_has_mips_r6 || delay_slot(xcp))
+				return SIGILL;
+
+			cond = likely = 0;
+			switch (MIPSInst_RS(ir)) {
+			case bc1eqz_op:
+				if (get_fpr32(&current->thread.fpu.fpr[MIPSInst_RT(ir)], 0) & 0x1)
+				    cond = 1;
+				break;
+			case bc1nez_op:
+				if (!(get_fpr32(&current->thread.fpu.fpr[MIPSInst_RT(ir)], 0) & 0x1))
+				    cond = 1;
+				break;
+			}
+			goto branch_common;
+
 		case bc_op:
 			if (delay_slot(xcp))
 				return SIGILL;
@@ -1207,7 +1225,7 @@ emul:
 			case bct_op:
 				break;
 			}
-
+branch_common:
 			set_delay_slot(xcp);
 			if (cond) {
 				/*
