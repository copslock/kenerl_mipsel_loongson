Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Nov 2002 12:54:54 +0100 (CET)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:56033 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1121742AbSKYLyx>; Mon, 25 Nov 2002 12:54:53 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA09706;
	Mon, 25 Nov 2002 12:55:12 +0100 (MET)
Date: Mon, 25 Nov 2002 12:55:11 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: atul srivastava <atulsrivastava9@rediffmail.com>,
	linux-mips@linux-mips.org
Subject: Re: watch exception only for kseg0 addresses..?
In-Reply-To: <20021125102458.B22046@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1021125123643.8769B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 25 Nov 2002, Ralf Baechle wrote:

> The whole watch stuff in the the kernel is pretty much an ad-hoc API
> which I did create to debug a stack overflow.  I'm sure if you're
> going to use it you'll find problems.  For userspace for example you'd
> have to switch the watch register when switching the MMU context so
> each process gets it's own virtual watch register.  Beyond that there
> are at least two different formats of watch registers implemented in
> actual silicon, the original R4000-style and the MIPS32/MIPS64 style
> watch registers and the kernel's watch code only know the R4000 style
> one.  So check your CPU's manual ...

 I think the best use of the watch exception would be making it available
to userland via PTRACE_PEEKUSR and PTRACE_POKEUSR for hardware watchpoint
support (e.g. for gdb).  Hardware support is absolutely necessary for
watching read accesses and much beneficial for write ones (otherwise gdb
single-steps code which sucks performace-wise).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
