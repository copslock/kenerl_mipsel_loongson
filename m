Received:  by oss.sgi.com id <S305204AbQD3Mi0>;
	Sun, 30 Apr 2000 05:38:26 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:4188 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQD3MiH>;
	Sun, 30 Apr 2000 05:38:07 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id FAA00224; Sun, 30 Apr 2000 05:33:20 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id FAA20928; Sun, 30 Apr 2000 05:36:21 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA51517
	for linux-list;
	Sun, 30 Apr 2000 05:25:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA27100
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 30 Apr 2000 05:25:19 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA01710
	for <linux@cthulhu.engr.sgi.com>; Sun, 30 Apr 2000 05:25:17 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-14.uni-koblenz.de (cacc-14.uni-koblenz.de [141.26.131.14])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id OAA12800;
	Sun, 30 Apr 2000 14:25:13 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1405937AbQD3MYm>;
	Sun, 30 Apr 2000 14:24:42 +0200
Date:   Sun, 30 Apr 2000 14:24:42 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Dominic Sweetman <dom@algor.co.uk>
Cc:     nick@ns.snowman.net, Florian Lohoff <flo@rfc822.org>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: VC exceptions
Message-ID: <20000430142442.A10896@uni-koblenz.de>
References: <20000429071807.A491@uni-koblenz.de> <Pine.LNX.4.05.10004291833360.3830-100000@ns.snowman.net> <20000430004557.A1972@uni-koblenz.de> <200004301056.LAA12672@mudchute.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200004301056.LAA12672@mudchute.algor.co.uk>; from dom@algor.co.uk on Sun, Apr 30, 2000 at 11:56:03AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sun, Apr 30, 2000 at 11:56:03AM +0100, Dominic Sweetman wrote:

> So the R10000 was desperately complicated, and the RM7000 is simple
> but has onchip secondary cache.  At the same clock rate, the R10000 is
> going to be much faster (and use much more power, and cost much more
> to build into a system).  I doubt if even the just-announced 400Mhz
> RM7000 is really faster overall than a 180MHz R10000 - but Ralf might
> have access to some measurements.

I don't have hard numbers nor hardware, so I had to rely on the `hard facts'
that others had given to me.

In any case, the race stays unequal since the newest child of the R10000
family, the 400MHz R12000, will also enter the game soon if it isn't even
already shipping.

  Ralf
