Received:  by oss.sgi.com id <S42303AbQFTJsp>;
	Tue, 20 Jun 2000 02:48:45 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:17001 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42229AbQFTJsL>;
	Tue, 20 Jun 2000 02:48:11 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id CAA23783
	for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 02:43:13 -0700 (PDT)
	mail_from (dom@mudchute.algor.co.uk)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA90317
	for <linux@engr.sgi.com>;
	Tue, 20 Jun 2000 02:47:34 -0700 (PDT)
	mail_from (dom@mudchute.algor.co.uk)
Received: from kenton.algor.co.uk (kenton.algor.co.uk [193.117.190.25]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA00113
	for <linux@engr.sgi.com>; Tue, 20 Jun 2000 02:47:33 -0700 (PDT)
	mail_from (dom@mudchute.algor.co.uk)
Received: from mudchute.algor.co.uk (dom@mudchute.algor.co.uk [193.117.190.19])
	by kenton.algor.co.uk (8.8.8/8.8.8) with ESMTP id KAA00421;
	Tue, 20 Jun 2000 10:47:42 +0100 (GMT/BST)
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id KAA08574;
	Tue, 20 Jun 2000 10:47:42 +0100 (BST)
Date:   Tue, 20 Jun 2000 10:47:42 +0100 (BST)
Message-Id: <200006200947.KAA08574@mudchute.algor.co.uk>
From:   Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com, nigel@algor.co.uk
Subject: Re: R5000 support (specifically two-way set-associative cache...)
In-Reply-To: <394EA5A0.B882F66A@mvista.com>
References: <394EA5A0.B882F66A@mvista.com>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Jun Sun (jsun@mvista.com) writes:

> 2. Specifically, NEC Vr5000 has two-way set-associative cache.  I
> browsed through the cache code, and got concerned that I don't see any
> code that seems to take care of that.  Do I miss something?

The two-way cache on the R5000 (and its R4600 parent) is implemented
so that the cache operations used during running don't have to know
about the cache organisation.  Even initialisation of an R5000 cache
can be done by a piece of code which has no reference to two-wayness
and just works over R4x00/R5000 CPUs.

So this is not *necessarily* a problem.  

> 3. I understand Geert has a port to DDB5074 (with Vr5000 CPU).  Is this
> port completed (including all interrupts, PCI related stuff).  Is this
> port reliable?

A note on this and Geert's response: early Vrc5074 system controller
chips had lots of bugs, with some particularly nasty ones hitting PCI
transfers with external initiators (like the ethernet chip).  Anyone
pioneering Linux on it should check carefully with NEC about the
status of their particular revision.

Dominic Sweetman
Algorithmics Ltd
dom@algor.co.uk
