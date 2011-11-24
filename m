Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2011 17:39:22 +0100 (CET)
Received: from mout.web.de ([212.227.15.4]:55922 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904610Ab1KXQjS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Nov 2011 17:39:18 +0100
Received: from [192.168.2.105] ([93.219.183.103]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LzK2z-1QqJN33P6n-014oYn; Thu, 24 Nov 2011 17:39:12
 +0100
Message-ID: <1322152751.7967.7.camel@localhost>
Subject: Re: Linux Kernel for Telekom MR303
From:   Matthias Bock <bockmatthias@web.de>
To:     Guenter Roeck <guenter.roeck@ericsson.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Date:   Thu, 24 Nov 2011 17:39:11 +0100
In-Reply-To: <20111112182017.GA28658@ericsson.com>
References: <1321120255.3588.24.camel@localhost>
         <20111112182017.GA28658@ericsson.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.0.3-2 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Provags-ID:  V02:K0:+zbUdatSAFs5k/b/U93YZ1lHSUjAhLVbRLBAYAhvNYJ
 JzPTTWuHfhcqwKKbFtu9kqTOYkbPrPozlt5OkQABLRkJaSR3b+
 51fzjs6MHy5YKDevplKeHBhZRk7MBAhA1ECWnisZchpKRxJ1Ol
 7GTYImwzQvNPyZq3K7D4eCOkSXxdXdOcudI64aOqmLyDzrOJFV
 m76Q+yjq7NOTS6Ap1Gsrg==
X-archive-position: 31963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bockmatthias@web.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20945

Hi there,

yes, I've seen the site you linked and have already mailed
to Tatung, but no response received yet and there's also no Linux
available on their website.
Anyway I guess they are only communicating with big distributors
like Telekom, no support for private people.

Nevertheless I intend to put barebox or U-Boot compiled for
MIPS in the MBR of the box's hard disk, loading a
Linux MIPS kernel and booting into Debian MIPS.
That project should have a chance, right?

Cheers! Matthias


Hi,

> you would need a version of Linux for this specific box. I found a
reference on the web
> indicating that the OEM (Tatung Technology Inc) also offers Linux for
this box. See
>
http://www.marcush.de/2011/02/12/test-des-mr303-telekom-entertain-media-receiver-303.
> But even if you manage to get and load a Linux image, there would be
no guarantee that
> you could get it to work - if your internet or TV service requires an
activation code
> stored in the box, you would likely be out of luck.
> 
> Also, keep in mind you don't just need a kernel. You need a complete
distribution with
> root file system etc.
> 
> Guenter
> 
> 
On Sat, 2011-11-12 at 10:20 -0800, Guenter Roeck wrote:
> On Sat, Nov 12, 2011 at 12:50:55PM -0500, Matthias Bock wrote:
> > Hi,
> > 
> > I hope, this is the correct mailing list ...
> > 
> > Together with my Internet Package (Telekom Entertain) came a Receiver.
> > It turned out, it runs Windows CE, so I disassembled it in order to
> > replace it by Linux:
> > 
> > It contains the 32-bit MIPS CPU Broadcom BCM7405 at 400 MHz,
> > 256 MByte DDR2 SDRAM, 4 MByte Flash and a 500 GB SATA HD.
> > 
> > I have never compiled Linux for platforms other than
> > provided in the kernel config menu "Processor type...".
> > 
> > Where do I have to start ?
> > And where can I share my developments ?
> > 
