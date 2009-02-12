Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Feb 2009 13:25:01 +0000 (GMT)
Received: from mail.bugwerft.de ([212.112.241.193]:30380 "EHLO
	mail.bugwerft.de") by ftp.linux-mips.org with ESMTP
	id S21366254AbZBLNY7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Feb 2009 13:24:59 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.bugwerft.de (Postfix) with ESMTP id 3929F8F849D;
	Thu, 12 Feb 2009 14:24:53 +0100 (CET)
Received: from mail.bugwerft.de ([127.0.0.1])
	by localhost (mail.bugwerft.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id km5looll2MWK; Thu, 12 Feb 2009 14:24:53 +0100 (CET)
Received: from [10.1.1.27] (unknown [192.168.22.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bugwerft.de (Postfix) with ESMTP id 068188F849C;
	Thu, 12 Feb 2009 14:24:51 +0100 (CET)
Subject: Re: Au1200 and NAND Flash - K9F1G08U0A -
From:	Frank Neuber <linux-mips@kernelport.de>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	borasah@gmail.com, linux-mips@linux-mips.org
In-Reply-To: <20090212085312.GA3914@roarinelk.homelinux.net>
References: <200705192213.12019.borasah@gmail.com>
	 <1234425337.12847.124.camel@t60p>
	 <20090212081707.GA3656@roarinelk.homelinux.net>
	 <1234428043.12847.138.camel@t60p>
	 <20090212085312.GA3914@roarinelk.homelinux.net>
Content-Type: text/plain
Date:	Thu, 12 Feb 2009 14:24:50 +0100
Message-Id: <1234445090.12847.151.camel@t60p>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 
Content-Transfer-Encoding: 7bit
Return-Path: <linux-mips@kernelport.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@kernelport.de
Precedence: bulk
X-list: linux-mips

Hi Manuel,
thank you for the code. It is working perfect :-)
I added this in arch/mips/au1000/common/platform.c.
1,94 MByte/s read performance.
I think it is a good idea to remove the au1550nd.c.

Thank's again,
 Frank
Am Donnerstag, den 12.02.2009, 09:53 +0100 schrieb Manuel Lauss:
> On Thu, Feb 12, 2009 at 09:40:43AM +0100, Frank Neuber wrote:
> > Thank you for this very quick answer ...
> > 
> > Am Donnerstag, den 12.02.2009, 09:17 +0100 schrieb Manuel Lauss:
> > > Here's the NAND portion of a DB1200 board support rewrite I did a while
> > > ago.  It uses gen_nand instead of the au1550nd.c driver (which seems to
> > I saw this gen_nand (plat_nand.c) never before (because it is not
> > configurable in the Makefile)
> > 
> > > only work on the Db1550 and small page devices).  It shouls also work on
> > > any Au1550 since the Au1200 has identical NAND hardware.
> > Do I understand right, this is not a handmade patch aginst
> > plat_nand.c ? 
> > 
> > I try to mix this code now with the plat_nand.c, rigth?
> 
> No no no no: this belongs in your board code (board_setup.c or whatever you
> call it).  It's nothing more than registration of a platform_device plus
> required information/callbacks for the gen_nand driver.
> 
> 	Manuel Lauss
