Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA54366 for <linux-archive@neteng.engr.sgi.com>; Wed, 23 Sep 1998 17:22:05 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA80838
	for linux-list;
	Wed, 23 Sep 1998 17:21:33 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA62179
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 23 Sep 1998 17:21:32 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA03729
	for <linux@cthulhu.engr.sgi.com>; Wed, 23 Sep 1998 17:21:30 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-19.uni-koblenz.de [141.26.249.19])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA10225
	for <linux@cthulhu.engr.sgi.com>; Thu, 24 Sep 1998 02:21:29 +0200 (MET DST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id CAA03511;
	Thu, 24 Sep 1998 02:21:13 +0200
Message-ID: <19980924022113.N2843@uni-koblenz.de>
Date: Thu, 24 Sep 1998 02:21:13 +0200
From: ralf@uni-koblenz.de
To: Richard Hartensveld <richardh@infopact.nl>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Alex deVries <adevries@engsoc.carleton.ca>,
        Rob Lembree <lembree@sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: challenge s boots linux
References: <36081982.8D3B6975@infopact.nl> <Pine.LNX.3.96.980922201845.10292B-100000@lager.engsoc.carleton.ca> <19980923212241.01963@alpha.franken.de> <19980924015938.K2843@uni-koblenz.de> <36098F84.78D3764E@infopact.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <36098F84.78D3764E@infopact.nl>; from Richard Hartensveld on Thu, Sep 24, 1998 at 02:17:08AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Sep 24, 1998 at 02:17:08AM +0200, Richard Hartensveld wrote:

> > Did I missunderstand the 95's documentation - I thought we can abuse the
> > 95 as a 93, thereby saving alot of driver work for now?
> >
> 
> My experience is that the wd93 driver doens't work with the wd95 controller, maybe
> someone else hassuccessfully tried this?

It's not supposed to work without any changes at all.

  Ralf
