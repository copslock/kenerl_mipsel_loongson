Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2004 00:48:35 +0000 (GMT)
Received: from ntfw.echelon.com ([IPv6:::ffff:205.229.50.10]:5645 "HELO
	[205.229.50.10]") by linux-mips.org with SMTP id <S8225342AbUBEAsf>;
	Thu, 5 Feb 2004 00:48:35 +0000
Received: from miles.echelon.com by [205.229.50.10]
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 5 Feb 2004 00:48:34 UT
Received: by miles.echelon.com with Internet Mail Service (5.5.2653.19)
	id <Z7JW9XWK>; Wed, 4 Feb 2004 16:44:25 -0800
Message-ID: <5375D9FB1CC3994D9DCBC47C344EEB59383A16@miles.echelon.com>
From: Prashant Viswanathan <vprashant@echelon.com>
To: 'Nathan Field' <ndf@ghs.com>, Shaun Savage <savages@savages.net>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: RE: loading kernel via EJTAG interface
Date: Wed, 4 Feb 2004 16:44:24 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <vprashant@echelon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vprashant@echelon.com
Precedence: bulk
X-list: linux-mips


> -----Original Message-----
> From: Nathan Field [mailto:ndf@ghs.com]
> Sent: Wednesday, February 04, 2004 4:36 PM
> To: Shaun Savage
> Cc: Prashant Viswanathan; 'linux-mips@linux-mips.org'
> Subject: Re: loading kernel via EJTAG interface
> 
> 
> > > I am trying to load a linux kernel through a EJTAG 
> device. I was told
> > > that I should modify the kernel so that it doesnt attempt 
> to use the
> > > parameters passed to it by the loader. However, I am not 
> quite sure as
> > > to what it means and what exactly one has to do. I would really
> > > appreciate any pointers/help/suggestions.
> 	One approach is to create some sort of setup script that 
> "emulates" the boot loader. I've done that for a Malta board 
> (which uses a 
> boot loader called YAMON). Basically it does something like this:
> 
> 	reset and run the board
> 	sleep for 7 seconds to let YAMON do its normal setup
> 	halt the board
> 	do all the setup that YAMON would do when it runs a program
> 
> That last step is where the magic happens. Basically I do things like
> setup various registers to point to memory regions, and then in those
> regions create arrays of pointers, which point to strings containing
> things like the "environment" that YAMON fills in for programs and
> arguments that it passes. Depending on the capabilities of 
> your debugging
> environment this can either be easy or hard. My setup is really nice,
> downloads for small kernels take about the same time as going through
> tftp, but bigger kernels with a ramdisk are actually faster to push
> through EJTAG, which is nice :)
> 
> 	nathan

Thanks for the input.

I have a bootrom (different operating system) on my device and if I just
boot up from the bootrom it would set up all the registers, controllers for
me. Also, visionProbe (which I am using to download over the EJTAG
interface) sets up all the controllers for me. 

So, can't I just load the kernel image and just start executing from
"kernel_entry"?

Prashant
