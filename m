Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA59110 for <linux-archive@neteng.engr.sgi.com>; Wed, 1 Jul 1998 08:55:59 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA31184
	for linux-list;
	Wed, 1 Jul 1998 08:54:49 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA08209
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 1 Jul 1998 08:54:47 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA09706
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Jul 1998 08:54:42 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id RAA23520;
	Wed, 1 Jul 1998 17:54:29 +0200 (MEST)
Received: by thoma (SMI-8.6/KO-2.0)
	id RAA15362; Wed, 1 Jul 1998 17:54:26 +0200
Message-ID: <19980701175425.34606@uni-koblenz.de>
Date: Wed, 1 Jul 1998 17:54:25 +0200
From: ralf@uni-koblenz.de
To: Mike Shaver <shaver@netscape.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: mozilla on the Indy
References: <359A447B.2D25377D@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
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

Threads are broken, the attempt to create one will crash the process.
On the to do list of things to be finished for Alex tomorrow.

  ralf
