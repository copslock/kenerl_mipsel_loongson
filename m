Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Dec 2006 23:56:55 +0000 (GMT)
Received: from [69.90.147.196] ([69.90.147.196]:53176 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20039157AbWLIX4t (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 9 Dec 2006 23:56:49 +0000
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id E413EE404D;
	Sat,  9 Dec 2006 17:22:54 -0800 (PST)
Subject: Re: console stuck
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
In-Reply-To: <457AEA8B.9030605@ru.mvista.com>
References: <1165630940.7860.7.camel@sandbar.kenati.com>
	 <457AEA8B.9030605@ru.mvista.com>
Content-Type: text/plain
Date:	Sat, 09 Dec 2006 16:09:41 -0800
Message-Id: <1165709381.6518.13.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Another basic query:

I m pretty sure I cant see my user space messages on the console due to
the fact that the ttyS0 device is not registered --

The board specific platform_init function that I wrote returns non-error
values and executes fine! --

Also, I figured that the ttyS0 uart regsitration is a separate process
that runs independently of the above arch_initcall --
It is spawned from the serial8250_register_ports function which is part
of the __init routines --

The "name" of the uart driver in this case is "serial" and is the struct
uart_driver serial8250_reg defined in the drivers/serial/8250.c file and
not "serial8250" which is the name of the struct device_driver
serial8250_isa_driver

-- how are these two processes -- the arch_initcall encm3_platform_init
function and the __init serial8250_register_ports function related? and
how come they use separate drivers?

Thank you,
Ashlesha.

On Sat, 2006-12-09 at 19:55 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> Ashlesha Shintre wrote:
> > Hi,
> 
> > I m very much confused as to why there is an infinite loop in the
> > __request_resource function in the linux/kernel/resource.c file?
> 
>     It has 2 exit points (return statements).
> 
> > The serial console is getting stuck at this point.
> 
>     Then there's something very wrong with your resources...
> 
> >>for (;;) {
> >>                tmp = *p;
> >>                if (!tmp || tmp->start > end) {
> >>                        new->sibling = tmp;
> >>                        *p = new;
> >>                        new->parent = root;
> >>                        return NULL;
> >>                }
> >>                p = &tmp->sibling;
> >>                if (tmp->end < start){
> >>                        printk("tmp->end = %d\n",tmp->end);
> >>                        printk("tmp->start = %d\n",tmp->start);
> >>                        printk("*********!!!!!!!*******sibling?!!\n");
> >>                        continue;
> >>                }
> >>                return tmp;
> > 
> > 
> > Thanks and Regards,
> > Ashlesha.
> 
> WBR, Sergei
> 
