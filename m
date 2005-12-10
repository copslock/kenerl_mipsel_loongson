Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Dec 2005 05:24:24 +0000 (GMT)
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:12398 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133415AbVLJFYG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 10 Dec 2005 05:24:06 +0000
Received: (qmail 404 invoked from network); 10 Dec 2005 05:24:02 -0000
Received: from unknown (HELO ?10.0.0.130?) (david-b@pacbell.net@69.226.248.13 with plain)
  by smtp114.sbc.mail.mud.yahoo.com with SMTP; 10 Dec 2005 05:24:02 -0000
From:	David Brownell <david-b@pacbell.net>
To:	linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] ALCHEMY:  AU1200 USB Host Controller (OHCI/EHCI)
Date:	Fri, 9 Dec 2005 21:13:42 -0800
User-Agent: KMail/1.7.1
Cc:	"Jordan Crouse" <jordan.crouse@amd.com>, linux-mips@linux-mips.org,
	matthias.lenk@amd.com
References: <20051208210042.GB17458@cosmic.amd.com>
In-Reply-To: <20051208210042.GB17458@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512092113.43536.david-b@pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

On Thursday 08 December 2005 1:00 pm, Jordan Crouse wrote:
> Ok, here we go.  I give you the OHCI/EHCI host controller support for
> the Alchemy AU1200 processor.  I'm sending this up, partly because I have
> it ready to go, but also because it seems that enough folks are getting their
> hands on AU1200 parts to make this a hot topic.  

Interesting.  This is actually a couple different things ... the OTG
related bits would IMO be good to split out from the EHCI ones, and
from the OHCI ones.

Maybe once 2.6.15 gets out you'd split these out a bit?


> Special thanks to Pete Popov and his merry band of kernel hackers for 
> paving the way by pushing to seperate EHCI and PCI in the USB subsystem.

Actually that patch started with Matt Porter, although some earlier
non-mergeable versions came from ARC (now TDI).  And splitting it out
turned up a bunch of problems, mostly now fixed.


> Note that the AU1200 does support UDC/OTG as well, but thats another patch 
> for another day. :)

Actually you included a preview in this patch.  Interesting ... that
makes three OTG implementations I've seen on Linux ... the second
highspeed one, too.

I think you shouldn't need that OTG_HIGHSPEED symbol, given there's
already USB_OTG and USB_GADGET_DUALSPEED, that's implicit.  And in
fact, it'd be implicit inside EHCI given just USB_OTG!

That OTG stuff needs work yet.  No <linux/usb.h> changes should be
needed, and I'm not sure what this "relaxed whitelist" is for.  But
by the time those answers are apparent, I expect you'll have give
us mergeable patches for OHCI, EHCI, and the UDC.  ;)

- Dave
