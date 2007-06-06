Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 01:47:29 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:56530 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20021971AbXFFAr1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Jun 2007 01:47:27 +0100
Received: (qmail 29958 invoked by uid 101); 6 Jun 2007 00:47:19 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 6 Jun 2007 00:47:19 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l560lF9N024091;
	Tue, 5 Jun 2007 17:47:15 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <LGNW5D32>; Tue, 5 Jun 2007 17:47:15 -0700
Message-ID: <46660410.3070703@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Alan Stern <stern@rowland.harvard.edu>
Cc:	david-b@pacbell.net, gregkh@suse.de, linux-mips@linux-mips.org,
	akpm@linux-foundation.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH 11/12] drivers: PMC MSP71xx USB driv
	er
Date:	Tue, 5 Jun 2007 17:47:12 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 06 Jun 2007 00:47:12.0587 (UTC) FILETIME=[387B79B0:01C7A7D4]
user-agent: Thunderbird 1.5.0.12 (X11/20070509)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips


Alan Stern wrote:
> On Mon, 4 Jun 2007, Marc St-Jean wrote:
> 
>  > [PATCH 11/12] drivers: PMC MSP71xx USB driver
>  >
>  > Patch to add an USB driver for the PMC-Sierra MSP71xx devices.
>  >
>  > Patches 1 through 10 were posted to linux-mips@linux-mips.org as well
>  > as other sub-system lists/maintainers as appropriate. This patch has
>  > some dependencies on the first few patches in the set. If you would
>  > like to receive these or the entire set, please email me.
> 
> My personal impressions:
> 
> This does far too much to be a single patch.  It needs to be broken up.
> 
> The change to hub.c looks more complicated than necessary.  You ought
> to be able to share more of the code.  Turning off power to the
> overcurrent port would probably be okay for any hub.
> 
> The changes to file_storage.c and other gadget drivers look completely
> unnecessary.  You're apparently trying to disallow 0-length transfers
> on endpoint 0.  For one thing, that's liable to break some protocols. 
> For another, it would be better to make the test at one place, in your
> controller driver, instead of spread out among multiple gadget drivers.
> 
> Alan Stern


Thanks to everyone that provided feedback. I'll be resubmitting the host
code only and will resume with gadget once the host is accepted.

The host only patch is still ~50k but that's mostly due to all the
le32 -> ehci32 conversion in order to support the big endian controller.
The actual platform driver code is small.

Marc
