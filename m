Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Feb 2009 08:53:15 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:57241 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21366776AbZBLIxN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Feb 2009 08:53:13 +0000
Received: (qmail 3942 invoked by uid 1000); 12 Feb 2009 09:53:12 +0100
Date:	Thu, 12 Feb 2009 09:53:12 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Frank Neuber <linux-mips@kernelport.de>
Cc:	borasah@gmail.com, linux-mips@linux-mips.org
Subject: Re: Au1200 and NAND Flash - K9F1G08U0A -
Message-ID: <20090212085312.GA3914@roarinelk.homelinux.net>
References: <200705192213.12019.borasah@gmail.com> <1234425337.12847.124.camel@t60p> <20090212081707.GA3656@roarinelk.homelinux.net> <1234428043.12847.138.camel@t60p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1234428043.12847.138.camel@t60p>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Thu, Feb 12, 2009 at 09:40:43AM +0100, Frank Neuber wrote:
> Thank you for this very quick answer ...
> 
> Am Donnerstag, den 12.02.2009, 09:17 +0100 schrieb Manuel Lauss:
> > Here's the NAND portion of a DB1200 board support rewrite I did a while
> > ago.  It uses gen_nand instead of the au1550nd.c driver (which seems to
> I saw this gen_nand (plat_nand.c) never before (because it is not
> configurable in the Makefile)
> 
> > only work on the Db1550 and small page devices).  It shouls also work on
> > any Au1550 since the Au1200 has identical NAND hardware.
> Do I understand right, this is not a handmade patch aginst
> plat_nand.c ? 
> 
> I try to mix this code now with the plat_nand.c, rigth?

No no no no: this belongs in your board code (board_setup.c or whatever you
call it).  It's nothing more than registration of a platform_device plus
required information/callbacks for the gen_nand driver.

	Manuel Lauss
