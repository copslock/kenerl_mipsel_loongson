Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Jan 2005 03:01:55 +0000 (GMT)
Received: from mail.chipsandsystems.com ([IPv6:::ffff:64.164.196.27]:64993
	"EHLO mail.chipsag.com") by linux-mips.org with ESMTP
	id <S8225776AbVAPDBu>; Sun, 16 Jan 2005 03:01:50 +0000
Received: from [10.2.2.64] ([63.194.214.47]) by mail.chipsag.com with Microsoft SMTPSVC(6.0.3790.0);
	 Sat, 15 Jan 2005 19:04:07 -0800
Message-ID: <41E9D91A.3050201@embeddedalley.com>
Date: Sat, 15 Jan 2005 19:01:46 -0800
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nyauyama <ichinoh@mb.neweb.ne.jp>
CC: linux-mips@linux-mips.org
Subject: Re: QUESTION YAMON's uart3 of au1100
References: <41E9D047.4010603@mb.neweb.ne.jp>
In-Reply-To: <41E9D047.4010603@mb.neweb.ne.jp>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jan 2005 03:04:07.0529 (UTC) FILETIME=[0B2BE590:01C4FB78]
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Nyauyama wrote:
> Hello!
> 
> I have a question about initialization of YAMON's uart3 of au1100.
> BFC00000(BOOTLOC) is read by processing delay3.
> Why BFC00000?

Looks like just an arbitrary ad-hoc delay routine (delay3) that
reads from uncached space and throws away the value (just a delay).

What's the problem you're having?

Pete

> 
> 
> #define BOOTLOC (*(volatile unsigned int *)0xbfc00000)
> int delay3(int n)
> {
> int i, j, v;
> for( i = 0; i < n; ++i )
> {
> for( j = 0; j < 1000; ++j )
> v += BOOTLOC;
> }
> return v;
> }
> void init_uart3()
> {
> uart3.uart_module_control = UART_CE; // disable the module, enable the
> clocks
> delay3(100); // 100 ms delay
> uart3.uart_module_control = UART_CE | UART_ME; // enable the module
> delay3(100); // delay another 100 ms
> uart3.uart_interrupt_enable = 0; // disable interrupts
> uart3.uart_fifo_control = UART_TR | UART_RR; // reset the receiver and
> transmitter
> uart3.uart_line_control = UART_WORD_8 | UART_NO_PARITY | UART_STOP_1;
> uart3.uart_clock_divider = 156;
> setbrg3(396000000,2); // set baud rate for default cpu clock
> delay3(100);
> }
> 
> Regards,
> Nyauyama.
> 
> 
> 
