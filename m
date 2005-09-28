Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2005 08:29:21 +0100 (BST)
Received: from paris5.amen.fr ([62.193.203.10]:34059 "EHLO paris5.amen.fr")
	by ftp.linux-mips.org with ESMTP id S8134126AbVI1H3E (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Sep 2005 08:29:04 +0100
Received: from firewall (46.237.98-84.rev.gaoland.net [84.98.237.46])
	by paris5.amen.fr (8.10.2/8.10.2) with ESMTP id j8S7T3v17392
	for <linux-mips@linux-mips.org>; Wed, 28 Sep 2005 09:29:03 +0200
Message-ID: <433A45BD.80408@avilinks.com>
Date:	Wed, 28 Sep 2005 09:26:53 +0200
From:	Yoann Allain <yallain@avilinks.com>
Organization: Avilinks
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Compiling a 2.6 kernel for Mips
References: <BAY101-DAV76EF721B0CFCE85875AC3D28A0@phx.gbl>
In-Reply-To: <BAY101-DAV76EF721B0CFCE85875AC3D28A0@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <yallain@avilinks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yallain@avilinks.com
Precedence: bulk
X-list: linux-mips

Hi,

I am no more a newbie but I still need some help to build kernels :
I am working on the Wintegra Evaluation Board (WEB777) and I used the 
2.4 kernel Wintegra gave me with the patch for that board.
I tried to adapt the patch for the 2.6 kernel but it doesn't work. I 
traced the kernel to find it crashed very early before displaying anything.
In fact the host processor makes an address and tries to read it but 
this makes an exception :

* Exception 0x02 (user) : TLB (load or instruction fetch) *
* in address: 80101ea8
ClockDiv2+0xe38:
[80101ea8] 8c820000 lw          r2,0x0000(r4)


r0(zero): 00000000 r1(AT)  : 1000fc00 r2(v0)  : 0000001c r3(v1)  : 80360000
r4(a0)  : 0000001c r5(a1)  : 803919f0 r6(a2)  : 0000000d r7(a3)  : 8038df8c


I think this is a problem of host processor misconfiguration, but don't 
find out exactly what it is... To make the address in R4, the processor 
reads some zeroes where in 2.4 kernel, it doesn't and the address read 
in 2.4 is something like 0xbf010f1c.
I don't know if this can help but here are the few functions before crash:

kernel_entry
    J start_kernel
             cpu_probe() (WEB777 patch)
             prom_init() (WEB777 patch)
                   setup_prom_printf() (WEB777 patch)
                   wds_prom_printf() (WEB777 patch)
                            putPromChar() (WEB777 patch)
                            --> CRASH


Thanks a lot for your precious advices

Yoann
