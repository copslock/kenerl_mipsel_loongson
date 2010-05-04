Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 20:56:06 +0200 (CEST)
Received: from gateway05.websitewelcome.com ([69.93.35.13]:57093 "HELO
        gateway05.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492629Ab0EDS4C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 20:56:02 +0200
Received: (qmail 20699 invoked from network); 4 May 2010 18:58:10 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway05.websitewelcome.com with SMTP; 4 May 2010 18:58:10 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=fa6Kd8HQeoARhSGLrt7I+R57lCSZnyyq1NFsMsVHuAsMPRYAkU2nvICGnQdJQ1Y1qQeQ/Cu5TgJ8iBNpnfTP9Xr7NXXImEbwIeb0VUjW5oBpDiZTOn21CUZvIcBPk0V9;
Received: from 216-239-45-4.google.com ([216.239.45.4]:55985 helo=epiktistes.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1O9NHa-0008D6-JS; Tue, 04 May 2010 13:55:50 -0500
Message-ID: <4BE06DBF.3070409@paralogos.com>
Date:   Tue, 04 May 2010 11:55:59 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100317)
MIME-Version: 1.0
To:     Shane McDonald <mcdonald.shane@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Unexpected behaviour when catching SIGFPE on FPU-less system
References: <E1O8lDn-0000Sk-86@localhost> <4BDF366E.5000501@paralogos.com>       <k2hb2b2f2321005031843l87f39f36h960153cae3ec5020@mail.gmail.com>        <4BDF8092.1060401@paralogos.com>        <n2pb2b2f2321005032049h56cd72ceh3ac7120c547b59c5@mail.gmail.com>        <n2rb2b2f2321005032135ze807a2aft8811a7937288de53@mail.gmail.com>        <m2rb2b2f2321005032356j854934d9v42a9e50683b085a8@mail.gmail.com>        <4BE00207.6030506@paralogos.com> <m2zb2b2f2321005040556g80eed954p7ac11e2cd05921c6@mail.gmail.com> <4BE0479E.6060506@paralogos.com>
In-Reply-To: <4BE0479E.6060506@paralogos.com>
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
X-archive-position: 26582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:
> Shane McDonald wrote:
>   
>> In the following chunk of code from cp1emu.c:
>>   
>>     
> [snip]
>   
>> value gets set to an initial value of 0x400, and ctx->fcr31
>> comes in with an initial value of 0x8420.
>> By the time we hit the if statement around the return SIGFPE, ctx->fcr31
>> has been set to 0x8400, not the 0x400 I implied.
>>   
>>     
> Ah, well that would rather change things, and you *would* get an
> exception there.  As written, the code doesn't seem to allow the pending
> exception (.._X) bits to be cleared by the CTC.
>   
>> Nevertheless, that's not the problem.  
>>     
> Maybe it is.  I don't have my MIPS specs handy anymore, but just what is
> supposed to clear a pending exception bit in a real FPU?
>   
 From old-ish MIPS32 specs out there on the web, it looks like the 
emulator was doing the right thing in raising the exception - it's 
specifically called out in the CTC1 definition that writing a value with 
both a Cause and an Enable (_X and _E) bit set will throw an exception.  
The question is:  Why wasn't the Cause bit cleared?  As I mentioned last 
night, in current kernels running on a real FPU, it gets cleared as part 
of the assembly-language preamble to servicing a FPU exception, a path 
which is definitely not taken in the emulator case, which is driven by 
coprocessor unusable exceptions.   So now I'm actually confused by two 
things:  One is where the emulator *should* have its _X flags cleared, 
and the other is how the current kernel/signal code communicates the 
nature of a floating point exception to the user.  I had thought that 
either we had a model where a SIGFPE signal carried the FPCR bits as 
part of its payload (something I've done for other architectures and 
could have sworn I'd done for MIPS at one point or another), or that the 
signal handler can inspect the FPCR to know what kind of exception it 
was.  As near as I can tell, when there's a real FPU, we wipe out the 
evidence before we save the context.

          Regards,

          Kevin K.
