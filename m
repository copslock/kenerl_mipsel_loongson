Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA60290 for <linux-archive@neteng.engr.sgi.com>; Wed, 4 Mar 1998 15:30:35 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id PAA702999 for linux-list; Wed, 4 Mar 1998 15:30:03 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA699792 for <linux@cthulhu.engr.sgi.com>; Wed, 4 Mar 1998 15:30:01 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id PAA25294
	for <linux@cthulhu.engr.sgi.com>; Wed, 4 Mar 1998 15:29:59 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-22.uni-koblenz.de [141.26.249.22])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id AAA09216
	for <linux@cthulhu.engr.sgi.com>; Thu, 5 Mar 1998 00:29:57 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id AAA17023;
	Thu, 5 Mar 1998 00:26:31 +0100
Message-ID: <19980305002630.53001@uni-koblenz.de>
Date: Thu, 5 Mar 1998 00:26:30 +0100
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: CVS notifications
References: <199803041737.LAA28458@athena.nuclecu.unam.mx> <Pine.LNX.3.95.980304145038.30256A-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980304145038.30256A-100000@lager.engsoc.carleton.ca>; from Alex deVries on Wed, Mar 04, 1998 at 02:51:37PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Mar 04, 1998 at 02:51:37PM -0500, Alex deVries wrote:

> On Wed, 4 Mar 1998, Miguel de Icaza wrote:
> > 
> > > Did anybody change the mail setup on linus?  I don't receive any mail
> > > notifications for my CVS commits anymore.
> > Neither do I.
> 
> I got 1 of them, which makes me worry that I missed a couple of hundred.
> Is there a simple log of them available?

The mails themselfes are unfortunately not being archivived; It's easy
to implement that, so I'm going to do that.

You however can still check the servers $CVSROOT/CVSROOT/history file and
the messages archives within each RCS file using the ``cvs log ...''
command.

  Ralf
