Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f73LLAj27461
	for linux-mips-outgoing; Fri, 3 Aug 2001 14:21:10 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f73LL4V27451
	for <linux-mips@oss.sgi.com>; Fri, 3 Aug 2001 14:21:09 -0700
Received: from pacbell.net (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f73LQGA30060;
	Fri, 3 Aug 2001 14:26:16 -0700
Message-ID: <3B6B160C.6000609@pacbell.net>
Date: Fri, 03 Aug 2001 14:22:20 -0700
From: Pete Popov <ppopov@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: "John D. Davis" <johnd@stanford.edu>
CC: SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>
Subject: Re: printk
References: <Pine.GSO.4.31.0108031412450.675-100000@myth1.Stanford.EDU>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

John D. Davis wrote:
> Does anyone know off hand, the earlies point that I can use printk?  

Well, you can use them from the very beginning, but you won't see the 
output until after serial console init (if you're using a serial console).

> I added some printk statements to driver/char/console.c and the resulting
> kernel hangs with only the logo showing and no text.  Is prom_printf
> something that I should use instead. I put some printk statements in
> tty_io.c and kernel/printk.c and those compiled kernels work.

I like using simple puts and put32 routines that print a string and a 32 
bit number.  These routines bang directly on the uart so you see the 
prints immediately, before printk works.  Take a look at 
arch/mips/au1000/common/puts.c.

Pete
