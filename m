Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id BAA13662
	for <pstadt@stud.fh-heilbronn.de>; Sun, 1 Aug 1999 01:51:41 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA08439; Sat, 31 Jul 1999 16:47:51 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA64699
	for linux-list;
	Sat, 31 Jul 1999 16:44:38 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA50232
	for <linux@engr.sgi.com>;
	Sat, 31 Jul 1999 16:44:36 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA05246
	for <linux@engr.sgi.com>; Sat, 31 Jul 1999 16:44:34 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-10.uni-koblenz.de [141.26.131.10])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA18436
	for <linux@engr.sgi.com>; Sun, 1 Aug 1999 01:44:32 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id BAA20674;
	Sun, 1 Aug 1999 01:44:11 +0200
Date: Sun, 1 Aug 1999 01:44:11 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Mark Mitchell <mark@codesourcery.com>
Cc: ralf@gnu.org, binutils@sourceware.cygnus.com, thockin@cobaltnet.com,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: MIPS/ELF linker
Message-ID: <19990801014411.V12249@uni-koblenz.de>
References: <19990731233150.Q12249@uni-koblenz.de> <19990731152842N.mitchell@codesourcery.com> <19990801012203.U12249@uni-koblenz.de> <19990731164237C.mitchell@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <19990731164237C.mitchell@codesourcery.com>; from Mark Mitchell on Sat, Jul 31, 1999 at 04:42:37PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Jul 31, 1999 at 04:42:37PM -0700, Mark Mitchell wrote:

> Ralf --
> 
>   Thanks for the tarball.  I'll not be able to look at this until
> tomorrow, but I will do so then.

Ok, I'm looking into things in parallel if I find the time.  I'll also
try to rebuild GNU libc for MIPS.  That has historically proven to be
a bone breaker for ld.  The last time I tried a few weeks ago I got
~500 assertion messages from ld just alone for the libc final link ...
Will let you know how things go.

  Ralf
