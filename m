Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g119ti127581
	for linux-mips-outgoing; Fri, 1 Feb 2002 01:55:44 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g119tYd27576
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 01:55:35 -0800
Received: from mudchute.algor.co.uk (dom@mudchute.algor.co.uk [62.254.210.251])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g118tEa10310;
	Fri, 1 Feb 2002 08:55:14 GMT
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id IAA00394;
	Fri, 1 Feb 2002 08:55:10 GMT
Date: Fri, 1 Feb 2002 08:55:10 GMT
Message-Id: <200202010855.IAA00394@mudchute.algor.co.uk>
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Jason Gunthorpe <jgg@debian.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: An mb() rework
In-Reply-To: <Pine.LNX.3.96.1020131180511.14195A-100000@wakko.deltatee.com>
References: <Pine.GSO.3.96.1020131215446.579H-100000@delta.ds2.pg.gda.pl>
	<Pine.LNX.3.96.1020131180511.14195A-100000@wakko.deltatee.com>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > > No, a sync will still empty the write buffer. It may halt the
> > >pipeline for many (~80 perhaps) cycles while posted write data is
> > >dumped to the system controller.
> > 
> > Then it's an implementation bug.  For a CPU in the UP mode "sync"
> > is only defined to prevent write and read reordering -- there is
> > nothing about flushing.
> 
> Did some more research + phoning.. RM7K is definately documented to dump
> the write buffer on 'sync'.

The RM7000 sync does more than is required by the ISA.  However, since
the write-buffer is not part of the architecture, this is not a bug.
Though it might well be held to be undesirable.

And there has to be *some* way to force the write buffer to empty, and
this is cheaper than the standard alternative of an uncached read.

I believe the RM7000 write buffer can hold one pending cache-line
writeback or up to four uncached writes.  Emptying the write buffer
can only occupy more than a handful of cycles when the system
controller is already backed-up with pending writes; under those
circumstances the system was probably about to stall anyway, so I
wouldn't be too worried about the performance implications of a
'sync'.

> The RM7K guide even has an example (7.8.5)
> where it implies that sync also forces a write back of any dirty cache
> lines - gah! (Hard to belive though..)

There's not a word of truth in that (there just aren't the right wires
in the hardware to make that possible).  But I think what it means is
that it stops the CPU until a pending cache line write back is
complete.  It's hard to see why that would be useful, but since it
uses the same write buffer hardware it's easy to see why it would happen.

Of course (as everyone has been piling in and pointing out) the real
problems are:

1. The MIPS people who invented 'sync' had a much more sophisticated
   understanding of read/write behaviour than is common in those 
   who support, document and program uniprocessor "embedded" CPUs; so
   there's lots of scope for misunderstanding 'sync'.

2. When write-posting bites you, it's usually not in the CPU but
   somewhere further down the system.  You should never believe a write
   has actually arrived at the device you sent it to, until you see
   the device itself change state...

And a plea: the word "flush" in Linux is already abused for caches
(where it means invalidate, write back, or possibly both).  That's
enough trouble: if you also "flush" write buffers, your confusion will
be complete.  Maybe we should leave "flush" to plumbers and use more
precise terminology for computers...

-- 
Dominic Sweetman, 
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / direct: +44 1223 706205
http://www.algor.co.uk
