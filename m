Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA00257
	for <pstadt@stud.fh-heilbronn.de>; Wed, 4 Aug 1999 00:12:32 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA16884; Tue, 3 Aug 1999 15:02:53 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA38234
	for linux-list;
	Tue, 3 Aug 1999 14:56:57 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA33321
	for <linux@engr.sgi.com>;
	Tue, 3 Aug 1999 14:56:52 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA05754
	for <linux@engr.sgi.com>; Tue, 3 Aug 1999 14:56:50 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-9.uni-koblenz.de [141.26.131.9])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA03151
	for <linux@engr.sgi.com>; Tue, 3 Aug 1999 23:56:43 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id XAA07095;
	Tue, 3 Aug 1999 23:54:00 +0200
Date: Tue, 3 Aug 1999 23:54:00 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Mark Mitchell <mark@codesourcery.com>
Cc: binutils@sourceware.cygnus.com, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: PATCH for elf32-mips.c
Message-ID: <19990803235400.A6637@uni-koblenz.de>
References: <19990802231041C.mitchell@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <19990802231041C.mitchell@codesourcery.com>; from Mark Mitchell on Mon, Aug 02, 1999 at 11:10:41PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Aug 02, 1999 at 11:10:41PM -0700, Mark Mitchell wrote:

> These patches (checked in) should fix another couple of thinkos
> discovered by Ralf's mips-linux-gnu testing.  Ralf, just out of
> curiousity, do you think that Linux/GNU will move to the N32/64-bit
> ABIs at some point?  Or do you plan on sticking with the IRIX5-like
> ABI for the forseeable future?

My binutils work is part of Linux/MIPS64, at first for the Indy, then
for the Origin 200 and other 64-bit MIPS based systems.  It'll be
quite a while until we'll also have a 64-bit userland, but that's also
one of the aims.

  Ralf
