Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Aug 2007 13:33:06 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:26257 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021397AbXHOMdE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Aug 2007 13:33:04 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7FCWvSo014278;
	Wed, 15 Aug 2007 13:32:58 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7FCWuAj014277;
	Wed, 15 Aug 2007 13:32:56 +0100
Date:	Wed, 15 Aug 2007 13:32:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andi Kleen <ak@suse.de>
Cc:	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christoph Lameter <clameter@sgi.com>,
	Mel Gorman <mel@skynet.ie>, Lee.Schermerhorn@hp.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/4] Embed zone_id information within the
	zonelist->zones pointer
Message-ID: <20070815123256.GD5862@linux-mips.org>
References: <Pine.LNX.4.64.0708131506030.28502@schroedinger.engr.sgi.com> <20070813230801.GH3406@bingen.suse.de> <Pine.LNX.4.64.0708131536340.29946@schroedinger.engr.sgi.com> <20070813234322.GJ3406@bingen.suse.de> <Pine.LNX.4.64.0708131553050.30626@schroedinger.engr.sgi.com> <20070814000041.GL3406@bingen.suse.de> <20070814002223.2d8d42c5@the-village.bc.nu> <20070814001441.GN3406@bingen.suse.de> <20070815113749.GA5862@linux-mips.org> <20070815125920.GD3406@bingen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070815125920.GD3406@bingen.suse.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 15, 2007 at 02:59:20PM +0200, Andi Kleen wrote:

> On Wed, Aug 15, 2007 at 12:37:49PM +0100, Ralf Baechle wrote:
> > On Tue, Aug 14, 2007 at 02:14:41AM +0200, Andi Kleen wrote:
> > 
> > > meth is only used on SGI O2s which are not that slow and unlikely
> > > to work in tree anyways.
> > 
> > O2 doesn't enable CONFIG_ZONE_DMA so there is no point in using GFP_DMA in
> > an O2-specific device driver.  Will send out patch in separate mail.
> 
> Great.
> 
> BTW I suspect this is true for some other GFP_DMA usages too.
> Some driver writers seem to confuse it with the PCI DMA
> APIs or believe it is always needed for them.

In case of the O2 the full story is a little more complicated.  The O2 is
not I/O coherent.  That's a well know and handled configuration for the
R5000.  But the R10000 which was never designed for such use will do very
stupid things such as actually performing speculative stores and scribbling
into DMA buffers left and right.  There are two possible workarounds for
this; one is software only the other is using a little CPLD codenamed Juice
on the O2 R10000 board and would require a special memory region for DMA
buffers, so the ZONE_DMA was really there as some sort of future proofing.
But in the end the same arguments as for the Lance apply here.

  Ralf
