Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2011 20:37:08 +0100 (CET)
Received: from imr4.ericy.com ([198.24.6.9]:56772 "EHLO imr4.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904615Ab1KXThD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Nov 2011 20:37:03 +0100
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
        by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id pAOJaqYk031612;
        Thu, 24 Nov 2011 13:36:56 -0600
Received: from localhost (147.117.20.214) by eusaamw0711.eamcs.ericsson.se
 (147.117.20.179) with Microsoft SMTP Server id 8.3.137.0; Thu, 24 Nov 2011
 14:36:47 -0500
Date:   Thu, 24 Nov 2011 11:35:43 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     Matthias Bock <bockmatthias@web.de>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Linux Kernel for Telekom MR303
Message-ID: <20111124193543.GA3481@ericsson.com>
References: <1321120255.3588.24.camel@localhost>
 <20111112182017.GA28658@ericsson.com>
 <1322152751.7967.7.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1322152751.7967.7.camel@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21050

On Thu, Nov 24, 2011 at 11:39:11AM -0500, Matthias Bock wrote:
> Hi there,
> 
> yes, I've seen the site you linked and have already mailed
> to Tatung, but no response received yet and there's also no Linux
> available on their website.
> Anyway I guess they are only communicating with big distributors
> like Telekom, no support for private people.
> 
> Nevertheless I intend to put barebox or U-Boot compiled for
> MIPS in the MBR of the box's hard disk, loading a
> Linux MIPS kernel and booting into Debian MIPS.
> That project should have a chance, right?
> 
I'd say it is worth a try.

On a side note, top posting is discouraged on Linux kernel mailing lists.

Thanks,
Guenter

> Cheers! Matthias
> 
> 
> Hi,
> 
> > you would need a version of Linux for this specific box. I found a
> reference on the web
> > indicating that the OEM (Tatung Technology Inc) also offers Linux for
> this box. See
> >
> http://www.marcush.de/2011/02/12/test-des-mr303-telekom-entertain-media-receiver-303.
> > But even if you manage to get and load a Linux image, there would be
> no guarantee that
> > you could get it to work - if your internet or TV service requires an
> activation code
> > stored in the box, you would likely be out of luck.
> > 
> > Also, keep in mind you don't just need a kernel. You need a complete
> distribution with
> > root file system etc.
> > 
> > Guenter
> > 
> > 
> On Sat, 2011-11-12 at 10:20 -0800, Guenter Roeck wrote:
> > On Sat, Nov 12, 2011 at 12:50:55PM -0500, Matthias Bock wrote:
> > > Hi,
> > > 
> > > I hope, this is the correct mailing list ...
> > > 
> > > Together with my Internet Package (Telekom Entertain) came a Receiver.
> > > It turned out, it runs Windows CE, so I disassembled it in order to
> > > replace it by Linux:
> > > 
> > > It contains the 32-bit MIPS CPU Broadcom BCM7405 at 400 MHz,
> > > 256 MByte DDR2 SDRAM, 4 MByte Flash and a 500 GB SATA HD.
> > > 
> > > I have never compiled Linux for platforms other than
> > > provided in the kernel config menu "Processor type...".
> > > 
> > > Where do I have to start ?
> > > And where can I share my developments ?
> > > 
> 
> 
