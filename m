Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 16:34:01 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:20107 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022987AbXG3Pd5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Jul 2007 16:33:57 +0100
Received: (qmail 13509 invoked by uid 511); 30 Jul 2007 15:37:43 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 30 Jul 2007 15:37:43 -0000
Message-ID: <46AE049C.6040500@lemote.com>
Date:	Mon, 30 Jul 2007 23:32:44 +0800
From:	Songmao Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: A blind patch:)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

commit 5fabf601a53079c182d5c25f6e850d6a7bd48988 is broken. since the 
regptr is disappeared in the signature of the function, I think the 
regptr is useless.


diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index bbf20ce..1b94eef 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -281,9 +281,7 @@ static void emulate_load_store_insn(struct pt_regs 
*regs,
             : "r" (addr), "i" (-EFAULT));
         if (res)
             goto fault;
-        *regptr = &regs->regs[insn.i_format.rt];
         compute_return_epc(regs);
-        *regptr = value;
         break;
 #endif /* CONFIG_64BIT */
 
@@ -324,9 +322,7 @@ static void emulate_load_store_insn(struct pt_regs 
*regs,
             : "r" (addr), "i" (-EFAULT));
         if (res)
             goto fault;
-        *regptr = &regs->regs[insn.i_format.rt];
         compute_return_epc(regs);
-        *regptr = value;
         break;
 #endif /* CONFIG_64BIT */
 
