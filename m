Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA25919 for <linux-archive@neteng.engr.sgi.com>; Wed, 15 Jul 1998 13:16:48 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA67151
	for linux-list;
	Wed, 15 Jul 1998 13:16:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA42879
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 15 Jul 1998 13:16:13 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA12215
	for <linux@cthulhu.engr.sgi.com>; Wed, 15 Jul 1998 13:16:12 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id QAA06977;
	Wed, 15 Jul 1998 16:15:41 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 15 Jul 1998 16:15:41 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Honza Pazdziora <adelton@informatics.muni.cz>
cc: ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com
Subject: Re: The pre-release of Hard Hat Linux for SGI...
In-Reply-To: <199807150900.LAA00705@aisa.fi.muni.cz>
Message-ID: <Pine.LNX.3.95.980715153943.22020E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Wed, 15 Jul 1998, Honza Pazdziora wrote:
> > Yup.  I updated the WWW and FTP site a bit.  It'd be really good if we
> OK, I've updated other links to manhattan/. Is the name Hard Hat 5.1
> official?

Yes.

> Yes, I'll try to create the page. Basically R4400, R4600, R5000,
> PC and SC, anyrate are OK? How about R4000? Other hardware: XGE, XZ
> (for consoles), 10BaseT, any reasonable SCSI? How about the Challenge S?

I think you need to list individual CPUs.

The SCSI on the Indy, yes, but the one on the Challenge S is different, I
thought.

> I have question about the ftp part (some of them based on the fact
> that we are little bit short of space on our mirror, but I'd like to
> mirror as much as possible). How about the RPM's in the
> /src/ftp/pub/redhat/old directory? Shouldn't the be in some
> subdirectory or gone? Also, I suggest renaming
> /src/ftp/pub/redhat/old/redhat-5.1 to something like
> redhat-5.1-alpha1 to be consistent with the name reflect the name of
> redhat-5.1alpha1.tgz.

I've cleaned that up a bit.

> Also, /src/ftp/pub/test/vml.tar.gz could be renamed to something like
> vmlinux-indy-2.1.99.tar.gz (is it 2.1.99?), and perhaps we could even
> put the kernels to some directory other than test (maybe kernel?) and
> also have a link there from software.html.

Done.

There is a kernel packaged as a binary in the RPMS...

> Anyway, our mirror already has 56 MB of that 270, let's hope it will
> go on ;-)

Let us know how that install goes...

- Alex
