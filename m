Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA06948; Fri, 13 Jun 1997 16:45:03 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA19956 for linux-list; Fri, 13 Jun 1997 16:44:38 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA18401; Fri, 13 Jun 1997 16:40:51 -0700
Received: from alles.intern.julia.de (loehnberg1.core.julia.de [194.221.49.2]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA20844; Fri, 13 Jun 1997 16:40:04 -0700
	env-from (ralf@Julia.DE)
Received: from kernel.panic.julia.de (kernel.panic.julia.de [194.221.49.153])
	by alles.intern.julia.de (8.8.5/8.8.5) with ESMTP id AAA15768;
	Sat, 14 Jun 1997 00:30:45 +0200
From: Ralf Baechle <ralf@Julia.DE>
Received: (from ralf@localhost)
          by kernel.panic.julia.de (8.8.4/8.8.4)
	  id BAA06504; Sat, 14 Jun 1997 01:29:47 +0200
Message-Id: <199706132329.BAA06504@kernel.panic.julia.de>
Subject: Re: Userland loader / run time loader
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Sat, 14 Jun 1997 01:29:47 +0200 (MET DST)
Cc: ralf@Julia.DE, lm@neteng.engr.sgi.com, ralf@mailhost.uni-koblenz.de,
        shaver@neon.ingenia.ca, linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.970613192104.15021E-100000@lager.engsoc.carleton.ca> from "Alex deVries" at Jun 13, 97 07:30:37 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> To begin with, excuse my noviceness in this all. Those are LSB binaries,
> whereas the sgi-linux box that I have access to (bogomips.ingenia.com)
> will only run MSB. 
> 
> As written on this list earlier, we don't have bi-endian support.  So,
> which one is it we're going to support to begin with? How is it that Ralf
> is able to execute LSB binaries?
>
> Am I missing something big?

{\grin[evil] Because I've got four types of MIPS boxes running Linux at
home and to two more I've got access.}

I think this also explains why I'm so interested in running biendianess -
I'm running out of diskspace ...

> Also, there was talk of getting merged up with kernel 2.1.4[234].  Any
> luck so far?

Yes.  I haven't merged all the files of my home CVS archive yet into
David's CVS archive from which he sends patches to Linus but the biggest
part is now in sync.

  Ralf
