Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5PEqgnC022661
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 07:52:42 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5PEqfs9022660
	for linux-mips-outgoing; Tue, 25 Jun 2002 07:52:41 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5PEqVnC022656;
	Tue, 25 Jun 2002 07:52:32 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with ESMTP id QAA04342;
	Tue, 25 Jun 2002 16:56:16 +0200 (MET DST)
Date: Tue, 25 Jun 2002 16:56:12 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: LTP testing
In-Reply-To: <3D187BC8.17765700@mips.com>
Message-ID: <Pine.GSO.3.96.1020625162041.29623I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
X-MIME-Autoconverted: from 8bit to quoted-printable by delta.ds2.pg.gda.pl id QAA04342
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g5PEqXnC022657
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 25 Jun 2002, Carsten Langgaard wrote:

> > Linux platforms do it this way, e.g. Alpha and IA-64.  A SIGSEGV is a
> > valid response for an invalid address.  Remember you test pipe(3) and not
> > pipe(2).
> 
> I'm not sure that you mean by pipe(2) and pipe(3), but according to my man
> page, pipe should return with EFAULT in this case.

 pipe(2) is a syscall, while pipe(3) is a library call (see `man 2 intro'
and `man 3 intro', respectively).  You rarely access syscalls directly --
the system library usually does this for you.  Depending on a system
certain library functions may be trivial syscall wrappers, invoke a number
of syscalls (see e.g. the stat() family) or be implemented entirely in the
userland. 

> ERRORS
>        EMFILE Too  many  file  descriptors are in use by the pro­
>               cess.
>        ENFILE The system file table is full.
>        EFAULT filedes is not valid.

 Yep, this denotes such an error is possible and under what conditions.  I
don't think it actually mandates it, at least it's not expressed
explicitly.  Anyway, it's valid for i386 and possibly nothing else.  Look
at the system version it refers to -- my version is: "Linux 0.99.11 23
July 1993".

 A brief search of the web for "EFAULT pipe" reveals confirms others agree
with me -- the error is not mandatory (the EFAULT vs SIGSEGV issue was
discussed a few times at least in various contexts -- go search the web). 

 I believe a SIGSEGV is saner, too -- this way it's harder for an error
resulting from passing an invalid pointer to remain unnoticed (consider
some code that passes a pointer to read-only memory and fails to check a
result of pipe()).

 If still in doubt, you may try to discuss the LTP result at
<linux-kernel@vger.kernel.org>.  I don't think anybody wants to rewrite
pipe(2) for all the platforms that handle it our way. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
