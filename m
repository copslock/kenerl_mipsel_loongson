Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id KAA116212 for <linux-archive@neteng.engr.sgi.com>; Thu, 23 Oct 1997 10:59:46 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA21964 for linux-list; Thu, 23 Oct 1997 10:57:50 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA21951; Thu, 23 Oct 1997 10:57:48 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA28402; Thu, 23 Oct 1997 10:57:46 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from ozzy.uni-koblenz.de (946@ozzy.uni-koblenz.de [141.26.5.8]) by informatik.uni-koblenz.de (8.8.7/8.6.9) with ESMTP id TAA25739; Thu, 23 Oct 1997 19:57:44 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199710231757.TAA25739@informatik.uni-koblenz.de>
Received: by ozzy.uni-koblenz.de (8.8.5/KO-2.0)
	id TAA03736; Thu, 23 Oct 1997 19:56:06 +0200
Subject: Re: Magnum 4000 caches
To: wje@fir.engr.sgi.com (William J. Earl)
Date: Thu, 23 Oct 1997 19:56:06 +0200 (MEST)
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-Reply-To: <199710231721.KAA10794@fir.engr.sgi.com> from "William J. Earl" at Oct 23, 97 10:21:41 am
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>      It turned out that, at least for some workloads, the 4000PC
> worked better that way.  (If I remember correctly, a 32-byte linesize
> is better for the icache, since a 4-instruction basic block is
> unusual.)  However, not all boxes use the same linesize values,
> because there were hardware bugs with at least some of the memory
> controllers which were affected by the choice of linesize.  I don't
> remember the details anymore, although I might find them in my mail
> archivies.  I have a 4000PC system (32-byte I, 16-byte D, MCT version 3)
> and two 4000SC systems (16-byte I, D, and S, MCT version 2) still online.
> I think that MCT version 2 would not support a 32-byte line.

So as the easy solution, as I understand things we should be safe by
just leaving the linesize as the firmware chooses them for us Magnums?  
I actually intended to experiment with the linesize on R4k but as
things look now this isn't a good thing.

Btw, seems we'll get an interesting new target for Linux.  It's currently
ftp.uni-erlangen.de and one of the admins who might do the job, a Linux/68k
hacker told me it's a 3 x R6000 box with 256mb of RAM currently running
ES/IX something like that ...

  Ralf
