Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2004 18:46:24 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:52985 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225352AbUJHRqR>; Fri, 8 Oct 2004 18:46:17 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 111CA18553; Fri,  8 Oct 2004 10:46:15 -0700 (PDT)
Message-ID: <4166D266.8050308@mvista.com>
Date: Fri, 08 Oct 2004 10:46:14 -0700
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rg_Hagedorn?= <Joerg.Hagedorn1@epost.de>
Cc: linux-mips@linux-mips.org
Subject: Re: vr4131 and time.c Kernel 2.4.27
References: <200410081938.22930.Joerg.Hagedorn1@epost.de>
In-Reply-To: <200410081938.22930.Joerg.Hagedorn1@epost.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello !

You may have already done this, but is arch/mips/kernel/time.c compiled 
in the kernel? This file contains the functions time_init and 
`do_gettimeofday'

Thanks
Manish Lachwani



Jörg Hagedorn wrote:

>Dear all,
>I try to port the mips kernel to a vr4131 based pda. I have started from the 
>tanbac board 226 but now I got the following message
>
>init/main.o: In function `start_kernel':
>init/main.o(.text.init+0x50c): undefined reference to `time_init'
>kernel/kernel.o: In function `sys_time':
>kernel/kernel.o(.text+0x90c0): undefined reference to `do_gettimeofday'
>kernel/kernel.o: In function `sys_gettimeofday':
>....
>
>Before I start with my modifications I did not get this message. What is the 
>reason why the compiler did not find the complete time environment.
>
>Many thanks
>Joerg
>
>
>
>__________________________________________
>www.messezimmer-duesseldorf.de
>www.messezimmer-essen.de
>www.zedernweg.de
>
>
>
>  
>
