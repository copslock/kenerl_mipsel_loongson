Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Nov 2011 19:21:39 +0100 (CET)
Received: from imr4.ericy.com ([198.24.6.9]:55404 "EHLO imr4.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903707Ab1KLSVf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Nov 2011 19:21:35 +0100
Received: from eusaamw0706.eamcs.ericsson.se ([147.117.20.31])
        by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id pACILQCN026652;
        Sat, 12 Nov 2011 12:21:28 -0600
Received: from localhost (147.117.20.214) by eusaamw0706.eamcs.ericsson.se
 (147.117.20.91) with Microsoft SMTP Server id 8.3.137.0; Sat, 12 Nov 2011
 13:21:21 -0500
Date:   Sat, 12 Nov 2011 10:20:17 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     Matthias Bock <bockmatthias@web.de>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Linux Kernel for Telekom MR303
Message-ID: <20111112182017.GA28658@ericsson.com>
References: <1321120255.3588.24.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1321120255.3588.24.camel@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10938

On Sat, Nov 12, 2011 at 12:50:55PM -0500, Matthias Bock wrote:
> Hi,
> 
> I hope, this is the correct mailing list ...
> 
> Together with my Internet Package (Telekom Entertain) came a Receiver.
> It turned out, it runs Windows CE, so I disassembled it in order to
> replace it by Linux:
> 
> It contains the 32-bit MIPS CPU Broadcom BCM7405 at 400 MHz,
> 256 MByte DDR2 SDRAM, 4 MByte Flash and a 500 GB SATA HD.
> 
> I have never compiled Linux for platforms other than
> provided in the kernel config menu "Processor type...".
> 
> Where do I have to start ?
> And where can I share my developments ?
> 

Hi,

you would need a version of Linux for this specific box. I found a reference on the web
indicating that the OEM (Tatung Technology Inc) also offers Linux for this box. See
http://www.marcush.de/2011/02/12/test-des-mr303-telekom-entertain-media-receiver-303.
But even if you manage to get and load a Linux image, there would be no guarantee that
you could get it to work - if your internet or TV service requires an activation code
stored in the box, you would likely be out of luck.

Also, keep in mind you don't just need a kernel. You need a complete distribution with
root file system etc.

Guenter
