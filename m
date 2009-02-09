Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Feb 2009 11:57:37 +0000 (GMT)
Received: from aux-209-217-49-36.oklahoma.net ([209.217.49.36]:48646 "EHLO
	proteus.paralogos.com") by ftp.linux-mips.org with ESMTP
	id S21365442AbZBIL5f (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Feb 2009 11:57:35 +0000
Received: from [192.168.236.58] ([217.109.65.213])
	by proteus.paralogos.com (8.9.3/8.9.3) with ESMTP id LAA05170;
	Sun, 8 Feb 2009 11:40:10 -0600
Message-ID: <49901A28.6030604@paralogos.com>
Date:	Mon, 09 Feb 2009 05:57:28 -0600
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To:	Rusty Russell <rusty@rustcorp.com.au>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Strange initialization in  arch/mips/kernel/smtc.c:1094?
References: <200902092149.16573.rusty@rustcorp.com.au>
In-Reply-To: <200902092149.16573.rusty@rustcorp.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Rusty Russell wrote:
> Latest Linus kernel, but it's been there a while:
>
> static struct irqaction irq_ipi = {
> 	.handler	= ipi_interrupt,
> 	.flags		= IRQF_DISABLED,
> 	.name		= "SMTC_IPI",
> 	.flags		= IRQF_PERCPU
> };
>
> .flags is initialized twice: I'm amazed this even compiles.
>   
I don't know where that came from.  The very earliest versions of smtc.c 
didn't have a declaration initialization at all, but filled the fields 
in setup_cross_vpe_interrupts().  The IRQ was PERCPU since day one.  The 
initial DISABLED state came later.  I'm guessing someone added that 
hastily and didn't notice the pre-existing .flags definition.  I'm 
curious as to which bit(s) are actually set.

          Regards,

          Kevin K.
