Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA02985 for <linux-archive@neteng.engr.sgi.com>; Thu, 16 Jul 1998 07:32:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA36764
	for linux-list;
	Thu, 16 Jul 1998 07:31:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA40776
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 16 Jul 1998 07:31:36 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA06672
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Jul 1998 07:29:06 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id QAA24218;
	Thu, 16 Jul 1998 16:28:58 +0200 (MEST)
Received: by zaphod (SMI-8.6/KO-2.0)
	id QAA09600; Thu, 16 Jul 1998 16:28:52 +0200
Message-ID: <19980716162850.30690@uni-koblenz.de>
Date: Thu, 16 Jul 1998 16:28:50 +0200
From: ralf@uni-koblenz.de
To: Honza Pazdziora <adelton@informatics.muni.cz>
Cc: Alex deVries <adevries@engsoc.carleton.ca>, linux@cthulhu.engr.sgi.com
Subject: Re: The pre-release of Hard Hat Linux for SGI...
References: <Pine.LNX.3.95.980715180435.22020I-100000@lager.engsoc.carleton.ca> <199807161354.PAA09548@aisa.fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <199807161354.PAA09548@aisa.fi.muni.cz>; from Honza Pazdziora on Thu, Jul 16, 1998 at 03:54:50PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Jul 16, 1998 at 03:54:50PM +0200, Honza Pazdziora wrote:

> P.S.: I maybe did not stressed out that some of the packages failed
> _and_ some gave the following message -- I do not know which gave the
> message about ldconfig, but certainly not all that failed.
> 
> 		During the install of 230 packages there were
> > > about 20 messages
> > > 	ldconfig: Exception at [<88109534>] (8810960c)
> > 
> > _THAT_ worries me a lot.

That Exception message is just a debug message.  It means that the kernel
caught a user process passing a bad pointer argument.  This message
doesn't necessarily mean something fatal happend.

> ... and no, no exception, just some messages about some libraries
> that I decided are harmless. Anyway, after this, I was able to log in

Harmless -> symlink pointing to nonexisting files?

  Ralf
