Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Jan 2005 02:24:26 +0000 (GMT)
Received: from imfep01.dion.ne.jp ([IPv6:::ffff:210.174.120.145]:24186 "EHLO
	imfep01.dion.ne.jp") by linux-mips.org with ESMTP
	id <S8225750AbVAPCYN>; Sun, 16 Jan 2005 02:24:13 +0000
Received: from [192.168.0.2] ([218.222.93.90]) by imfep01.dion.ne.jp
          (InterMail vM.4.01.03.31 201-229-121-131-20020322) with ESMTP
          id <20050116022408.LQHR1125.imfep01.dion.ne.jp@[192.168.0.2]>;
          Sun, 16 Jan 2005 11:24:08 +0900
Message-ID: <41E9D047.4010603@mb.neweb.ne.jp>
Date: Sun, 16 Jan 2005 11:24:07 +0900
From: Nyauyama <ichinoh@mb.neweb.ne.jp>
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: Nyauyama <ichinoh@mb.neweb.ne.jp>
Subject: QUESTION YAMON's uart3 of au1100
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-Path: <ichinoh@mb.neweb.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ichinoh@mb.neweb.ne.jp
Precedence: bulk
X-list: linux-mips

Hello!

I have a question about initialization of YAMON's uart3 of au1100.
BFC00000(BOOTLOC) is read by processing delay3.
Why BFC00000?


#define BOOTLOC (*(volatile unsigned int *)0xbfc00000)
int delay3(int n)
{
int i, j, v;
for( i = 0; i < n; ++i )
{
for( j = 0; j < 1000; ++j )
v += BOOTLOC;
}
return v;
}
void init_uart3()
{
uart3.uart_module_control = UART_CE; // disable the module, enable the
clocks
delay3(100); // 100 ms delay
uart3.uart_module_control = UART_CE | UART_ME; // enable the module
delay3(100); // delay another 100 ms
uart3.uart_interrupt_enable = 0; // disable interrupts
uart3.uart_fifo_control = UART_TR | UART_RR; // reset the receiver and
transmitter
uart3.uart_line_control = UART_WORD_8 | UART_NO_PARITY | UART_STOP_1;
uart3.uart_clock_divider = 156;
setbrg3(396000000,2); // set baud rate for default cpu clock
delay3(100);
}

Regards,
Nyauyama.
