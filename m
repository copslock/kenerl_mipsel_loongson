Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA32112 for <linux-archive@neteng.engr.sgi.com>; Wed, 20 May 1998 09:17:19 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA31897
	for linux-list;
	Wed, 20 May 1998 09:16:40 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA40512
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 20 May 1998 09:16:36 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id JAA19758
	for <linux@cthulhu.engr.sgi.com>; Wed, 20 May 1998 09:16:30 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (root@pmport-07.uni-koblenz.de [141.26.249.7])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id SAA05693
	for <linux@cthulhu.engr.sgi.com>; Wed, 20 May 1998 18:16:22 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id QAA01127;
	Wed, 20 May 1998 16:37:47 +0200
Message-ID: <19980520163747.16398@uni-koblenz.de>
Date: Wed, 20 May 1998 16:37:47 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: The Forth may be with you ...
References: <19980520031738.58084@uni-koblenz.de> <Pine.LNX.3.95.980519224917.10762B-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980519224917.10762B-100000@lager.engsoc.carleton.ca>; from Alex deVries on Tue, May 19, 1998 at 10:52:08PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, May 19, 1998 at 10:52:08PM -0400, Alex deVries wrote:

> On Wed, 20 May 1998 ralf@uni-koblenz.de wrote:
> > for the fun of it and because I needed something that is programable,
> > interactive and small (92kb including the full dictionay) I ported pforth
> > v19 to run on the raw ARC firmware.  If anybody is interested in this
> > toy, tell me.  Even you even have an alibi application for this toy,
> > tell me asap :-)
> 
> Alright, I'll bite. 
> 
> Exactly what is this useful for? Could we use this as a LILO replacement
> for SGI/Linux?

Well, I was fed up of compiling test programs for the ARC firmware to play
with it, reboot crash the box and start all over again.

What could it be usefull for?  It's a full programming language including
development environment, so you can basically do anything with it.  If you
wish, knit your own OpenFirmware from it?  And yes, you could brew a LILO
equivalent from it.

The question is still if we need such a thing.  It's a overkill solution
with small resource footprint and absolute flexibility.  But then it might
be what makes it attractive.

  Ralf
