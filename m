Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 02:29:23 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53323 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013452AbaKLB2tTZtSi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 02:28:49 +0100
Received: from localhost (unknown [59.10.106.2])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ED4D59AB;
        Wed, 12 Nov 2014 01:28:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.17 146/319] MIPS: cp1emu: Fix ISA restrictions for cop1x_op instructions
Date:   Wed, 12 Nov 2014 10:14:44 +0900
Message-Id: <20141112011016.690196934@linuxfoundation.org>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <20141112010952.553519040@linuxfoundation.org>
References: <20141112010952.553519040@linuxfoundation.org>
User-Agent: quilt/0.63-1
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44020
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

3.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit a5466d7bba9af83a82cc7c081b2a7d557cde3204 upstream.

Commit 08a07904e1828 ("MIPS: math-emu: Remove most ifdefery") removed
the #ifdef ISA conditions and switched to runtime detection. However,
according to the instruction set manual, the cop1x_op instructions are
available in >=MIPS32r2 as well. This fixes a problem on MIPS32r2
with the ntpd package which failed to execute with a SIGILL exit code due
to the fact that a madd.d instruction was not being emulated.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Fixes: 08a07904e1828 ("MIPS: math-emu: Remove most ifdefery")
Cc: linux-mips@linux-mips.org
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Patchwork: https://patchwork.linux-mips.org/patch/8173/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/math-emu/cp1emu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1023,7 +1023,7 @@ emul:
 					goto emul;
 
 				case cop1x_op:
-					if (cpu_has_mips_4_5 || cpu_has_mips64)
+					if (cpu_has_mips_4_5 || cpu_has_mips64 || cpu_has_mips32r2)
 						/* its one of ours */
 						goto emul;
 
@@ -1068,7 +1068,7 @@ emul:
 		break;
 
 	case cop1x_op:
-		if (!cpu_has_mips_4_5 && !cpu_has_mips64)
+		if (!cpu_has_mips_4_5 && !cpu_has_mips64 && !cpu_has_mips32r2)
 			return SIGILL;
 
 		sig = fpux_emu(xcp, ctx, ir, fault_addr);
