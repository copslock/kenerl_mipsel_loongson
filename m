Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2QI6Xk02543
	for linux-mips-outgoing; Tue, 26 Mar 2002 10:06:33 -0800
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2QI6Rq02532
	for <linux-mips@oss.sgi.com>; Tue, 26 Mar 2002 10:06:27 -0800
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id SAA21426;
	Tue, 26 Mar 2002 18:19:38 -0800
Message-ID: <3CA0B924.2030003@mvista.com>
Date: Tue, 26 Mar 2002 10:08:36 -0800
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Y.H. Ku" <iskoo@ms45.hinet.net>
CC: Marc Karasek <marc_karasek@ivivity.com>, linux-mips@oss.sgi.com
Subject: Re: BootLoader on MIPS
References: <NGBBILOAMLLIJMLIOCADOENICCAA.iskoo@ms45.hinet.net>
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Y.H. Ku wrote:

> Ya,
> I have traced the PMON code (www.carmel.com/pmon/) with NEC DDB5476 board (linux package from Montavista),
> (LSI Logic' Software Support Package for MIPS processors version 5.3.33)
> 
> However, though it seem clear that function "_go" of pmon/head.S transfer control to client program
> by "j k0" (a exception)
> BUT I do not understand what information tha PMON transfer to LINUX-MIPS KERNEL
> I found the KERNEL's entry is "kernel_entry" of ~arch/mips/kernel/head.S.
> But, I can not find any information just like "board information" be transferred well.
> where is it!?


"board information" is not transferred to kernel.  However, parameters you
pass (as in "go <param>") are passed in as standard C main argument style.
These are processed in arch/mips/ddb5xxx/common/prom.c file, i.e., held in a0,
a1 registers.

> using sp register with "j k0" command?


No. sp is not meaningful when kernel starts.


> where is the memory setting be transferred?


system ram size?  It is hardcode in ddb5476 code.  See
include/asm/ddb5xxx/ddb5476.h file.


> What MIPS LINUX needed!?


I thought you have montavista linux (probably hardhat 2.0?).


> (PPCBOOT to PPC-LINUX is clear with a board_info struct, initrd_start and initrd_end ... and work well...
> 


PPC booting is more regular than MIPS in general.  So they have a more uniform
 bootup process and structure.  MIPS have a lot of vendors who are usually
very creative.

Jun
