Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARENfs17763
	for linux-mips-outgoing; Tue, 27 Nov 2001 06:23:41 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAREKYo17740;
	Tue, 27 Nov 2001 06:20:37 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA03242;
	Tue, 27 Nov 2001 14:20:06 +0100 (MET)
Date: Tue, 27 Nov 2001 14:20:05 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux: Report the faulting FPU instruction
In-Reply-To: <20011127121337.E2525@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1011127141600.440E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 27 Nov 2001, Ralf Baechle wrote:

> The problem you found in the FPU emulator is a fairly generic one.  We
> got other exception handlers which in error case will still skip over
> the instruction.  What also isn't handled properly is the case of sending
> a signal to the application.  In such a case sigreturn() should do the
> the compute_return_epc() thing ...

 Well, with break/trap 6/7 I have already noticed exception handlers tend
to call compute_return_epc() unnecessarily.  I shall be cleaning the code
gradually as time passes by...

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
