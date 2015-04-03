Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:27:35 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025266AbbDCWYqcHbTF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:24:46 +0200
Date:   Fri, 3 Apr 2015 23:24:46 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 14/48] MIPS: mips-r2-to-r6-emul.h: Inline empty
 `mipsr2_decoder'
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030239340.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46731
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

Use `static inline' rather than `static __maybe_unused' for 
`mipsr2_decoder' in the empty case, making inlining explicit where it 
will happen anyway.

Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-r2-decoder-inline.patch
Index: linux/arch/mips/include/asm/mips-r2-to-r6-emul.h
===================================================================
--- linux.orig/arch/mips/include/asm/mips-r2-to-r6-emul.h	2015-04-02 20:18:51.667537000 +0100
+++ linux/arch/mips/include/asm/mips-r2-to-r6-emul.h	2015-04-02 20:27:53.724187000 +0100
@@ -84,7 +84,7 @@ extern void do_trap_or_bp(struct pt_regs
 
 #ifndef CONFIG_MIPSR2_TO_R6_EMULATOR
 static int mipsr2_emulation;
-static __maybe_unused int mipsr2_decoder(struct pt_regs *regs, u32 inst) { return 0; };
+static inline int mipsr2_decoder(struct pt_regs *regs, u32 inst) { return 0; };
 #else
 /* MIPS R2 Emulator ON/OFF */
 extern int mipsr2_emulation;
