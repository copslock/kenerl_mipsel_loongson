Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:33:30 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025299AbbDCW0htZMQA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:26:37 +0200
Date:   Fri, 3 Apr 2015 23:26:37 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 34/48] MIPS: math-emu: Fix delay-slot emulation cache
 incoherency
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504031645560.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Correct a cache coherency regression introduced with be1664c4 [Another 
round of fixes for the fp emulator.] for the emulation frame used in 
delay-slot emulation.

Two instructions are copied into the frame and as from the commit 
referred a cache synchronisation call is made for the second instruction 
aka `badinst' of the two only.  The `flush_cache_sigtramp' interface is 
reused that guarantees that synchronisation will be made for 8 bytes or 
2 instructions starting from the address requested, although if cache 
lines are wider then a larger area may be synchronised.

Change the call to point to the first of the two instructions aka `emul' 
instead, removing unpredictable behaviour resulting from cache 
incoherency.

This bug only ever manifested itself on systems implementing 4-byte 
cache lines, typically MIPS I systems, causing all kinds of weirdness.  
This is because the sequence of two instructions starting from `emul' is 
8-byte aligned and for 8-byte or wider cache lines the line synchronised 
will span both, so the vast majority of systems have escaped unharmed.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-dsemul-flush-cache.patch
Index: linux/arch/mips/math-emu/dsemul.c
===================================================================
--- linux.orig/arch/mips/math-emu/dsemul.c	2015-04-02 20:18:49.616501000 +0100
+++ linux/arch/mips/math-emu/dsemul.c	2015-04-02 20:27:57.133225000 +0100
@@ -94,7 +94,7 @@ int mips_dsemul(struct pt_regs *regs, mi
 	regs->cp0_epc = ((unsigned long) &fr->emul) |
 		get_isa16_mode(regs->cp0_epc);
 
-	flush_cache_sigtramp((unsigned long)&fr->badinst);
+	flush_cache_sigtramp((unsigned long)&fr->emul);
 
 	return SIGILL;		/* force out of emulation loop */
 }
