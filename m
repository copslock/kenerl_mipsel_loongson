Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2005 23:20:51 +0000 (GMT)
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:23178 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S3458549AbVLIXUd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Dec 2005 23:20:33 +0000
Received: (qmail 98849 invoked from network); 9 Dec 2005 23:20:28 -0000
Received: from unknown (HELO ?10.0.0.130?) (david-b@pacbell.net@69.226.248.13 with plain)
  by smtp106.sbc.mail.mud.yahoo.com with SMTP; 9 Dec 2005 23:20:27 -0000
From:	David Brownell <david-b@pacbell.net>
To:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
Subject: Re: [PATCH] Philips PNX8550 USB Host driver compile fix
Date:	Fri, 9 Dec 2005 15:20:26 -0800
User-Agent: KMail/1.7.1
Cc:	Peter Popov <ppopov@embeddedalley.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org, linux-usb-devel@lists.sourceforge.net
References: <20051206193522.2582.qmail@web411.biz.mail.mud.yahoo.com> <439864A6.9070104@ru.mvista.com>
In-Reply-To: <439864A6.9070104@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512091520.26719.david-b@pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

On Thursday 08 December 2005 8:51 am, Vladimir A. Barinov wrote:
> Hello Ralf, David,
> 
> Could you please advise.
> What is the right solution in the situation when USB PCI and on-chip USB 
> used in the situation when we want ohci-hcd to be a module?
> 
> Vladimir
> 
> Peter Popov wrote:
> 
> >I suppose the right solution is to be able to use the
> >on-chip usb controller as well as an external pci
> >controller. I don't think anyone will do that though.

I'm not sure why they wouldn't.  Full speed controllers
have limited bandwidth, people sometimes want more than
one just to get enough bandwidth to do whatever it is
they need USB to help with.


> >>The current ohci-hcd driver is a little defective.
> >>It's unable to use usb-ohci as modules in the case
> >>when PCI and on-chip USB are enabled.
> >>It just will not be compiled since there are two
> >>calls if module_init in ohci-hcd.

I think it'd be reasonable to expect that the two
options be (a) PCI version and/or (b) some SOC version.
Since I've never heard of a discrete OHCI part, I'll
suspect the posibillity of having several of them on
some external parallel bus is low...

Suggesting that what's needed is more at the level of
having the module_init code call a pair of #definable
routnes -- call them 'register_platform_ohci()' and
'register_pci_ohci() -- to handle either or both cases.

Then #ifndef register_platform_ohci, #define it as NOP;
likewise for the PCI version.  And for the unregisters.

I'd certainly OK merging that; it'd be general enough
to work on non-PNX hardware too.

- Dave
