Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 20:46:12 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:47356 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225208AbTDXTqL>;
	Thu, 24 Apr 2003 20:46:11 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id MAA30800;
	Thu, 24 Apr 2003 12:46:04 -0700
Subject: Re: Au1500 PCI autoconfig issues with multiple PCI devices?
From: Pete Popov <ppopov@mvista.com>
To: Jun Sun <jsun@mvista.com>
Cc: Jeff Baitis <baitisj@evolution.com>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <20030424121140.G28275@mvista.com>
References: <20030424114832.O10148@luca.pas.lab>
	 <20030424121140.G28275@mvista.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1051213566.2552.653.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Apr 2003 12:46:06 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, 2003-04-24 at 12:11, Jun Sun wrote:
> On Thu, Apr 24, 2003 at 11:48:32AM -0700, Jeff Baitis wrote:
> > Hi ya'll:
> > 
> > This is the first time I've tried multiple PCI devices on the Au1500. I have a
> > PCI->CardBus bridge and a 3Com ethernet plugged into the Au1500's PCI bus. I'm
> > using the linux_2_4 branch.
> >
> <snip>
> 
> Try this patch and let me know the results.
> 
> BTW, I did not know Au1500 has a cardbus controller.  I was under impression
> it is a PCMCIA controller.  Interesting.

The cardbus controller is a pci plug-in card.

Pete
