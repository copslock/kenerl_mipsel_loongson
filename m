Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2003 11:18:03 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:56517 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225421AbTIRKSB>; Thu, 18 Sep 2003 11:18:01 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA15981;
	Thu, 18 Sep 2003 12:17:54 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Thu, 18 Sep 2003 12:17:54 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc: linux-mips@linux-mips.org
Subject: Re: mips64 cpu-probe.c compile failure
In-Reply-To: <20030918.180536.08320519.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.GSO.3.96.1030918121138.15508B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 18 Sep 2003, Atsushi Nemoto wrote:

> macro> Log message:
> macro> 	Fix indeterminism in the multiply/shift erratum detection leading
> macro> 	to false negatives.  Plus a few minor comment updates for clarity.
> 
> gcc 3.3.1 can not compile current (2.4) arch/mips64/kernel/cpu-probe.c.
> 
> cpu-probe.c:118: warning: asm operand 0 probably doesn't match constraints
> cpu-probe.c:118: warning: asm operand 1 probably doesn't match constraints
> ...
> cpu-probe.c: In function `check_mult_sh':
> cpu-probe.c:118: error: impossible constraint in `asm'

 Hmm, perhaps 3.3.1 fails to inline the functions...  It works just fine
with 2.95.4.

> The code is:
> 
> static inline void align_mod(int align, int mod)
> {
> 	asm volatile(
> 		".set	push\n\t"
> 		".set	noreorder\n\t"
> 		".balign %0\n\t"
> 		".rept	%1\n\t"
> 		"nop\n\t"
> 		".endr\n\t"
> 		".set	pop"
> 		:
> 		: "i" (align), "i" (mod));
> }
> 
> The align_mod() and mult_sh_align_mod() should be written as macro?

 I wanted to avoid that as the resulting code would be ugly.  I guess
there is no other choice, although I think that's a bug in gcc.

 Can you quote the exact command line used for building the file?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
