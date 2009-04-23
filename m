Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 09:55:36 +0100 (BST)
Received: from mx1.moondrake.net ([212.85.150.166]:181 "EHLO mx1.mandriva.com")
	by ftp.linux-mips.org with ESMTP id S28606069AbZDWIUc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 23 Apr 2009 09:20:32 +0100
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id D9AE827400F; Thu, 23 Apr 2009 10:20:27 +0200 (CEST)
Received: from office-abk.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id 5EC7A274003;
	Thu, 23 Apr 2009 10:20:26 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id E86DF8285A;
	Thu, 23 Apr 2009 10:23:58 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id 72D71FF855;
	Thu, 23 Apr 2009 10:23:47 +0200 (CEST)
From:	Arnaud Patard <apatard@mandriva.com>
To:	Philippe Vachon <philippe@cowpig.ca>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Clean up Lemote Loongson 2E Support
References: <20090422063747.GA2009@cowpig.ca>
	<m363gxgic8.fsf@anduin.mandriva.com> <20090422161631.GA2317@cowpig.ca>
Organization: Mandriva
Date:	Thu, 23 Apr 2009 10:23:47 +0200
In-Reply-To: <20090422161631.GA2317@cowpig.ca> (Philippe Vachon's message of "Wed, 22 Apr 2009 12:16:31 -0400")
Message-ID: <m3skjzg4mk.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

Philippe Vachon <philippe@cowpig.ca> writes:

Hi,

> Hi,
>
> On Wed, Apr 22, 2009 at 11:15:19AM +0200, Arnaud Patard wrote:
>> 
>> Theses are neither Lemote nor 2E specifics. 2E and 2F controllers are
>> very similar (and they're similar to the bonito stuff). Why do you need
>> a specific header instead of using the Bonito64.h header for theses
>> constants ? And if you really want to create it, please rename all to
>> loongson and remove lemote references as it'll work on 2F and on boards
>> from ST.
>> 
>
> What might be worthwhile eventually is to move all the loongson code into
> arch/mips/loongson. I know there is some duplication of code between 2F
> and 2E as it stands, but since 2F isn't upstream yet (and probably won't
> be for a while), I would cross that bridge when we get there.

That's not a good reason to repeat wrong naming from the
past. Moverover, Lemote is trying to get 2f support merged so I would
say that you're pessimistic.

>
> Given how Loongson actually differs a lot from Bonito64 beyond a few of
> the control registers' addresses, perhaps it is worthwhile to start
> moving away from using bonito64.h anyways; it's a bit odd that ICT chose
> to base some of the SoC on the Bonito64 design, IMO, but that's a
> different conversation.
>
>> > +/* UART address (16550 -- on the Fulong) */
>> > +#define LS2E_UART_BASE		0x1fd003f8
>> 
>> It happens to be 0x1fd003f8 but it could have been at a different
>> address base. For instance, on 2f, depending on the board, there's
>> 0x1ff003f8 and 0x1fd003f8 (I think there's also some board with a
>> different address than theses but I'm not sure).
>> 
>
> One option I was thinking of was moving that into a device-specific
> header. However, of the two Loongson 2E devices I have, both have the
> UART at the same address -- are there any Loongson 2E devices that have
> the UART at a different location? None that I'm aware of (and on the 2F
> side, I only know of the Gdium).

1 is more than 0 so, please take 2f into account. I don't see the
benefit of creating yet an other header containing only difference
something like "UART_BASE 0x1ff003f8" 

>
> ...
>
>> > +static inline void ls2e_writeb(uint8_t value, unsigned long addr)
>> > +{
>> > +	*(volatile uint8_t *)addr = value;
>> > +}
>> > +
>> 
>> What about readl/writel and friends ?
>> 
>
> I'm ambivalent. Since they're sub-64-bit-wide reads/writes, they're
> happening in a single instruction anyways. I can adjust the patch to use
> them in the name of reducing code duplication.
>
>> hmm... I may be wrong on that but using ioremap looks here looks not a
>> good idea. This code is called by early_printk so you can end up calling
>> it very early in the boot process.
>> Also, you're calling ioremap everytime this function is called. Why
>> don't you do that only the first time ?
>> 
>> [...]
>
> Quite wrong -- as the address is in kseg1, when compiled this actually
> will end up having the same net effect as using the 'deprecated'
> CKSEG1ADDR() macro. Have a look at the implementation of
> __ioremap_mode() in arch/mips/include/asm/io.h. While it's being
> 'called' early in the boot process, the physical resource will be 
> accessed via its kseg1 address. When I was speaking to Ralf about this, 
> he had mentioned this was by design.

ok, I read the code too quickly. thanks.

Please note also that my remark about calling it everytime still
stands. Reading a variable is taking less instructions than calling
ioremap_nocache.

Arnaud
