Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA258399 for <linux-archive@neteng.engr.sgi.com>; Thu, 7 May 1998 12:55:55 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA21722908
	for linux-list;
	Thu, 7 May 1998 12:54:14 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA20678230
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 7 May 1998 12:54:12 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id MAA24718
	for <linux@cthulhu.engr.sgi.com>; Thu, 7 May 1998 12:54:11 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id PAA31498;
	Thu, 7 May 1998 15:48:52 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 7 May 1998 15:48:52 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: linux@cthulhu.engr.sgi.com
Subject: Re: rpm builders, README
In-Reply-To: <19980507140821.18614@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980507154752.20653M-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 7 May 1998 ralf@uni-koblenz.de wrote:
> I fixed a long standing bug in the ELF loader which was crashing certain
> types of executables.  Ldd is one of them.  This causes binary rpm
> packages to be built without library dependencies.  If you've published
> binary rpms, please rebuild them running 2.1.99.

FWIW, I will _NOT_ be doing a report of the RPMs until I get RH 5.1 source
RPMs.

- Alex
