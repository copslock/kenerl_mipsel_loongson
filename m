Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2003 11:02:19 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:3600
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225208AbTHGKCR>; Thu, 7 Aug 2003 11:02:17 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 7 Aug 2003 10:02:15 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h77A23DV092873
	for <linux-mips@linux-mips.org>; Thu, 7 Aug 2003 19:02:03 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 07 Aug 2003 19:03:30 +0900 (JST)
Message-Id: <20030807.190330.26271096.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Subject: load/store address overflow on binutils 2.14
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I'm trying binutils 2.14 (and binutils 2.14.90.0.5).  These versions
can not compile this inctruction.

	lw	$2, 0x80000000

$ mips-linux-gcc -c foo.s
b.S: Assembler messages:
foo.S:1: Error: load/store address overflow (max 32 bits)

Using such an immediate address for load instructions is legal?  I
found the error message in tc-mips.c and it looks like something
related to 64bit ABIs, but I just want to compile 32bit (standalone)
program.

Is this code really needed for 32bit ABI?

binutils-2.14/gas/config/tc-mips.c:6297
 	  else if (offset_expr.X_op == O_constant
 		   && !HAVE_64BIT_ADDRESS_CONSTANTS
 		   && !IS_SEXT_32BIT_NUM (offset_expr.X_add_number))
 	    as_bad (_("load/store address overflow (max 32 bits)"));

---
Atsushi Nemoto
