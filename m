Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA24366 for <linux-archive@neteng.engr.sgi.com>; Thu, 24 Sep 1998 09:28:15 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA81532
	for linux-list;
	Thu, 24 Sep 1998 09:27:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA90444
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 24 Sep 1998 09:27:19 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA01190
	for <linux@cthulhu.engr.sgi.com>; Thu, 24 Sep 1998 09:27:18 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id MAA26303;
	Thu, 24 Sep 1998 12:31:11 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 24 Sep 1998 12:31:11 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: VINO
In-Reply-To: <19980924011207.09418@alpha.franken.de>
Message-ID: <Pine.LNX.3.96.980924123001.20033E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, 24 Sep 1998, Thomas Bogendoerfer wrote:
> Is it possible to do VINO DMA directly to the newport ?
> 

God knows I'm not an authority on this, but I believe the answer to this
is no; you need to do DMA from VINO to memory, then memory to XMAP9
through REX3.

Please tell me if I'm wrong.

- Alex
