Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 18:18:08 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:34000 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022997AbXG3RSG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jul 2007 18:18:06 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6UHI5rL029844;
	Mon, 30 Jul 2007 18:18:05 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6UHI4qW029843;
	Mon, 30 Jul 2007 18:18:04 +0100
Date:	Mon, 30 Jul 2007 18:18:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Songmao Tian <tiansm@lemote.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: A blind patch:)
Message-ID: <20070730171804.GB29600@linux-mips.org>
References: <46AE049C.6040500@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46AE049C.6040500@lemote.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 30, 2007 at 11:32:44PM +0800, Songmao Tian wrote:

> commit 5fabf601a53079c182d5c25f6e850d6a7bd48988 is broken. since the 
> regptr is disappeared in the signature of the function, I think the 
> regptr is useless.

Indeed, you found a bug but your fix wasn't right.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index bbf20ce..d34b1fb 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -281,9 +281,8 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 			: "r" (addr), "i" (-EFAULT));
 		if (res)
 			goto fault;
-		*regptr = &regs->regs[insn.i_format.rt];
 		compute_return_epc(regs);
-		*regptr = value;
+		regs->regs[insn.i_format.rt] = value;
 		break;
 #endif /* CONFIG_64BIT */
 
@@ -324,9 +323,8 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 			: "r" (addr), "i" (-EFAULT));
 		if (res)
 			goto fault;
-		*regptr = &regs->regs[insn.i_format.rt];
 		compute_return_epc(regs);
-		*regptr = value;
+		regs->regs[insn.i_format.rt] = value;
 		break;
 #endif /* CONFIG_64BIT */
 
