Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g54EVunC027808
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 4 Jun 2002 07:31:56 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g54EVuSt027807
	for linux-mips-outgoing; Tue, 4 Jun 2002 07:31:56 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g54EVmnC027795;
	Tue, 4 Jun 2002 07:31:49 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA18216;
	Tue, 4 Jun 2002 16:34:06 +0200 (MET DST)
Date: Tue, 4 Jun 2002 16:34:06 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: "Gleb O. Raiko" <raiko@niisi.msk.ru>, Jun Sun <jsun@mvista.com>,
   Alexandr Andreev <andreev@niisi.msk.ru>, linux-mips@oss.sgi.com
Subject: Re: 3 questions about linux-2.4.18 and R3000
In-Reply-To: <20020603154011.A11393@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020604162617.17556B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 3 Jun 2002, Ralf Baechle wrote:

> >  For MIPS64 they definitely do not work, OTOH, including the N32 ABI.
> 
> Are they good enough to build 64-bit kernels?

 Not yet.  For N32 gas complains about 64-bit immediates and fails.  For
64 there are a few problems I'm currently resolving, but the kernel links.
As N32 is low priority for me, I'll get 64 fixed first, at least to the
point non-PIC static executables such as Linux work.  PIC and dynamic
linking are next on my to-do list. 

 I'm working on 2.12.90, though, as the MIPS/ELF backend was positively
but extensively restructured, so the ultimate target is 2.13.  For plain
MIPS 2.12.90 seem OK. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
