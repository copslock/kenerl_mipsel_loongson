Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6I01Ou16536
	for linux-mips-outgoing; Tue, 17 Jul 2001 17:01:24 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6I01NV16531
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 17:01:23 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f6I017di029867;
	Tue, 17 Jul 2001 17:01:07 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f6I015vS029863;
	Tue, 17 Jul 2001 17:01:06 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Tue, 17 Jul 2001 17:01:05 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Fuxin Zhang <fxzhang@ict.ac.cn>
cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: help on linux-mipsel frame buffer
In-Reply-To: <200107171307.f6HD7fV18697@oss.sgi.com>
Message-ID: <Pine.LNX.4.10.10107171655090.22673-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


>   First I try the vga16 frame buffer driver,but i can only get
> some black/white strips on the screen.(after made some changes 
> to the source,most important one is use pci to find and set the
> vbase address). 

It is hardwired into the vga16fb driver the memory region (0xA000). This
is very wrong on non intel platforms. So that drivers pretty much doesn't
work on anything else.

>   Then I try to use vesa driver. This one use some vgabios code 
> I commented out the x86 relevant codes and made it compiled,

The VESA framebuffer is also intel specific. It uses the BIOS to setup the
video mode. This is done long before the cpu is placed into protect mode.

>   Finally I back port the Riva TNT frame buffer code to 2.2,the result
> is the same as the vesa driver.

Hum. Try a cat /dev/urandom > /dev/fb0. If you don't see anything then the
virtual memory address of the framebuffer is wrong. It could be that the
physical address is wrong (smem_start). Go to the fbdev website
(http://www.linux-fbdev.org) and download a tool called fbtest and give it
a try.
