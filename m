Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f73LaVB28922
	for linux-mips-outgoing; Fri, 3 Aug 2001 14:36:31 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f73LaUV28915
	for <linux-mips@oss.sgi.com>; Fri, 3 Aug 2001 14:36:30 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f73LaHE1027609;
	Fri, 3 Aug 2001 14:36:17 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f73LaGOX027602;
	Fri, 3 Aug 2001 14:36:16 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Fri, 3 Aug 2001 14:36:16 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: "John D. Davis" <johnd@Stanford.EDU>
cc: SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>
Subject: Re: printk
In-Reply-To: <Pine.GSO.4.31.0108031412450.675-100000@myth1.Stanford.EDU>
Message-ID: <Pine.LNX.4.10.10108031430040.17509-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> Does anyone know off hand, the earlies point that I can use printk?  

Very early. Right after IRQs are setup and started. If no hardware is
present that can print the messages out the messages are queued in the
log buffer and once a device registers itself as a console it will flush
that buffer, thus printing everything. How soon can a register a device
as a console. Well that depends on when linux initializes the hardware.

> I added some printk statements to driver/char/console.c and the
> resulting kernel hangs with only the logo showing and no text.  

Printk calls the functons in console.c which in turn calls printk which
in turn and so on. So you get this recursive loop that goes on forever. 
So be careful. Also never call printk in interrupt handler. Printk turns
off IRQs when printing. This will be fixed in 2.5.X.
