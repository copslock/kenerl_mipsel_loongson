Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2005 08:02:45 +0100 (BST)
Received: from bay14-f21.bay14.hotmail.com ([IPv6:::ffff:64.4.49.21]:58148
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225298AbVHPHCZ>; Tue, 16 Aug 2005 08:02:25 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Tue, 16 Aug 2005 00:06:58 -0700
Message-ID: <BAY14-F21B9D01D66A919BA51E5A7ADB00@phx.gbl>
Received: from 220.247.243.183 by by14fd.bay14.hotmail.msn.com with HTTP;
	Tue, 16 Aug 2005 07:06:58 GMT
X-Originating-IP: [220.247.243.183]
X-Originating-Email: [safiudeen@hotmail.com]
X-Sender: safiudeen@hotmail.com
From:	"safiudeen Ts" <safiudeen@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: Au1100 static bus interface..
Date:	Tue, 16 Aug 2005 07:06:58 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 16 Aug 2005 07:06:58.0912 (UTC) FILETIME=[17F77E00:01C5A231]
Return-Path: <safiudeen@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: safiudeen@hotmail.com
Precedence: bulk
X-list: linux-mips

Hello,
I am trying to interface TLC16C550C(externel UART chip) for DB1100 (using 
it's daughter card connector for IO interfcae).
After we configure the static bus controller for requred chip select, we use 
au_readl,au_writel port I/O functions.When the TLC16C550 is present, it the 
test read/write look like working, but even when TLC16C550C is not 
connected, read/write operations look like working.I think we have to 
configure the I/O base address properly.
Following are the configureation of static buss controller uased for this 
test.

CPU Chip enable-2 ( Daugter card  chip select is generated using au1100 
ce2(LOW),addr-28(HIGH),addr27(HIGH), and addr26(LOW) )
Therefore we selected the following  base address
physical base address 0xD 1800 0000   ( D - for DTY encoding for I/O device)

Chip select controll registers setting as follows

first 3 bit of mem_setcfg2 ( 0xB4001020 ) was set to 001 (DTY encoding)
mem_staddr2 (0xB4001028) was set to 0x11803FFF

vitual base address was obtained using ioremap function as follows
     base_addrs=(u32)ioremap(0xD18000000,0x1000); to get 32 bit address

when do read/write opreation on base_addr, it generate requred chip select 
(Daughter card CS) .But  even the TLC16C550C is not connected , read/write 
operation works as the TLC16C550 is connected. what I guis is address 
wrongly maped or some wrong in chip slect configarations.

If anyone has done interfacing externel peripheral to au1100 static bus 
controller please help me in this regards
Thanx
Safiudeen. TS

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
