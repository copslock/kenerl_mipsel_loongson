Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2003 03:17:32 +0100 (BST)
Received: from frank.harvard.edu ([IPv6:::ffff:140.247.122.99]:63143 "EHLO
	frank.harvard.edu") by linux-mips.org with ESMTP
	id <S8225208AbTDYCR1>; Fri, 25 Apr 2003 03:17:27 +0100
Received: from frank.harvard.edu (frank.harvard.edu [140.247.122.99])
	by frank.harvard.edu (8.11.6/8.11.6) with ESMTP id h3P2HHI20356;
	Thu, 24 Apr 2003 22:17:17 -0400
Date: Thu, 24 Apr 2003 22:17:17 -0400 (EDT)
From: Chip Coldwell <coldwell@frank.harvard.edu>
To: Brad Parker <brad@parker.boston.ma.us>
cc: linux-mips@linux-mips.org
Subject: Re: NCD900 port? 
In-Reply-To: <200304250146.h3P1kNk24851@p2.parker.boston.ma.us>
Message-ID: <Pine.LNX.4.44.0304242215050.20322-100000@frank.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <coldwell@frank.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: coldwell@frank.harvard.edu
Precedence: bulk
X-list: linux-mips

On Thu, 24 Apr 2003, Brad Parker wrote:
> 
> It it's anything like the explora 450 you should be able to get it going.
> (oh my, did *I* say that?)
> 
> The 450 has those same two chips with a ppc403.  I managed to hack my
> way into their undocumented pci bridge enough to get linux booted and
> the ethernet working.  I have yet to get the s3 working but that's only
> because I can find a pdf for the chip anywhere.  I can certainly talk to
> the s3 (as well as the pcmcia space).

That's very interesting.  When you say you don't have the S3 working,
do you mean that you can't get a virtual terminal on the display or
that you can't get X Windows working?  If the former, do you use a
serial console?

The PCI bridge in the NC900 is documented, at least slightly (see my
earlier post for the link).

Chip

-- 
Charles  M. "Chip" Coldwell
"Turn on, log in, tune out"
