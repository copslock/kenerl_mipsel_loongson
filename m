Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2006 15:41:29 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:51993 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039443AbWKWPlY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 23 Nov 2006 15:41:24 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 5BA7A3EBE; Thu, 23 Nov 2006 07:41:01 -0800 (PST)
Message-ID: <4565C16E.3090803@ru.mvista.com>
Date:	Thu, 23 Nov 2006 18:42:38 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] use generic_handle_irq, handle_level_irq, handle_percpu_irq
References: <20061114.011318.99611303.anemo@mba.ocn.ne.jp> <45631BD2.4090509@ru.mvista.com> <20061122120552.GA27782@linux-mips.org>
In-Reply-To: <20061122120552.GA27782@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>>>@@ -104,6 +105,7 @@ static struct irq_chip mips_mt_cpu_irq_c
>>>	.mask		= mask_mips_mt_irq,
>>>	.mask_ack	= mips_mt_cpu_irq_ack,
>>>	.unmask		= unmask_mips_mt_irq,
>>>+	.eoi		= unmask_mips_mt_irq,
>>>	.end		= mips_mt_cpu_irq_end,
>>>};
>>>
>>>@@ -124,7 +126,8 @@ void __init mips_cpu_irq_init(int irq_ba
>>>			set_irq_chip(i, &mips_mt_cpu_irq_controller);
>>>
>>>	for (i = irq_base + 2; i < irq_base + 8; i++)
>>>-		set_irq_chip(i, &mips_cpu_irq_controller);
>>>+		set_irq_chip_and_handler(i, &mips_cpu_irq_controller,
>>>+					 handle_level_irq);
>>
>>   BTW, isn't IRQ7 per-CPU?

> Yes and no.  On many CPUs IRQ 7 can be configured at reset time as either
> the count / compare interrupt or a CPU interrupt just like the others.
> It always used to be a normal CPU interrupt for R2000 class CPUs.

    Nevertheless, IRQ7 having percpu flow when it's known to be from 
count/compare would make the timer stuff faster, I assume...

>   Ralf

WBR, Sergei
