Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA7Nnwt16310
	for linux-mips-outgoing; Wed, 7 Nov 2001 15:49:58 -0800
Received: from mail.palmchip.com ([63.203.52.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA7Nns016307
	for <linux-mips@oss.sgi.com>; Wed, 7 Nov 2001 15:49:54 -0800
Received: from palmchip.com (scarlett.palmchip.com [10.1.10.90])
	by mail.palmchip.com (8.11.6/8.11.0) with ESMTP id fA7Mo5r13483;
	Wed, 7 Nov 2001 14:50:05 -0800
Message-ID: <3BE9D6E6.2010706@palmchip.com>
Date: Wed, 07 Nov 2001 16:50:46 -0800
From: Waren Hardy <warren@palmchip.com>
Reply-To: warren.hardy@palmchip.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux-mips <linux-mips@oss.sgi.com>, MipsMailList <linux-mips@fnet.fr>
Subject: memory mapping for MIPS 4Kc
References: <008701c165ac$1a49a9a0$4c0c5c8c@trd.iii.org.tw> <07b401c165b2$f981ec30$3501010a@ltc.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have a small prototype board with a mips 4kc on it and I have linux 
running. I have to megs of sram mapped how do i map in sdram ?

the memory map looks like

0000.0000 - 0001f.ffff 2M SRAM
0020.0000 - 0020.1fff 8K Embedded SRAM CPU
0020.2000 - 002f.fffff reserved
0030.0000 - 0030.ffff 64K Chip registers
0031.0000 - 00ff.ffff reserved
0100.0000 - 01ff.ffff 16M SDRAM
0200.0000 - 1fb0.ffff SDRAM
1fc0.0000 - 1fdf.ffff 2M ROM / FLASH
0060.0000 - ffff.ffff SDRAM

how do I get linux to read this 16M SDRAM @ 0100.000 - 01ff.ffff ? Then 
how do I get linux to read RAM @ 0200.000 - 1fb0.ffff and 0060.000 - 
ffff.ffff ?

We have our own load which is loading linux from ROM, and we can pass 
arg to linux, can the memory be set as an argument passed ?

Thanks for you help

Warren Hardy
