Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57H2V728014
	for linux-mips-outgoing; Thu, 7 Jun 2001 10:02:31 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57H1ch27990
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 10:02:28 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA19078;
	Thu, 7 Jun 2001 19:03:08 +0200 (MET DST)
Date: Thu, 7 Jun 2001 19:03:08 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: linux-mips@oss.sgi.com
Subject: Re: New toolchain for Linux/mips
In-Reply-To: <20010607092827.A13198@lucon.org>
Message-ID: <Pine.GSO.3.96.1010607183225.16852A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 7 Jun 2001, H . J . Lu wrote:

> See my post on the binutils mailing list. I have reason to believe
> that it also misassembles the mips kernel with certain configuration.

 I've seen them.  Unfortunately I'm far from being a BFD expert, so it's
not immediately obvious to me whether your fixes are fine or not.  And I
can't dig into BFD at the moment.  Just make sure your changes adhere to
the ELF ABI, both the generic part and the MIPS supplement. 

 Also note I can only run-time test MIPS I, so if there is something wrong
with higher ISAs, I wouldn't even notice unless I happen to study a
dissassembly of affected code.

 The kernel crashes for me weirdly from time to time, indeed.  I have a
reproducible test case as well.  I don't speak up on details, though, as I
now have outdated binutils as well as the kernel I'm running is still
2.4.0-test12.  Any conclusions will be sent to the list once collected and
if relevant to current versions, of course. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
