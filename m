Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 15:29:10 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:15497 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022673AbXJ2P3I (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Oct 2007 15:29:08 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9TFT1mZ005500;
	Mon, 29 Oct 2007 15:29:01 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9TFSPRE005455;
	Mon, 29 Oct 2007 15:28:25 GMT
Date:	Mon, 29 Oct 2007 15:28:25 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jan Nikitenko <jan.nikitenko@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: fix au1xxx UART0 irq setup
Message-ID: <20071029152824.GB3953@linux-mips.org>
References: <4720A11E.5060101@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4720A11E.5060101@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 25, 2007 at 03:58:54PM +0200, Jan Nikitenko wrote:

> UART0 on Alchemy mips platforms (au1xxx) does not use real uart's hw
> irq, causing 'ttyS0: 1 input overrun(s)' kernel message with data loss,
> when more characters than uart's fifo size were to be received by the uart.
> 
> This problem can be experienced for example when uart0 is used as a
> serial console on au1550 and more than 16 characters are pasted from
> clipboard to the console.
> 
> The is_real_interrupt(irq) macro is defined in drivers/serial/8250.c as
> a check, if the irq number is other than zero.
> Because UART0 on au1xxx platforms uses irq number 0, the
> is_real_interrupt() check fails and serial8250_backup_timeout() is used
> instead of uart's hw irq.
> 
> The patch redefines the is_real_interrupt(irq) macro, as suggested in
> the comment above the macro definition in 8250.c, in the
> asm-mips/serial.h to be always true for CONFIG_SERIAL_8250_AU1X00.
> This allows the irq number 0 to be used as hw irq for the alchemy uart0
> and fixes the overrun problem.
> 
> Signed-off-by: Jan Nikitenko <jan.nikitenko@gmail.com>

So applied to all of lmo's -stable branches.

  Ralf
