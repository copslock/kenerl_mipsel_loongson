Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9JFHUj30342
	for linux-mips-outgoing; Fri, 19 Oct 2001 08:17:30 -0700
Received: from [64.152.86.3] (unknown.Level3.net [64.152.86.3] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9JFHQD30339
	for <linux-mips@oss.sgi.com>; Fri, 19 Oct 2001 08:17:26 -0700
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 19 Oct 2001 15:19:01 UT
Received: from bud.austin.esstech.com ([193.5.206.3])
	by mail.esstech.com (8.8.8+Sun/8.8.8) with SMTP id IAA00558;
	Fri, 19 Oct 2001 08:15:59 -0700 (PDT)
Received: from esstech.com by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id KAA00051; Fri, 19 Oct 2001 10:15:08 -0500
Message-ID: <3BD04458.8050200@esstech.com>
Date: Fri, 19 Oct 2001 10:18:48 -0500
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mike McDonald <mikemac@mikemac.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Moving kernel_entry to LOADADDR
References: <200110191511.IAA27477@saturn.mikemac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


>>How about just getting it from the ELF header?  It's trivial.
>>
> 
>   Because a bare bones bootloader may not know anything about ELF. The
> simplest solution is to just stick a "jmp start_kernel" at LOADADDR
> right before the fill. Then the load address and the entry point are
> the same. Once the exception vectors get loaded, they'll overwrite the
> jmp, so no space is wasted and none of the LOADADDRs have to be
> changed.


That was my thinking.

Except the fill has nothing to do with exception vectors any more.  It
looks like at one time LOADADDR was always 0x8000_0000.  Now that it's
set to something else, the fill just leaves a hole for no reason.  That's
why I recommend removing it regardless of whether there's a use for my
idea.

With the fill is gone, and since the kernel is not normally placed
at 0x8000_0000, I suggest just moving kernel_entry to the top of head.S
instead of putting a jump at the top of the file.

Also, compile tricks won't work (at least in my case).  Normally the bootloader
and the kernel are in two memories, often programmed in different ways.  For
example, a system normally has rom at the boot address at 0x1fc0_0000, ram at
0x8000_0000, and some other memory (flash, hard disk, whatever) storing a kernel
(or kernels) somewhere else.  Any compile time tricks require the boot rom to be
reprogrammed when the kernel changes.  That's part of what I wanted to avoid.

Gerald

 



 
