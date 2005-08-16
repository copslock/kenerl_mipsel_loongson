Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2005 07:54:23 +0100 (BST)
Received: from forward-dummy3.hsphere.cc ([IPv6:::ffff:216.157.144.3]:22485
	"HELO forward.hsphere.cc") by linux-mips.org with SMTP
	id <S8225254AbVHPGyE>; Tue, 16 Aug 2005 07:54:04 +0100
Received: (qmail 53377 invoked from network); 16 Aug 2005 06:58:54 -0000
Received: from mail3.hsphere.cc (216.157.145.23)
  by forward.hsphere.cc with SMTP; 16 Aug 2005 06:58:54 -0000
Received: (qmail 10578 invoked by uid 399); 16 Aug 2005 06:58:41 -0000
Received: from unknown (HELO ?192.168.0.5?) (safiudeen@vsolve.org@220.247.243.183)
  by mail3.hsphere.cc with SMTP; 16 Aug 2005 06:58:40 -0000
Message-ID: <43019107.20902@vsolve.org>
Date:	Tue, 16 Aug 2005 13:08:55 +0600
From:	safiudeen <safiudeen@vsolve.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Au1100 static bus interface..
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <safiudeen@vsolve.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: safiudeen@vsolve.org
Precedence: bulk
X-list: linux-mips

Hello,
I am trying to interface TLC16C550C(externel UART chip) for DB1100 
(using it's daughter card connector for IO interfcae).
After we configure the static bus controller for requred chip select, we 
use au_readl,au_writel port I/O functions.When the TLC16C550 is present, 
it the test read/write look like working, but even when TLC16C550C is 
not connected, read/write operations look like working.I think we have 
to configure the I/O base address properly.
Following are the configureation of static buss controller uased for 
this test.

CPU Chip enable-2 ( Daugter card  chip select is generated using au1100 
ce2(LOW),addr-28(HIGH),addr27(HIGH), and addr26(LOW) )
Therefore we selected the following  base address
 physical base address 0xD 1800 0000   ( D - for DTY encoding for I/O 
device)

Chip select controll registers setting as follows

 first 3 bit of mem_setcfg2 ( 0xB4001020 ) was set to 001 (DTY encoding)
mem_staddr2 (0xB4001028) was set to 0x11803FFF

vitual base address was obtained using ioremap function as follows
   
    base_addrs=(u32)ioremap(0xD18000000,0x1000); to get 32 bit address

when do read/write opreation on base_addr, it generate requred chip 
select (Daughter card CS) .But  even the TLC16C550C is not connected , 
read/write operation works as the TLC16C550 is connected. what I guis is 
address wrongly maped or some wrong in chip slect configarations.

If anyone has done interfacing externel peripheral to au1100 static bus 
controller please help me in this regards
Thanx
Safiudeen. TS
