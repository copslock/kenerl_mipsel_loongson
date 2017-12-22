Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Dec 2017 09:58:09 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:38804 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990633AbdLVI6BJIPhG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Dec 2017 09:58:01 +0100
Received: from localhost (LFbn-1-12262-44.w90-92.abo.wanadoo.fr [90.92.75.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3DA9889F;
        Fri, 22 Dec 2017 08:57:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.9 102/104] MIPS: math-emu: Fix final emulation phase for certain instructions
Date:   Fri, 22 Dec 2017 09:47:08 +0100
Message-Id: <20171222084617.434198121@linuxfoundation.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171222084609.262099650@linuxfoundation.org>
References: <20171222084609.262099650@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61554
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

From: Aleksandar Markovic <aleksandar.markovic@mips.com>

commit 409fcace9963c1e8d2cb0f7ac62e8b34d47ef979 upstream.

Fix final phase of <CLASS|MADDF|MSUBF|MAX|MIN|MAXA|MINA>.<D|S>
emulation. Provide proper generation of SIGFPE signal and updating
debugfs FP exception stats in cases of any exception flags set in
preceding phases of emulation.

CLASS.<D|S> instruction may generate "Unimplemented Operation" FP
exception. <MADDF|MSUBF>.<D|S> instructions may generate "Inexact",
"Unimplemented Operation", "Invalid Operation", "Overflow", and
"Underflow" FP exceptions. <MAX|MIN|MAXA|MINA>.<D|S> instructions
can generate "Unimplemented Operation" and "Invalid Operation" FP
exceptions.

The proper final processing of the cases when any FP exception
flag is set is achieved by replacing "break" statement with "goto
copcsr" statement. With such solution, this patch brings the final
phase of emulation of the above instructions consistent with the
one corresponding to the previously implemented emulation of other
related FPU instructions (ADD, SUB, etc.).

Fixes: 38db37ba069f ("MIPS: math-emu: Add support for the MIPS R6 CLASS FPU instruction")
Fixes: e24c3bec3e8e ("MIPS: math-emu: Add support for the MIPS R6 MADDF FPU instruction")
Fixes: 83d43305a1df ("MIPS: math-emu: Add support for the MIPS R6 MSUBF FPU instruction")
Fixes: a79f5f9ba508 ("MIPS: math-emu: Add support for the MIPS R6 MAX{, A} FPU instruction")
Fixes: 4e9561b20e2f ("MIPS: math-emu: Add support for the MIPS R6 MIN{, A} FPU instruction")
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Douglas Leung <douglas.leung@mips.com>
Cc: Goran Ferenc <goran.ferenc@mips.com>
Cc: "Maciej W. Rozycki" <macro@imgtec.com>
Cc: Miodrag Dinic <miodrag.dinic@mips.com>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Petar Jovanovic <petar.jovanovic@mips.com>
Cc: Raghu Gandham <raghu.gandham@mips.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17581/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/math-emu/cp1emu.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1781,7 +1781,7 @@ static int fpu_emu(struct pt_regs *xcp,
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			SPFROMREG(fd, MIPSInst_FD(ir));
 			rv.s = ieee754sp_maddf(fd, fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fmsubf_op: {
@@ -1794,7 +1794,7 @@ static int fpu_emu(struct pt_regs *xcp,
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			SPFROMREG(fd, MIPSInst_FD(ir));
 			rv.s = ieee754sp_msubf(fd, fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case frint_op: {
@@ -1818,7 +1818,7 @@ static int fpu_emu(struct pt_regs *xcp,
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.w = ieee754sp_2008class(fs);
 			rfmt = w_fmt;
-			break;
+			goto copcsr;
 		}
 
 		case fmin_op: {
@@ -1830,7 +1830,7 @@ static int fpu_emu(struct pt_regs *xcp,
 			SPFROMREG(ft, MIPSInst_FT(ir));
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.s = ieee754sp_fmin(fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fmina_op: {
@@ -1842,7 +1842,7 @@ static int fpu_emu(struct pt_regs *xcp,
 			SPFROMREG(ft, MIPSInst_FT(ir));
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.s = ieee754sp_fmina(fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fmax_op: {
@@ -1854,7 +1854,7 @@ static int fpu_emu(struct pt_regs *xcp,
 			SPFROMREG(ft, MIPSInst_FT(ir));
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.s = ieee754sp_fmax(fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fmaxa_op: {
@@ -1866,7 +1866,7 @@ static int fpu_emu(struct pt_regs *xcp,
 			SPFROMREG(ft, MIPSInst_FT(ir));
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.s = ieee754sp_fmaxa(fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fabs_op:
@@ -2110,7 +2110,7 @@ copcsr:
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			DPFROMREG(fd, MIPSInst_FD(ir));
 			rv.d = ieee754dp_maddf(fd, fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fmsubf_op: {
@@ -2123,7 +2123,7 @@ copcsr:
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			DPFROMREG(fd, MIPSInst_FD(ir));
 			rv.d = ieee754dp_msubf(fd, fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case frint_op: {
@@ -2147,7 +2147,7 @@ copcsr:
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.w = ieee754dp_2008class(fs);
 			rfmt = w_fmt;
-			break;
+			goto copcsr;
 		}
 
 		case fmin_op: {
@@ -2159,7 +2159,7 @@ copcsr:
 			DPFROMREG(ft, MIPSInst_FT(ir));
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.d = ieee754dp_fmin(fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fmina_op: {
@@ -2171,7 +2171,7 @@ copcsr:
 			DPFROMREG(ft, MIPSInst_FT(ir));
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.d = ieee754dp_fmina(fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fmax_op: {
@@ -2183,7 +2183,7 @@ copcsr:
 			DPFROMREG(ft, MIPSInst_FT(ir));
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.d = ieee754dp_fmax(fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fmaxa_op: {
@@ -2195,7 +2195,7 @@ copcsr:
 			DPFROMREG(ft, MIPSInst_FT(ir));
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.d = ieee754dp_fmaxa(fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fabs_op:
