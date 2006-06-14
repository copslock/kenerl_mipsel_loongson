Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2006 16:11:50 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:63475 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133532AbWFNPLl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Jun 2006 16:11:41 +0100
Received: from localhost (p4237-ipad30funabasi.chiba.ocn.ne.jp [221.184.79.237])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 21496B63B; Thu, 15 Jun 2006 00:11:36 +0900 (JST)
Date:	Thu, 15 Jun 2006 00:12:38 +0900 (JST)
Message-Id: <20060615.001238.65193088.anemo@mba.ocn.ne.jp>
To:	libc-ports@sourceware.org
Cc:	linux-mips@linux-mips.org
Subject: mips RDHWR instruction in glibc
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I got many "Reserved Instruction" exceptions with gcc 4.1 + glibc 2.4
userland.  They were due to RDHWR instruction to support TLS.

If a system call returned an error, glibc must save the result to
errno, which is thread-local, so RDHWR used.  I can understand this
scenario.  But it seems the RDHWR is often called on non-error cases.

For example, in the code below, RDHWR is placed _before_ checking the
error.  I suppose these instructions were reordered by gcc's
optimization, but the optimization would have large negative effect in
this case.

00566fc4 <_IO_file_read>:
  566fc4:	3c1c0016 	lui	gp,0x16
  566fc8:	279c87ac 	addiu	gp,gp,-30804
  566fcc:	0399e021 	addu	gp,gp,t9
  566fd0:	8c82003c 	lw	v0,60(a0)
  566fd4:	30420002 	andi	v0,v0,0x2
  566fd8:	14400003 	bnez	v0,566fe8 <_IO_file_read+0x24>
  566fdc:	8f999e9c 	lw	t9,-24932(gp)
  566fe0:	03200008 	jr	t9
  566fe4:	8c840038 	lw	a0,56(a0)
  566fe8:	8c840038 	lw	a0,56(a0)
  566fec:	24020fa3 	li	v0,4003
  566ff0:	0000000c 	syscall
  566ff4:	8f84a528 	lw	a0,-23256(gp)
  566ff8:	7c03e83b 	rdhwr	v1,$29
  566ffc:	00832021 	addu	a0,a0,v1
  567000:	14e00003 	bnez	a3,567010 <_IO_file_read+0x4c>
  567004:	00401821 	move	v1,v0
  567008:	03e00008 	jr	ra
  56700c:	00601021 	move	v0,v1
  567010:	2403ffff 	li	v1,-1
  567014:	1000fffc 	b	567008 <_IO_file_read+0x44>
  567018:	ac820000 	sw	v0,0(a0)

I'm not sure where to fix, but I doubt some inline asm code in glibc
lack "volatile" keyword.

Does anyone have a clue on this?
---
Atsushi Nemoto
