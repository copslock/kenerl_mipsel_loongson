Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id FAA21692 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Mar 1999 05:22:50 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA40483
	for linux-list;
	Wed, 17 Mar 1999 05:21:50 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA13003
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 17 Mar 1999 05:21:43 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA07120
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Mar 1999 05:21:12 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-30.uni-koblenz.de [141.26.131.30])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id OAA17753
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Mar 1999 14:20:52 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id LAA17524;
	Wed, 17 Mar 1999 11:42:32 +0100
Message-ID: <19990317114231.A17514@uni-koblenz.de>
Date: Wed, 17 Mar 1999 11:42:31 +0100
From: ralf@uni-koblenz.de
To: Richard van den Berg <R.vandenBerg@inter.nl.net>
Cc: Torbjorn Gannholm <torbjorn.gannholm@fra.se>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: FAQ
References: <19990316131653.E9924@uni-koblenz.de> <Pine.LNX.3.95.990316181042.421B-100000@whale.dutch.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <Pine.LNX.3.95.990316181042.421B-100000@whale.dutch.mountain>; from Richard van den Berg on Tue, Mar 16, 1999 at 06:16:22PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Mar 16, 1999 at 06:16:22PM +0100, Richard van den Berg wrote:

> An outdated linux-doc-sgml package has prevented me doing so, when updated
> I'll read it.

I'm using whatever RedHat 5.2's sgml-tools 1.0.7 but still observe some
problems.  There is for example a strange problem which prevents me from
generating GNU-info version.

> P.S. is cvs read-only possible at linus.linux.sgi.com? I've tried without
> succes getting a permission denied. Instead I've ftp'ed the cvs tree.

Yes, it's possible.  From the FAQ:

  4.2.  Anonymous CVS servers.

  For those who always want to stay on the bleeding edge and want to
  avoid having to download patch files or full tarballs we also have an
  anonymous CVS server.  Using CVS you can checkout the Linux/MIPS
  source tree with the following commands:

     cvs -d :pserver:cvs@linus.linux.sgi.com:/cvs login
     (Only needed the first time you use anonymous CVS, the password is "cvs")
     cvs -d :pserver:cvs@linus.linux.sgi.com:/cvs co <repository>

  where you insert linux, libc, or gdb for <repository>.

  Ralf
