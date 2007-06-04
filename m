Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2007 00:58:05 +0100 (BST)
Received: from cantor.suse.de ([195.135.220.2]:691 "EHLO mx1.suse.de")
	by ftp.linux-mips.org with ESMTP id S20026650AbXFDX6C (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Jun 2007 00:58:02 +0100
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 5C1C0127B1;
	Tue,  5 Jun 2007 01:57:53 +0200 (CEST)
Date:	Mon, 4 Jun 2007 16:35:26 -0700
From:	Greg KH <gregkh@suse.de>
To:	Marc St-Jean <stjeanma@pmc-sierra.com>,
	dbrownell@users.sourceforge.net
Cc:	akpm@linux-foundation.org, linux-mips@linux-mips.org,
	linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH 11/12] drivers: PMC MSP71xx USB driver
Message-ID: <20070604233526.GA18567@suse.de>
References: <200706042323.l54NNi6e013258@pasqua.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200706042323.l54NNi6e013258@pasqua.pmc-sierra.bc.ca>
User-Agent: Mutt/1.5.15 (2007-04-06)
Return-Path: <gregkh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Mon, Jun 04, 2007 at 05:23:44PM -0600, Marc St-Jean wrote:
> [PATCH 11/12] drivers: PMC MSP71xx USB driver
> 
> Patch to add an USB driver for the PMC-Sierra MSP71xx devices.
> 
> Patches 1 through 10 were posted to linux-mips@linux-mips.org as well
> as other sub-system lists/maintainers as appropriate. This patch has
> some dependencies on the first few patches in the set. If you would
> like to receive these or the entire set, please email me.

Note, David Brownell is the USB Gadget maintainer, he should ack this
before going into the tree.

thanks,

greg k-h
