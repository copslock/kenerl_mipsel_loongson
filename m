Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 16:24:35 +0200 (CEST)
Received: from alg133.algor.co.uk ([62.254.210.133]:18915 "EHLO
	oval.algor.co.uk") by linux-mips.org with ESMTP id <S1123397AbSJDOYe>;
	Fri, 4 Oct 2002 16:24:34 +0200
Received: from mudchute.algor.co.uk (pubfw.algor.co.uk [62.254.210.129])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g94EONr10421;
	Fri, 4 Oct 2002 15:24:23 +0100 (BST)
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id PAA12242;
	Fri, 4 Oct 2002 15:24:18 +0100 (BST)
Date: Fri, 4 Oct 2002 15:24:18 +0100 (BST)
Message-Id: <200210041424.PAA12242@mudchute.algor.co.uk>
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: "Dominic Sweetman" <dom@algor.co.uk>,
	"Carsten Langgaard" <carstenl@mips.com>,
	"Ralf Baechle" <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: Promblem with PREF (prefetching) in memcpy
In-Reply-To: <00dd01c26ba2$b18f55b0$10eca8c0@grendel>
References: <3D9D484B.4C149BD8@mips.com>
	<200210041153.MAA12052@mudchute.algor.co.uk>
	<00dd01c26ba2$b18f55b0$10eca8c0@grendel>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Return-Path: <dom@mudchute.algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@algor.co.uk
Precedence: bulk
X-list: linux-mips


> A prefetch to a well-formed, cacheable kseg0 address which 
> has no primary storage behind it (e.g. 0x04000000 on a system
> with 64M of physical memory) should, according to the spec,
> cause a cache fill to be initiated for the line at that address,

True (at the CPU boundary).

The system, having decoded the prefetch address and discovered it
accesses the 'launch at once on read' I/O register is not obliged to
resolve its dilemma by reading it.

It's not even obliged to generate a bus error: it's often less harmful
to just ignore it and pacify the CPU with some rubbish data...

... but let's suppose it doesn't:

> which will result in a bus error...

I assume that this is not theoretical, and that at least one MTI core
fails to ignore bus-error on prefetch?  (I take it that you're *not*
arguing that this would be wrong).  Oops.

If you enable bus errors, you must expect to have a bus error
exception handler - and one of its jobs is to quietly ignore the bogus
ones.

There are lots of other system hardware or software workarounds.

> ... if not a flat-out system hang.

It's not good to design such suicide regions into the memory
map... surely there's no MTI hardware which does *that*?

Dominic.
