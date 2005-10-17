Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2005 14:43:00 +0100 (BST)
Received: from paris5.amen.fr ([62.193.203.10]:48905 "EHLO paris5.amen.fr")
	by ftp.linux-mips.org with ESMTP id S8133579AbVJQNmm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2005 14:42:42 +0100
Received: from firewall (77.237.98-84.rev.gaoland.net [84.98.237.77])
	by paris5.amen.fr (8.10.2/8.10.2) with ESMTP id j9HDgfB14271;
	Mon, 17 Oct 2005 15:42:41 +0200
Message-ID: <4353A98C.80508@avilinks.com>
Date:	Mon, 17 Oct 2005 15:39:24 +0200
From:	Yoann Allain <yallain@avilinks.com>
Organization: Avilinks
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: sti() freezes the kernel
References: <4353656E.8070601@avilinks.com> <20051017131047.GF4884@linux-mips.org>
In-Reply-To: <20051017131047.GF4884@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <yallain@avilinks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yallain@avilinks.com
Precedence: bulk
X-list: linux-mips


Ralf Baechle a écrit :

>On Mon, Oct 17, 2005 at 10:48:46AM +0200, Yoann Allain wrote:
>
>  
>
>>I'm actually trying to start a 2.4 kernel on our new card.
>>The kernel freezes when enabling interrupts with sti() in start_kernel() 
>>(just before calculating BogoMips...).
>>This looks like an interrupts is up when enabling so that it stops the 
>>MIPS and freezes the kernel.
>>I'm looking after this interrupt but I would like to know if there could 
>>be any others reasons for my kernel to freeze when doing a call to sti();
>>    
>>
>
>This is a fairly scenario and as you suspect it's being caused by interrupt
>problems, such as interrupts still pending from the firmware, being
>not initialized at all or similar.
>
>  Ralf
>  
>
Since last mail I played with the interrupt masks (IM - bits 15-8 in 
MIPS status register) . From the MIPS cause register, it seems that the 
bit 15 (hardware interrupt 5 or timer interrupt) is the originator of 
the freezing interrupt. And the exception code shown for this interrupt 
is 6 corresponding to a Bus error exception. I think there's a pointer 
to the interrupt handler not correctly initialized. So that the 
interrupt makes a jump to nowhere.
The Bus monitors are not enabled, this is perhaps why the kernel freezes 
instead of printing the details of the exception.

Am I right?
