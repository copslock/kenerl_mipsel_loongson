Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 13:45:56 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:20154 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133764AbWEDMpo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 13:45:44 +0100
Received: (qmail 24665 invoked from network); 4 May 2006 16:50:43 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 4 May 2006 16:50:43 -0000
Message-ID: <4459F72D.4010408@ru.mvista.com>
Date:	Thu, 04 May 2006 16:44:29 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Rodolfo Giometti <giometti@linux.it>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Physical addresses fix for au1x00 serial driver
References: <20060504101112.GC19913@gundam.enneenne.com>
In-Reply-To: <20060504101112.GC19913@gundam.enneenne.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Rodolfo Giometti wrote:

> here:
> 
>    http://ftp.enneenne.com/pub/misc/au1100-patches/linux/patch-au1x00-serial-phys-addr

> a little patch (against «linux-2.6.16-stable» branch and tested on
> au1100 based board) to fix the addresses specification for the serial
> driver. With this patch at boot time we get:

>    Serial: 8250/16550 driver $Revision: 1.90 $ 3 ports, IRQ sharing disabled       
>    serial8250.7: ttyS0 at MMIO 0x11100000 (irq = 0) is a 16550A                    
>    serial8250.7: ttyS1 at MMIO 0x11200000 (irq = 1) is a 16550A                    
>    serial8250.7: ttyS2 at MMIO 0x11400000 (irq = 3) is a 16550A                    

    I have already noticed and fixed this. The fix is in Andrew Morton's tree 
(unpublished yet). See this msg for the patch:

http://www.linux-mips.org/archives/linux-mips/2006-04/msg00029.html

 >    wwpc:~# cat /proc/iomem 

 >    10100000-10200000 : au1xxx-ohci.0 

 >    10500000-1050ffff : eth-base 

 >    10520000-10520003 : eth-mac 

 >    11100000-1110001f : serial 

 >    11200000-1120001f : serial 

 >    11400000-1140001f : serial 


    This is not quite correct. The UARTs take up 1 MB of memory each.

> Ciao,
> 
> Rodolfo

WBR, Sergei
