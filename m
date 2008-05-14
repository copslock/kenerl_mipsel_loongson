Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2008 16:09:43 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:64704 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024215AbYENPJl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 May 2008 16:09:41 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m4EF90CP027118;
	Wed, 14 May 2008 16:09:00 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m4EF8xT0027111;
	Wed, 14 May 2008 16:08:59 +0100
Date:	Wed, 14 May 2008 16:08:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH RESEND] [MIPS]: multi-statement if() seems to be
	missing braces
Message-ID: <20080514150859.GA9898@linux-mips.org>
References: <Pine.LNX.4.64.0805131444360.15369@wrl-59.cs.helsinki.fi> <20080513232507.GA24102@linux-mips.org> <20080513180225.194f400b.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080513180225.194f400b.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 13, 2008 at 06:02:25PM -0700, Andrew Morton wrote:

> > > In case this is a genuine bug, somebody else more familiar
> > > with that stuff should evaluate it's effects (I just found it
> > > by some shell pipeline and it seems suspicious looking).
> > 
> > Should be fairly as proven by practice; it's there since day of of 64-bit
> > pagetable for 32-bit hw support which was November 29, 2004.
> > 
> 
> It's unlikely that anyone would notice an error in pte_mkyoung().  It
> will affect page reclaim behaviour and _might_ be demonstrable with a
> carefully set up test.  But an error in here won't cause crashes or
> lockups or anything.

It's even more subtle than that.  Only a special variant of the pagetables
used for the MIPS equivalent of PAE is affected.  For performance reason
this format contains two copies of the some of the bits.  The result of
the bug was one being maintained corrected, the other one not.

> What this needs is someone who understands the architecture (ie: you
> ;)) to take a look, please.

I've applied the patch yesterday; will go to Linus in the next merge.

  Ralf
