Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 23:52:12 +0200 (CEST)
Received: from gateway09.websitewelcome.com ([69.93.82.29]:59493 "HELO
        gateway09.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492152Ab0EDVwJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 23:52:09 +0200
Received: (qmail 14289 invoked from network); 4 May 2010 21:55:13 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway09.websitewelcome.com with SMTP; 4 May 2010 21:55:13 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=AcCaa/e/Tmr3PuLkyBa92NB5xPEyotIvu7OGlhxT/z2wFW5sx8utmcYlkRHFyOVqpAI3xLAZeimOtpakCjKeL70AiLCV3ZBBGSHz4h29gKnMlHA+iFfr2kBrXCiKOaye;
Received: from 216-239-45-4.google.com ([216.239.45.4]:19064 helo=epiktistes.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1O9Q1z-0002C2-0M; Tue, 04 May 2010 16:51:55 -0500
Message-ID: <4BE09705.6030705@paralogos.com>
Date:   Tue, 04 May 2010 14:52:05 -0700
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
X-archive-position: 26589
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
> Maybe it is. 
OK, sorry to have been looking at this in fits and starts, but indeed, I 
submit that the bug is indeed in that ctc_op:  case of the emulator.  
The Cause bits (17:12) are supposed to be writable by that instruction, 
but the CTC1 emulation won't let them be updated by the instruction.  I 
don't have the means to generate, test, and submit a proper patch, but I 
think that actually if you just completely removed lines 387-388:


value &= (FPU_CSR_FLUSH | FPU_CSR_ALL_E | FPU_CSR_ALL_S | 0x03);
ctx->fcr31 &= ~(FPU_CSR_FLUSH | FPU_CSR_ALL_E | FPU_CSR_ALL_S |0x03);

Things would work a good deal better.  At least, it would be a more 
accurate emulation of the architecturally defined FPU.  If I wanted to 
be really, really
pedantic (which I sometimes do), I'd also protect the reserved bits that 
aren't necessarily writable, so we'd nuke those two lines, then have

/* Don't write reserved bits, and convert to ieee library modes */
ctx->fcr31 = (value & ~0x1c0003) | ieee_rm[value & 0x3];

Note that I've changed the existing |= to a direct assignment here.

Hope this helps.

/K.
