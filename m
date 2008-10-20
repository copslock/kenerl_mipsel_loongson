Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2008 22:38:40 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:63354 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21945938AbYJTVii (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Oct 2008 22:38:38 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48fcfa310000>; Mon, 20 Oct 2008 17:37:53 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 20 Oct 2008 14:37:50 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 20 Oct 2008 14:37:50 -0700
Message-ID: <48FCFA2E.6040608@caviumnetworks.com>
Date:	Mon, 20 Oct 2008 14:37:50 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Andrew Morton <akpm@linux-foundation.org>
CC:	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, Tomaso.Paoletti@caviumnetworks.com
Subject: Re: [PATCH] serial: Initialize spinlocks in 8250 and don't clobber
 them.
References: <48F51114.2010105@caviumnetworks.com> <20081020141750.d0610586.akpm@linux-foundation.org>
In-Reply-To: <20081020141750.d0610586.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2008 21:37:50.0753 (UTC) FILETIME=[1A157110:01C932FC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Andrew Morton wrote:
[...]
> OK..  But serial8250_isa_init_ports() has so many callsites that I'd
> worry that we end up running this initialisation multiple times.  Say,
> if the right combination of boot options is provided?  This is probably
> a benign thing, but it's not desirable.
> 
> A simple "fix" would be
> 
> static void __init irq_lists_init(void)
> {
> 	static unsigned long done;
> 
> 	if (!test_and_set_bit(0, &done)) {
> 		int i;
> 
> 		for (i = 0; i < ARRAY_SIZE(irq_lists); i++)
> 			spin_lock_init(&irq_lists[i].lock);
> 	}
> }
> 
> A better fix would be to initialise all those spinlocks at compile
> time.  But given the need to pass the address of each lock into each
> lock's initialiser, that could be tricky.
> 

Alan Cox already fixed this part different way.

>>  	for (i = 0; i < nr_uarts; i++) {
>>  		struct uart_8250_port *up = &serial8250_ports[i];
>>  
>> @@ -2699,12 +2702,24 @@ static struct uart_driver serial8250_reg = {
>>   */
>>  int __init early_serial_setup(struct uart_port *port)
>>  {
>> +	struct uart_port *p;
>> +
>>  	if (port->line >= ARRAY_SIZE(serial8250_ports))
>>  		return -ENODEV;
>>  
>>  	serial8250_isa_init_ports();
>> -	serial8250_ports[port->line].port	= *port;
>> -	serial8250_ports[port->line].port.ops	= &serial8250_pops;
>> +	p = &serial8250_ports[port->line].port;
>> +	p->iobase       = port->iobase;
>> +	p->membase      = port->membase;
>> +	p->irq          = port->irq;
>> +	p->uartclk      = port->uartclk;
>> +	p->fifosize     = port->fifosize;
>> +	p->regshift     = port->regshift;
>> +	p->iotype       = port->iotype;
>> +	p->flags        = port->flags;
>> +	p->mapbase      = port->mapbase;
>> +	p->private_data = port->private_data;
>> +	p->ops		= &serial8250_pops;
>>  	return 0;
>>  }
> 
> Having to spell out each member like this is pretty nasty from a
> maintainability point of view.  If new fields are added to uart_port,
> we surely will forget to update this code.
> 
> But yes, copying a spinlock by value is quite wrong.  Perhaps we could
> retain the struct assigment and then run spin_lock_init() to get the
> spinlock into a sane state?

It is ugly, I will think about this part more.

Thanks,
David Daney
