Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Oct 2004 21:06:48 +0100 (BST)
Received: from web81002.mail.yahoo.com ([IPv6:::ffff:206.190.37.147]:39520
	"HELO web81002.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225234AbUJWUGW>; Sat, 23 Oct 2004 21:06:22 +0100
Message-ID: <20041023200614.7551.qmail@web81002.mail.yahoo.com>
Received: from [63.194.214.47] by web81002.mail.yahoo.com via HTTP; Sat, 23 Oct 2004 13:06:14 PDT
X-RocketYMMF: pvpopov@pacbell.net
Date: Sat, 23 Oct 2004 13:06:14 -0700 (PDT)
From: Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
Subject: Re: Hi-Speed USB controller and au1500
To: Bruno Randolf <520066427640-0001@t-online.de>,
	ppopov@embeddedalley.com
Cc: linux-mips@linux-mips.org, 'Eric DeVolder' <eric.devolder@amd.com>
In-Reply-To: <200410232025.57107.bruno.randolf@4g-systems.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


> On Saturday 23 October 2004 19:33, Pete Popov wrote:
> > > maybe not everything ist fixed in AD stepping...
> we
> > > have observed that on our
> > > Au1500 AD board the internal USB host only works
> > > when we set CONFIG_NONCOHERENT_IO=y.
> >
> > Is this with 2.4 or 2.6? I haven't changed the
> > coherency defaults in 2.4. 
> 
> this is with 2.4.24 and with 2.4.27
> have not tried it with 2.6 yet.

The usb support is now in 2.6; I pushed it in
recently. You'll still need the 36bit address support
patch that's in my directory. If you get to it before
me, let me know the result with usb storage in 2.6.

Pete
 
> > Which board do you have, 
> > Db1500?
> 
> we have custom boards, called "mtx-1", marketed as
> "meshcube" or "access cube"
> 
> > Does usb storage work for you with NONCOHERENT_IO
> set?
> 
> yes, USB host works fine with
> CONFIG_NONCOHERENT_IO=y
> 
> bruno
> 

> ATTACHMENT part 2 application/pgp-signature 
