Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2009 08:39:34 +0000 (GMT)
Received: from aux-209-217-49-36.oklahoma.net ([209.217.49.36]:23814 "EHLO
	proteus.paralogos.com") by ftp.linux-mips.org with ESMTP
	id S20808106AbZCIIj3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Mar 2009 08:39:29 +0000
Received: from [192.168.236.58] ([217.109.65.213])
	by proteus.paralogos.com (8.9.3/8.9.3) with ESMTP id IAA31811;
	Sun, 8 Mar 2009 08:17:21 -0600
Message-ID: <49B4D5BC.5020203@paralogos.com>
Date:	Mon, 09 Mar 2009 03:39:24 -0500
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To:	Nils Faerber <nils.faerber@kernelconcepts.de>
CC:	linux-mips@linux-mips.org
Subject: Re: Ingenic JZ4730 - illegal instruction
References: <49B1510B.8020606@kernelconcepts.de>
In-Reply-To: <49B1510B.8020606@kernelconcepts.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

The only thing that you've mentioned below that really makes me think 
that you're looking at a kernel bug is the comment about things not 
failing under GDB.  But if *any* of the programs that are failing fail 
under gdb, I'd want to know just what instruction is at the place where 
they're taking a SIGILL. If gdb heisenbergs things too much, then the 
basic brute force thing to do would be to instrument the kernel itself 
to report on what happened, and what it sees at the "bad instruction" 
address, using printk.  If the memory value actually looks like a legit 
instruction, it would confirm the hypothesis that you've got an icache 
maintenance problem.  I note that the Ingenic patch has a "flushcaches" 
routine that has hardwired assumptions about the cache organization.  
Could those be incorrect on the chip you're using?

          Regards, and happy hunting,

          Kevin K.

Nils Faerber wrote:
> Hello!
> I am rather playing than really working on a Ingenic JZ4730 based
> device. The JZ4730 is a MIPS32 SOC included in many types of devices,
> like media players and thelike but also in small power efficient
> subnotebooks (this is the device I am trying to support based on the
> Ingebic Linux kernel patch).
>
> The current kernel patch from Ingenic
>
> http://www.ingenic.cn/eng/productServ/App/JZ4730/pfCustomPage.aspx
> or
> ftp://ftp.ingenic.cn/3sw/01linux/02kernel/linux-2.6.24/linux-2.6.24.3-jz-20090218.patch.gz
>
> for the patch (I used an even older patch to start my board support but
> they basically only added newer CPU types in later patches).
>
> The support for my board is almost in place but I see from time to time
> failing applications with "illegal instruction" faults. Most shell
> applications work pretty fine, especially more complex GUI applications
> seem to fail, like a webbrowser or such.
> I also tested this with different GCC and glibc version which makes me
> pretty sure that I am seeing a kernel problem here rather than a
> userspace problem.
>
> I am pretty clueless how to debug this. Apropos debig as another hint:
> Some application work if I start them in GDB but fail outside.
>
> Any hint how to start debugging this would be greatly appreciated! And a
> fix would be like a dream ;)
>
> Many thanks!
>
> Cheers
>   nils faerber
>
>   
