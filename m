Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Oct 2004 18:34:04 +0100 (BST)
Received: from web81006.mail.yahoo.com ([IPv6:::ffff:206.190.37.151]:43886
	"HELO web81006.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225009AbUJWRd7>; Sat, 23 Oct 2004 18:33:59 +0100
Message-ID: <20041023173352.90595.qmail@web81006.mail.yahoo.com>
Received: from [63.194.214.47] by web81006.mail.yahoo.com via HTTP; Sat, 23 Oct 2004 10:33:52 PDT
X-RocketYMMF: pvpopov@pacbell.net
Date: Sat, 23 Oct 2004 10:33:52 -0700 (PDT)
From: Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
Subject: Re: Hi-Speed USB controller and au1500
To: Bruno Randolf <520066427640-0001@t-online.de>,
	linux-mips@linux-mips.org
Cc: 'Eric DeVolder' <eric.devolder@amd.com>
In-Reply-To: <200410231638.20982.bruno.randolf@4g-systems.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


> maybe not everything ist fixed in AD stepping... we
> have observed that on our 
> Au1500 AD board the internal USB host only works
> when we set CONFIG_NONCOHERENT_IO=y. 

Is this with 2.4 or 2.6? I haven't changed the
coherency defaults in 2.4. Which board do you have,
Db1500?

> without CONFIG_NONCOHERENT_IO=y we get crashes when
> the used usb bandwidth 
> gets higher. for example with an USB ethernet
> adapter: ping works but real 
> traffic makes the kernel crash. usb-storage does not
> work at all.
> 
> can you confirm this?

Not immediately but hopefully in the next few days.
Does usb storage work for you with NONCOHERENT_IO set?
 
> would it be possible to use CONFIG_NONCOHERENT_IO=y
> only for USB, and not PCI? 

Probably not cleanly.

> we have PCI cards (prism54) which only work without
> CONFIG_NONCOHERENT_IO, so 
> at the moment we can either have USB host or prism54
> based PCI cards...

Pete
