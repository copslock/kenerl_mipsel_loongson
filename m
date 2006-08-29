Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2006 20:36:18 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:19633 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039500AbWH2TgR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2006 20:36:17 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 33E4C3ED1; Tue, 29 Aug 2006 12:36:11 -0700 (PDT)
Message-ID: <44F4976E.7020702@ru.mvista.com>
Date:	Tue, 29 Aug 2006 23:37:18 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Russell King <rmk@arm.linux.org.uk>
Cc:	Thomas Koeller <thomas.koeller@baslerweb.com>,
	linux-serial@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] RM9000 serial driver
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608220057.52213.thomas.koeller@baslerweb.com> <20060822095942.4663a4cd.yoichi_yuasa@tripeaks.co.jp> <200608260038.13662.thomas.koeller@baslerweb.com> <44F441F3.8050301@ru.mvista.com> <20060829190426.GA20606@flint.arm.linux.org.uk>
In-Reply-To: <20060829190426.GA20606@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Russell King wrote:
>>>@@ -576,22 +626,17 @@ static int size_fifo(struct uart_8250_po
>>> */
>>>static unsigned int autoconfig_read_divisor_id(struct uart_8250_port *p)
>>>{
>>>-	unsigned char old_dll, old_dlm, old_lcr;
>>>-	unsigned int id;
>>>+	unsigned char old_lcr;
>>>+	unsigned int id, old_dl;
>>>
>>>	old_lcr = serial_inp(p, UART_LCR);
>>>	serial_outp(p, UART_LCR, UART_LCR_DLAB);
>>>+	old_dl = _serial_dl_read(p);
>>>
>>>-	old_dll = serial_inp(p, UART_DLL);
>>>-	old_dlm = serial_inp(p, UART_DLM);
>>>-
>>>-	serial_outp(p, UART_DLL, 0);
>>>-	serial_outp(p, UART_DLM, 0);
>>>-
>>>-	id = serial_inp(p, UART_DLL) | serial_inp(p, UART_DLM) << 8;
>>>+	serial_dl_write(p, 0);
>>>+	id = serial_dl_read(p);
>>>
>>>-	serial_outp(p, UART_DLL, old_dll);
>>>-	serial_outp(p, UART_DLM, old_dlm);
>>>+	serial_dl_write(p, old_dl);
>>>	serial_outp(p, UART_LCR, old_lcr);
>>>
>>>	return id;

>>   Not sure the autoconfig code was intended for half-compatible UARTs. 
>>   Note that it sets up->port.type as its result. However, your change seems 
>>correct, it just have nothing to do with RM9000.

> It's worse than that - this code is there to read the ID from the divisor
> registers implemented in some UARTs.  If it isn't one of those UARTs, it's
> expected to return zero.

    Well, I guess it should still return 0 (or revision) if we use serial_dl_*()?

> So we don't actually want to be prodding some other random registers on
> differing UARTs.

>>   As a side note, I think that the code that sets DLAB before and resets it
>>after the divisor latch read/write should be part of serial_dl_read() and
>>serial_dl_write() actually. In the Alchemy UARTs this bit is reserved.

> Not really, for two reasons.

> 1. We end up with additional pointless writes to undo what serial_dl_*
>    did.

    Yes, sometimes.

> 2. setting DLAB might work for a subset of ports, but others require
>    different magic numbers written to LCR to access the divisor.

    Indeed, I've spotted one such case. But we could possible RMW the line 
control reg. so that serial_dl_*() "cleanup" after themselves?

> 3. other ports have additional properties when DLAB is set, to the
>    extent that you must not write other registers when it's reset to
>    avoid clearing some features you want to enable.

> So, really, Moving that stuff into serial_dl_* ends up adding additional
> code and complexity where it isn't needed.

   Well, alternatively, the checks might be added to the places where DLAB is 
written preventing the write for UARTs that don't have the bit. Or even such 
check and LCR masking or even write skipping might be added to serial_out()?

WBR, Sergei
