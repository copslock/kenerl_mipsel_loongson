Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA38930 for <linux-archive@neteng.engr.sgi.com>; Wed, 1 Jul 1998 19:13:00 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA30685
	for linux-list;
	Wed, 1 Jul 1998 19:12:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA13963
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 1 Jul 1998 19:12:20 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA07870
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Jul 1998 19:12:15 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-19.uni-koblenz.de [141.26.249.19])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id EAA01949
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Jul 1998 04:11:48 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id EAA07418;
	Thu, 2 Jul 1998 04:11:39 +0200
Message-ID: <19980702041137.I3255@uni-koblenz.de>
Date: Thu, 2 Jul 1998 04:11:37 +0200
To: Mike Shaver <shaver@netscape.com>, linux@cthulhu.engr.sgi.com
Subject: Re: mozilla on the Indy
References: <359A447B.2D25377D@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <359A447B.2D25377D@netscape.com>; from Mike Shaver on Wed, Jul 01, 1998 at 10:15:23AM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jul 01, 1998 at 10:15:23AM -0400, Mike Shaver wrote:

> It builds.
> It links (now that Alex made lesstif go, and I fixed up xpm).
> It crashes very early in the startup.
> 
> I think it's probably something in the NSPR thread initialization, but
> I'll have to build some test stuff to be sure.  The files I've changed
> that matter (not Makefiles and link lines, but actual source) are
> attached, and are the likely source of my problems.  Since the final
> mostly-static link takes about 40 minutes, experimentation is expensive.

Now that I've taken myself two minutes to browse your attached sources -
the patches to the NSPR thread routines look suspicious.  The are
playing games with the frame pointer which at least on the first look
don't make sense as gcc automatically enables -fomit-frame-pointer when
optimizing.

  Ralf
