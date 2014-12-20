Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 02:54:02 +0100 (CET)
Received: from mail-ig0-f169.google.com ([209.85.213.169]:39924 "EHLO
        mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009320AbaLTBwweuvs6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Dec 2014 02:52:52 +0100
Received: by mail-ig0-f169.google.com with SMTP id hl2so2975356igb.2;
        Fri, 19 Dec 2014 17:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oqW6uKakUR9KhU2nB5hg+BPu/L5YjYZoijky3EGM1GQ=;
        b=B2tn3TFsO7H9WbQNX9eHrkjXN/vCOzN12HFr44LAM192jz8f4pFgLcD4KqdZ4dVq0q
         oFi0ZCbOo+E5CVO9MygJD56Y6s1De/u8C+I1D8vAGOjEk6bld5wrKhz+bOsWP36B0mWl
         CS2pfSuV0vpBI7GzthVNtAWe88Eh0VQkMG+zv4xvuPvhWde0vOfiiWsb8BQ7kTpzevX6
         LDJ/sz/Vxg0/3W00DO4H3//Y0UuNBzaQ7CDHdr2lzLzc3hrbyZCAe4Kc/mzth5JAqcfo
         HZy02WrOoFUdFrXo1ykLv2qHIqBdATd9Qys4Sx154pJVcnju5sd/idgyQXdD4nNzQV7s
         JJow==
X-Received: by 10.107.30.204 with SMTP id e195mr10479809ioe.28.1419040367075;
        Fri, 19 Dec 2014 17:52:47 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id v83sm5340758iov.30.2014.12.19.17.52.45
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 17:52:46 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id sBK1qjxL008562;
        Fri, 19 Dec 2014 17:52:45 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id sBK1qjZB008561;
        Fri, 19 Dec 2014 17:52:45 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [RFC PATCH v2 5/5] MIPS: Use full instruction emulation for FPU emulator delay slot emulation.
Date:   Fri, 19 Dec 2014 17:52:40 -0800
Message-Id: <1419040360-8502-6-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1419040360-8502-1-git-send-email-ddaney.cavm@gmail.com>
References: <1419040360-8502-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Current delay slot handling does eXecute Out of Line (XOL) on the
stack, which prevents a non-executable stack.  Use the instruction
emulator instead.

Tested by booting 32-bit Debian on OCTEON.  More than 1700
instructions emulated to login to command line.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/math-emu/cp1emu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 9dfcd7f..0611697 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -699,11 +699,12 @@ do {									\
  * Emulate the single floating point instruction pointed at by EPC.
  * Two instructions if the instruction is in a branch delay slot.
  */
-
+int mips_insn_emul(struct pt_regs *regs, mips_instruction ir, void *__user *fault_addr);
 static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		struct mm_decoded_insn dec_insn, void *__user *fault_addr)
 {
 	unsigned long contpc = xcp->cp0_epc + dec_insn.pc_inc;
+	unsigned long origpc = xcp->cp0_epc;
 	unsigned int cond, cbit;
 	mips_instruction ir;
 	int likely, pc_inc;
@@ -1043,7 +1044,15 @@ emul:
 				 * Single step the non-cp1
 				 * instruction in the dslot
 				 */
-				return mips_dsemul(xcp, ir, contpc);
+				sig = mips_insn_emul(xcp, ir, fault_addr);
+				if (sig == 0) {
+					xcp->cp0_epc = contpc;
+					MIPS_FPU_EMU_INC_STATS(insn_emul);
+				} else {
+					xcp->cp0_epc = origpc;
+					pr_err("mips_insn_emul: %08x ->%d\n", (unsigned)ir, sig);
+				}
+				return sig;
 			} else if (likely) {	/* branch not taken */
 					/*
 					 * branch likely nullifies
-- 
1.7.11.7
