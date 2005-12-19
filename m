Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2005 18:10:24 +0000 (GMT)
Received: from LAubervilliers-151-13-113-26.w217-128.abo.wanadoo.fr ([217.128.183.26]:57899
	"EHLO serveurSMTP") by ftp.linux-mips.org with ESMTP
	id S8133886AbVLSSKH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Dec 2005 18:10:07 +0000
Received: from [192.168.150.1] by serveurSMTP
  (ArGoSoft Mail Server Freeware, Version 1.8 (1.8.8.2)); Mon, 19 Dec 2005 18:48:15 +0100
Message-ID: <43A6F155.7080402@avilinks.com>
Date:	Mon, 19 Dec 2005 18:43:49 +0100
From:	Yoann Allain <yallain@avilinks.com>
Organization: Avilinks
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Preempted interrupt handler
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <yallain@avilinks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yallain@avilinks.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm actually working on a driver for a Marvell chip on a MIPS-based 
board running a 2.4 kernel. I have one problem:
In my module, my interrupt handler is never executed. I have traced the 
code until action->handler(irq, action->dev_id, regs)  in 
handle_IRQ_event() but when the handler should be executed, it is not 
and the kernel reenters in the low-level interrupt dispatch routine 
(because we're using level sensitive interrupts and it is still up). 
I've checked that the function pointer called is the one of my handler 
but my routine is never entered.

But when my handler is included in the kernel (ie not compiled as a 
module), it works! My function gets executed and acks the interrupt. In 
this case all goes fine.

Moreover, I've noticed that the kernel symbols are mapped at adresses 
like 0x80258040 (start_kernel) but my module (and so is my handler) is 
loaded at something like 0xc000275c . I was thinking the module would be 
loaded in the same memory area as the kernel, so I think this is weird...
Perhaps, the module handler can't be executed because of its location 
but I don't know how to fix this.

Some suggestions?

Thanks in advance.

Yoann
