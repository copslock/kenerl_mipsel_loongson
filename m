Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0VL7cv05669
	for linux-mips-outgoing; Thu, 31 Jan 2002 13:07:38 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0VL7Xd05665
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 13:07:33 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g0VK6bn4029525;
	Thu, 31 Jan 2002 12:06:37 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g0VK6aCh029520;
	Thu, 31 Jan 2002 12:06:36 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Thu, 31 Jan 2002 12:06:36 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Vojtech Pavlik <vojtech@suse.cz>,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   linux-mips@oss.sgi.com,
   Linux ARM mailing list <linux-arm-kernel@lists.arm.linux.org.uk>
Subject: Re: [PATCH] Migration to input api for keyboards
In-Reply-To: <20020131004041.K19292@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10201311159380.23385-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> >    As some on you know the input api drivers for the PS/2 keyboard/mice
> > have gone into the dj tree for 2.5.X. I need people on other platforms
> > besides ix86 to test it out. I made the following patch that forces the
> > use of the new input drivers so people can test it. Shortly this patch
> > will be placed into the DJ tree but before I do this I want to make sure
> > it works for all platforms. Here is the patch to do this. Thank you.  
> 
> Oops.

Oops?

> Out of those 3 ARM machines, only 1 or maybe 2 has an 8042-compatible
> port.
> 
> CONFIG_PC_KEYB != i8042 controller present.  Please look more closely
> at stuff in include/asm-arm/arch-*/keyboard.h

I posted to find out which ones. BTW we have a driver for the acorn
keyboard controller. No acorn keyboard but we do have support the acorn
mouse. I can create a patch so you can give the mouse driver a try. Also
help on porting the acorn keyboard driver would be helpful, any docs on
it. 
