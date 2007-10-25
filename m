Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 15:46:04 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.186]:40128 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022619AbXJYOpz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 15:45:55 +0100
Received: by nf-out-0910.google.com with SMTP id c10so485595nfd
        for <linux-mips@linux-mips.org>; Thu, 25 Oct 2007 07:45:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=ICDE+u15UYSH3lXyUb1posPFwtsp80I+eqq3cPa+zJ0=;
        b=SRo237VPXgQmjWRdnpUDeQZocEfmm0Rgx8DtD+Xb/hV3zPloDkPnawAy1K7Zcj0FRd0HjknDwcGU9O3FukDWQdPxkgZrPutl9u2cp9XW/Cu16L/Pbpj+oPUZ66Y9fP2QJr/LdoTIbo79ph5VLpTJtz6xEw4AQNqOG5BTtLeHDBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=A5SaS9eR9gs/7wI1cixUQt9V9F9K4YLFjvKdut5nPMsMJcC4f6lE3rQh9t7reJGfFxRLKoNBA11xIgJ8c36p1qpedAvHlZ8V3QYK8jFiIDMEYbAjkkA2pnigAgT4tYctaym1s+JG/m9PIBgmNSXangt3WlEVs8qWndt/yMz+ECc=
Received: by 10.86.4.2 with SMTP id 2mr1425465fgd.1193323554557;
        Thu, 25 Oct 2007 07:45:54 -0700 (PDT)
Received: from ?194.132.8.27? ( [85.70.229.122])
        by mx.google.com with ESMTPS id z33sm452833ikz.2007.10.25.07.45.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Oct 2007 07:45:53 -0700 (PDT)
Message-ID: <4720AC73.8030509@gmail.com>
Date:	Thu, 25 Oct 2007 16:47:15 +0200
From:	Jan Nikitenko <jan.nikitenko@gmail.com>
User-Agent: Thunderbird 2.0.0.6 (X11/20070917)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: fix au1xxx UART0 irq setup
References: <4720A11E.5060101@gmail.com> <20071025140940.GC23398@linux-mips.org>
In-Reply-To: <20071025140940.GC23398@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-Path: <jan.nikitenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jan.nikitenko@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Oct 25, 2007 at 03:58:54PM +0200, Jan Nikitenko wrote:
> 
>> UART0 on Alchemy mips platforms (au1xxx) does not use real uart's hw
>> irq, causing 'ttyS0: 1 input overrun(s)' kernel message with data loss,
>> when more characters than uart's fifo size were to be received by the uart.
>>
>> This problem can be experienced for example when uart0 is used as a
>> serial console on au1550 and more than 16 characters are pasted from
>> clipboard to the console.
>>
>> The is_real_interrupt(irq) macro is defined in drivers/serial/8250.c as
>> a check, if the irq number is other than zero.
>> Because UART0 on au1xxx platforms uses irq number 0, the
>> is_real_interrupt() check fails and serial8250_backup_timeout() is used
>> instead of uart's hw irq.
>>
>> The patch redefines the is_real_interrupt(irq) macro, as suggested in
>> the comment above the macro definition in 8250.c, in the
>> asm-mips/serial.h to be always true for CONFIG_SERIAL_8250_AU1X00.
>> This allows the irq number 0 to be used as hw irq for the alchemy uart0
>> and fixes the overrun problem.
>>
>> Signed-off-by: Jan Nikitenko <jan.nikitenko@gmail.com>
> 
> Fairly unelegent imho but anyway, for 2.6.24 I've added support for
> tickless to MIPS which in turn required a bit of a cleanup on the Alchemy
> code so I renumbered the Alchemy interrupt numbers, so what used to be
> IRQ 0 is now IRQ 8 which means your patch is no longer needed for master.

That's good to know.

> 
> That said, irq 0 is imho totally valid (take the good old PIT timer
> interrupt of the PC as the classic example) and treating it as an invalid 
> interrupt number is broken.
> 
> It's however equally pretty crude hack to undefine a symbol in a file other
> than the one defining it ...

I did exactly as the comment in 8250.c suggested (that arch include
could redefine that macro) - I did not like it either...

Jan
