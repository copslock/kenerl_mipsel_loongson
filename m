Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA99434 for <linux-archive@neteng.engr.sgi.com>; Sat, 18 Jul 1998 03:52:43 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA39288
	for linux-list;
	Sat, 18 Jul 1998 03:51:57 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA44108;
	Sat, 18 Jul 1998 03:51:21 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA11480; Sat, 18 Jul 1998 03:51:05 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-01.uni-koblenz.de [141.26.249.1])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id MAA18045;
	Sat, 18 Jul 1998 12:50:58 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id MAA02961;
	Sat, 18 Jul 1998 12:47:54 +0200
Message-ID: <19980718124754.C2575@uni-koblenz.de>
Date: Sat, 18 Jul 1998 12:47:54 +0200
To: Greg Chesson <greg@xtp.engr.sgi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: wje@fir.engr.sgi.com, adevries@engsoc.carleton.ca, anubis@BanjaLuka.NET,
        linux@cthulhu.engr.sgi.com
Subject: Re: What about...
References: <9807171047.ZM18720@xtp.engr.sgi.com> <m0yxF1A-000aOoC@the-village.bc.nu> <19980718033759.C378@uni-koblenz.de> <9807171858.ZM19563@xtp.engr.sgi.com> <19980718044403.F378@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980718044403.F378@uni-koblenz.de>; from ralf@uni-koblenz.de on Sat, Jul 18, 1998 at 04:44:03AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Jul 18, 1998 at 04:44:03AM +0200, ralf@uni-koblenz.de wrote:

> On Fri, Jul 17, 1998 at 06:58:07PM -0700, Greg Chesson wrote:

> > I think you'd want to extend the design limit (XKSEG0) beyond 1 TB
> > to handle the next rev of silicon.  I'd suggest 64 TB (48 bits) as
> > the appropriate goal.
> 
> As far as the maximum amount of RAM goes, no problem.  The only assumption
> which I make is that the entire available memory is visible in XKSEG0,
> whatever it's size is.  That means the actual design limit is the maximum
> possible size of XKSEG0 for the MIPS 64bit architecture which is 2^62 bytes.

Ooops, the real limit is of course how much memory can be presented in XKPHYS
which is a bit less, just 2^58 bytes or 4 exabytes.  XKSEG or XKSSEG would
be used for kernel virtual memory which usually isn't used very much under
Linux - it's virtual, but not swappable.

  Ralf
