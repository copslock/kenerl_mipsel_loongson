Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA53139 for <linux-archive@neteng.engr.sgi.com>; Wed, 23 Sep 1998 17:01:21 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA03805
	for linux-list;
	Wed, 23 Sep 1998 17:00:34 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA48854
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 23 Sep 1998 17:00:32 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA02300
	for <linux@cthulhu.engr.sgi.com>; Wed, 23 Sep 1998 17:00:29 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-19.uni-koblenz.de [141.26.249.19])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA02132
	for <linux@cthulhu.engr.sgi.com>; Thu, 24 Sep 1998 02:00:28 +0200 (MET DST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA03417;
	Thu, 24 Sep 1998 01:59:38 +0200
Message-ID: <19980924015938.K2843@uni-koblenz.de>
Date: Thu, 24 Sep 1998 01:59:38 +0200
From: ralf@uni-koblenz.de
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Alex deVries <adevries@engsoc.carleton.ca>
Cc: Richard Hartensveld <richardh@infopact.nl>, Rob Lembree <lembree@sgi.com>,
        linux@cthulhu.engr.sgi.com
Subject: Re: challenge s boots linux
References: <36081982.8D3B6975@infopact.nl> <Pine.LNX.3.96.980922201845.10292B-100000@lager.engsoc.carleton.ca> <19980923212241.01963@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980923212241.01963@alpha.franken.de>; from Thomas Bogendoerfer on Wed, Sep 23, 1998 at 09:22:41PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Sep 23, 1998 at 09:22:41PM +0200, Thomas Bogendoerfer wrote:

> On Tue, Sep 22, 1998 at 08:24:20PM -0400, Alex deVries wrote:
> > 	First, I wonder how much of the kernel will actually work on the
> > Challenge S; I'm told there are SCSI controller differences.
> 
> looking linus.linux.sgi.com, which is AFAIK a Challenge S, it seems the
> Challenge has a wd33c93 and a wd33c95. The wd33c93 is what we already support.
> As long as the harddisk are attached to it, it should work. The wd33c95
> is a rather strange chip, and from the datasheet I have here, it looks like
> a lot of work to write a driver for it, because besides the kernel code,
> you have to write sequence code for the chip, too.

Did I missunderstand the 95's documentation - I thought we can abuse the
95 as a 93, thereby saving alot of driver work for now?

  Ralf
