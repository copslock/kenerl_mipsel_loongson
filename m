Received:  by oss.sgi.com id <S42306AbQFTVA7>;
	Tue, 20 Jun 2000 14:00:59 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:35878 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42305AbQFTVAl>;
	Tue, 20 Jun 2000 14:00:41 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA14954
	for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 13:55:44 -0700 (PDT)
	mail_from (dom@mudchute.algor.co.uk)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA64154
	for <linux@engr.sgi.com>;
	Tue, 20 Jun 2000 13:59:59 -0700 (PDT)
	mail_from (dom@mudchute.algor.co.uk)
Received: from kenton.algor.co.uk (kenton.algor.co.uk [193.117.190.25]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA08867
	for <linux@engr.sgi.com>; Tue, 20 Jun 2000 13:59:56 -0700 (PDT)
	mail_from (dom@mudchute.algor.co.uk)
Received: from mudchute.algor.co.uk (dom@mudchute.algor.co.uk [193.117.190.19])
	by kenton.algor.co.uk (8.8.8/8.8.8) with ESMTP id WAA03512;
	Tue, 20 Jun 2000 22:00:00 +0100 (GMT/BST)
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id VAA19304;
	Tue, 20 Jun 2000 21:59:32 +0100 (BST)
Date:   Tue, 20 Jun 2000 21:59:32 +0100 (BST)
Message-Id: <200006202059.VAA19304@mudchute.algor.co.uk>
From:   Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To:     Jun Sun <jsun@mvista.com>
Cc:     Dominic Sweetman <dom@algor.co.uk>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com, nigel@algor.co.uk
Subject: Re: R5000 support (specifically two-way set-associative cache...)
In-Reply-To: <394FBF91.76AE6FD0@mvista.com>
References: <394EA5A0.B882F66A@mvista.com>
	<200006200947.KAA08574@mudchute.algor.co.uk>
	<394FBAC6.3D29C4A7@mvista.com>
	<394FBF91.76AE6FD0@mvista.com>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Jun Sun (jsun@mvista.com) writes:

> I meant to talk about Vr5000 but I was looking at the Vr5432 manual!
> 1. both CPUs have two-way set-associative caches
> 2. Vr5432 uses vAddr:0 to select the way

The Vr5432 is indeed different, compelling you to be aware of the
number of sets.

> 3. I am not 100% sure about Vr5000.

It uses a high-order bit, just like R4600.

> > Can someone familiar with R4600 tell us more about how R4600 cache
> > is setup to hide two-wayness?  Thanks.

Fundamentally:

o "index" operations just go first through one set, then the other.
  So long as initialisation routines are applied to each possible
  index in turn, both sets get initialised.

o "hit" operations "just work".

So long as initialisation is done carefully (basic rule: perform one
stage to the whole cache before going on to the next), run-time cache
maintenance can and should be done with "hit" instructions, and you
don't need to worry whether the CPU is direct mapped, 2- or 4-way set
associative.

(it's all explained in my book, "See MIPS Run", of course...)

Even with the Vr5432 you only have to know the difference when first
setting up the CPU.

Dominic Sweetman
Algorithmics Ltd
dom@algor.co.uk
