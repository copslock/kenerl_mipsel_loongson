Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 04:04:28 +0200 (CEST)
Received: from gateway05.websitewelcome.com ([69.93.179.12]:47573 "HELO
        gateway05.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492540Ab0EDCEX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 04:04:23 +0200
Received: (qmail 26250 invoked from network); 4 May 2010 02:06:29 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway05.websitewelcome.com with SMTP; 4 May 2010 02:06:29 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=woJOuJBQaK+J8aUq0puw0ZRYAFcHkF3lC9LNLJkbza8f8VlU2oAe2juzIsZRS2nZv/dBxDPZPqnMwx3OkYEXR0WL2+aADzC2CJuimEGiFr8lSQVw/iOV2vuueHnELRAy;
Received: from 216-239-45-4.google.com ([216.239.45.4]:19275 helo=epiktistes.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1O97UE-0000qg-5m; Mon, 03 May 2010 21:03:50 -0500
Message-ID: <4BDF8092.1060401@paralogos.com>
Date:   Mon, 03 May 2010 19:04:02 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100317)
MIME-Version: 1.0
To:     Shane McDonald <mcdonald.shane@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Unexpected behaviour when catching SIGFPE on FPU-less system
References: <E1O8lDn-0000Sk-86@localhost> <4BDF366E.5000501@paralogos.com> <k2hb2b2f2321005031843l87f39f36h960153cae3ec5020@mail.gmail.com>
In-Reply-To: <k2hb2b2f2321005031843l87f39f36h960153cae3ec5020@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Shane McDonald wrote:
> Hi Kevin:
>
> On Mon, May 3, 2010 at 2:47 PM, Kevin D. Kissell <kevink@paralogos.com> wrote:
>   
>> Sorry about my previous message having escaped with no value added.
>>
>> I think you need to look at just what it is that your feclearexcept() does.
>>  From the strace information, it looks as if it may be that the FPU emulator
>> is erroneously throwing an exception in response to some manipulation of the
>> emulated FPU registers by feclearexcept(), so that it's taking a second FP
>> exception within the signal handler.  That's the simplest explanation for
>> the macroscopic behavior, anyway.
>>
>>         Regards,
>>
>>         Kevin K.
>>     
>
> Commenting out the feclearexcept() line gives the same result:
>
>      old_mmap(NULL, 65536, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ace9000
>      write(1, "About to try calculation\n"..., 25About to try calculation
>      ) = 25
>      --- SIGFPE (Floating point exception) @ 0 (0) ---
>      --- SIGFPE (Floating point exception) @ 0 (0) ---
>      +++ killed by SIGFPE +++
>
> So, it must not be the feclearexcept() causing the problem.
>   
Well, that nested floating point exception must be coming from 
*somewhere*.  If it's not library code being betrayed by the emulator, 
perhaps some kernel-mode code is being invoked which is carelessly 
assuming the existence of a hardware FPU and throwing us back into the 
exception handler. If it was me, at this point, I'd turn on some kind of 
logging of FP exception PCs to see where that second one is coming from.

There was a time when I had the necessary equipment on my desk to hunt 
this down and kill it, out of a lingering sense of responsibility for 
having bolted that FPE into the kernel way back when.  I no longer have 
that setup, so I'm free to speculate. ;o)

          Regards,

          Kevin K.
