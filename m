Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 18:40:24 +0200 (CEST)
Received: from jeeves.momenco.com ([64.169.228.99]:44295 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1122958AbSIDQkX>; Wed, 4 Sep 2002 18:40:23 +0200
Received: (from mdharm@localhost)
	by host099.momenco.com (8.11.6/8.11.6) id g84GeEm05306;
	Wed, 4 Sep 2002 09:40:14 -0700
Date: Wed, 4 Sep 2002 09:40:14 -0700
From: Matthew Dharm <mdharm@momenco.com>
To: Dominic Sweetman <dom@algor.co.uk>
Cc: Jun Sun <jsun@mvista.com>, Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Interrupt handling....
Message-ID: <20020904094014.B5241@momenco.com>
References: <3D6E87EB.4010000@mvista.com> <NEBBLJGMNKKEEMNLHGAIEEMBCIAA.mdharm@momenco.com> <200209040953.KAA17466@mudchute.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209040953.KAA17466@mudchute.algor.co.uk>; from dom@algor.co.uk on Wed, Sep 04, 2002 at 10:53:55AM +0100
Organization: Momentum Computer, Inc.
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Return-Path: <mdharm@host099.momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 81
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

On Wed, Sep 04, 2002 at 10:53:55AM +0100, Dominic Sweetman wrote:
> 
> Matthew,
> 
> > Okay... I think I've got a problem that isn't covered by the usual
> > examples.
> 
> Possibly this is too simple an answer and is stuff you know quite well
> already...

Yeah, it is. See my response to Maciej's posting....

> > Which, as you can see, attempts to access address 0xfc00000c.
> 
> But that address is in the MIPS CPU's 'kseg2' region.  Addresses there
> are always translated by the TLB, and you haven't got an entry.

It's also the physical address.

And this is the heart of the problem.  I set up an ioremap, so I thought
that the TLB exception handler would fix this for me.  It looks like that
code won't do anything if the exception was generated from an interrupt...
Or am I reading it wrong?  I'm not an expert on the TLB code...

> You could read the book ("See MIPS Run")...

I read it quite some time ago.  My copy got very dog-eared before I had the
majority of the information committed to memory.  Nice book, BTW.

Matt

-- 
Matthew Dharm                              Work: mdharm@momenco.com
Senior Software Designer, Momentum Computer
