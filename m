Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0V1evM31174
	for linux-mips-outgoing; Wed, 30 Jan 2002 17:40:57 -0800
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk [212.18.232.186])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0V1eqd31168
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 17:40:52 -0800
Received: from [3ffe:8260:2002:1:201:2ff:fe14:8fad] (helo=flint.arm.linux.org.uk)
	by caramon.arm.linux.org.uk with esmtp (Exim 3.16 #1)
	id 16W5HN-0004hh-00; Thu, 31 Jan 2002 00:40:41 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 3.16 #1)
	id 16W5HN-0006Wd-00; Thu, 31 Jan 2002 00:40:41 +0000
Date: Thu, 31 Jan 2002 00:40:41 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   linux-mips@oss.sgi.com,
   Linux ARM mailing list <linux-arm-kernel@lists.arm.linux.org.uk>
Subject: Re: [PATCH] Migration to input api for keyboards
Message-ID: <20020131004041.K19292@flint.arm.linux.org.uk>
References: <Pine.LNX.4.10.10201301553260.7609-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10201301553260.7609-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Wed, Jan 30, 2002 at 04:13:40PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jan 30, 2002 at 04:13:40PM -0800, James Simmons wrote:
>    As some on you know the input api drivers for the PS/2 keyboard/mice
> have gone into the dj tree for 2.5.X. I need people on other platforms
> besides ix86 to test it out. I made the following patch that forces the
> use of the new input drivers so people can test it. Shortly this patch
> will be placed into the DJ tree but before I do this I want to make sure
> it works for all platforms. Here is the patch to do this. Thank you.  

Oops.

> +CONFIG_SERIO_I8042=y
> +CONFIG_I8042_REG_BASE=60
> +CONFIG_I8042_KBD_IRQ=1
> +CONFIG_I8042_AUX_IRQ=12

Out of those 3 ARM machines, only 1 or maybe 2 has an 8042-compatible
port.

CONFIG_PC_KEYB != i8042 controller present.  Please look more closely
at stuff in include/asm-arm/arch-*/keyboard.h

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
