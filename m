Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Aug 2007 13:05:22 +0100 (BST)
Received: from cantor2.suse.de ([195.135.220.15]:44455 "EHLO mx2.suse.de")
	by ftp.linux-mips.org with ESMTP id S20021397AbXHOMFU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 15 Aug 2007 13:05:20 +0100
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 2F8FF221A2;
	Wed, 15 Aug 2007 14:05:14 +0200 (CEST)
Date:	Wed, 15 Aug 2007 14:59:20 +0200
From:	Andi Kleen <ak@suse.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christoph Lameter <clameter@sgi.com>,
	Mel Gorman <mel@skynet.ie>, Lee.Schermerhorn@hp.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/4] Embed zone_id information within the zonelist->zones pointer
Message-ID: <20070815125920.GD3406@bingen.suse.de>
References: <20070813225841.GG3406@bingen.suse.de> <Pine.LNX.4.64.0708131506030.28502@schroedinger.engr.sgi.com> <20070813230801.GH3406@bingen.suse.de> <Pine.LNX.4.64.0708131536340.29946@schroedinger.engr.sgi.com> <20070813234322.GJ3406@bingen.suse.de> <Pine.LNX.4.64.0708131553050.30626@schroedinger.engr.sgi.com> <20070814000041.GL3406@bingen.suse.de> <20070814002223.2d8d42c5@the-village.bc.nu> <20070814001441.GN3406@bingen.suse.de> <20070815113749.GA5862@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070815113749.GA5862@linux-mips.org>
Return-Path: <ak@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ak@suse.de
Precedence: bulk
X-list: linux-mips

On Wed, Aug 15, 2007 at 12:37:49PM +0100, Ralf Baechle wrote:
> On Tue, Aug 14, 2007 at 02:14:41AM +0200, Andi Kleen wrote:
> 
> > meth is only used on SGI O2s which are not that slow and unlikely
> > to work in tree anyways.
> 
> O2 doesn't enable CONFIG_ZONE_DMA so there is no point in using GFP_DMA in
> an O2-specific device driver.  Will send out patch in separate mail.

Great.

BTW I suspect this is true for some other GFP_DMA usages too.
Some driver writers seem to confuse it with the PCI DMA
APIs or believe it is always needed for them.

-Andi
