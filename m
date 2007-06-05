Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2007 22:12:47 +0100 (BST)
Received: from iolanthe.rowland.org ([192.131.102.54]:65465 "HELO
	iolanthe.rowland.org") by ftp.linux-mips.org with SMTP
	id S20021863AbXFEVMm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Jun 2007 22:12:42 +0100
Received: (qmail 4007 invoked by uid 2102); 5 Jun 2007 17:12:35 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Jun 2007 17:12:35 -0400
Date:	Tue, 5 Jun 2007 17:12:35 -0400 (EDT)
From:	Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:	Marc St-Jean <stjeanma@pmc-sierra.com>
cc:	gregkh@suse.de, <linux-mips@linux-mips.org>,
	<akpm@linux-foundation.org>,
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] [PATCH 11/12] drivers: PMC MSP71xx USB driver
In-Reply-To: <200706042323.l54NNi6e013258@pasqua.pmc-sierra.bc.ca>
Message-ID: <Pine.LNX.4.44L0.0706051706550.4003-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <stern@rowland.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
Precedence: bulk
X-list: linux-mips

On Mon, 4 Jun 2007, Marc St-Jean wrote:

> [PATCH 11/12] drivers: PMC MSP71xx USB driver
> 
> Patch to add an USB driver for the PMC-Sierra MSP71xx devices.
> 
> Patches 1 through 10 were posted to linux-mips@linux-mips.org as well
> as other sub-system lists/maintainers as appropriate. This patch has
> some dependencies on the first few patches in the set. If you would
> like to receive these or the entire set, please email me.

My personal impressions:

This does far too much to be a single patch.  It needs to be broken up.

The change to hub.c looks more complicated than necessary.  You ought 
to be able to share more of the code.  Turning off power to the 
overcurrent port would probably be okay for any hub.

The changes to file_storage.c and other gadget drivers look completely 
unnecessary.  You're apparently trying to disallow 0-length transfers 
on endpoint 0.  For one thing, that's liable to break some protocols.  
For another, it would be better to make the test at one place, in your 
controller driver, instead of spread out among multiple gadget drivers.

Alan Stern
