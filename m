Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2007 01:08:14 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:52872 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20026652AbXFEAIM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Jun 2007 01:08:12 +0100
Received: (qmail 26809 invoked by uid 101); 5 Jun 2007 00:08:05 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 5 Jun 2007 00:08:05 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l55080Nm031360;
	Mon, 4 Jun 2007 17:08:00 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <LGNWZZ7D>; Mon, 4 Jun 2007 17:08:00 -0700
Message-ID: <4664A958.2030508@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Greg KH <gregkh@suse.de>
Cc:	Marc St-Jean <stjeanma@pmc-sierra.com>,
	dbrownell@users.sourceforge.net, akpm@linux-foundation.org,
	linux-mips@linux-mips.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH 11/12] drivers: PMC MSP71xx USB driver
Date:	Mon, 4 Jun 2007 17:07:52 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 05 Jun 2007 00:07:53.0523 (UTC) FILETIME=[8FF52030:01C7A705]
user-agent: Thunderbird 1.5.0.12 (X11/20070509)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Greg KH wrote:
> On Mon, Jun 04, 2007 at 05:23:44PM -0600, Marc St-Jean wrote:
>  > [PATCH 11/12] drivers: PMC MSP71xx USB driver
>  >
>  > Patch to add an USB driver for the PMC-Sierra MSP71xx devices.
>  >
>  > Patches 1 through 10 were posted to linux-mips@linux-mips.org as well
>  > as other sub-system lists/maintainers as appropriate. This patch has
>  > some dependencies on the first few patches in the set. If you would
>  > like to receive these or the entire set, please email me.
> 
> Note, David Brownell is the USB Gadget maintainer, he should ack this
> before going into the tree.
> 
> thanks,
> 
> greg k-h

I'll send it to him separately for now and add to the CC list next time.

Thanks,
Marc
