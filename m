Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA17685
	for <pstadt@stud.fh-heilbronn.de>; Sun, 8 Aug 1999 00:31:13 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA01649; Sat, 7 Aug 1999 15:15:51 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA91533
	for linux-list;
	Sat, 7 Aug 1999 15:02:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA85800
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 7 Aug 1999 15:02:11 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA02206
	for <linux@cthulhu.engr.sgi.com>; Sat, 7 Aug 1999 15:02:09 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-24.uni-koblenz.de [141.26.131.24])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA27519
	for <linux@cthulhu.engr.sgi.com>; Sun, 8 Aug 1999 00:02:06 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id XAA03620;
	Sat, 7 Aug 1999 23:59:29 +0200
Date: Sat, 7 Aug 1999 23:59:29 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "Andrew R. Baker" <andrewb@uab.edu>
Cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: problems compiling 2.3 cvs kernel
Message-ID: <19990807235929.A3565@uni-koblenz.de>
References: <Pine.LNX.3.96.990806174135.10369B-100000@mdk187.tucc.uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.3.96.990806174135.10369B-100000@mdk187.tucc.uab.edu>; from Andrew R. Baker on Fri, Aug 06, 1999 at 05:47:51PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Aug 06, 1999 at 05:47:51PM -0500, Andrew R. Baker wrote:

> I am getting consistent signal 11 errors while trying to compile the 2.3
> tree from the CVS archives with gcc-2.7.2.  They always occur on the same
> files and in both my normal cross-compile enviroment and in the native
> Linux-MIPS enviroment.

cc1 of gcc 2.7.x is known to die on a number of C constructs like

bfd_link_section_stabs (void)
{
	unsigned long long i, count;

	for (i = 0; i < count; i++);
}

when optimizing.  This a compiler that was written even before the
invention of slived bread, so I don't care :-)

> egcs seems to work fine in the native enviroment.
> Do I just need to upgrade my cross-compiler setup?  Is there a tarball I
> can install instead of fussing with the RPMs on the web site?

There are binary crosscompiler rpms and native compilers for a number of
hosts online.  If you don't like using rpm, then you can still use rpm2cpio
and cpio to just extract the files from an rpm archive for your favourite
architecture.  Right now we've got binaries for Linux/{Alpha,sparc,i386,ppc}
online and I'll upload IRIX binaries rsn.  I just want to lobotomize
binutils before that :-)

  Ralf
