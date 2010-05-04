Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 13:17:01 +0200 (CEST)
Received: from gateway11.websitewelcome.com ([67.18.68.8]:60304 "HELO
        gateway11.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492433Ab0EDLQ4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 13:16:56 +0200
Received: (qmail 5285 invoked from network); 4 May 2010 11:20:39 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway11.websitewelcome.com with SMTP; 4 May 2010 11:20:39 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=QhVU7FGiRKW4mfAHKP6wb1PcXj7HR/rnkoi8WiG1YHrQR/SJTrYg2+1mLwf7KN/tnSTVsuErssGVz3UUX9q1BApMDjPusJYYYQWu/QzTJFbv4sMH5E3Tqw8V5p75iYaL;
Received: from c-98-207-157-135.hsd1.ca.comcast.net ([98.207.157.135]:3093 helo=[127.0.0.1])
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1O9G78-0000EF-FS; Tue, 04 May 2010 06:16:34 -0500
Message-ID: <4BE00207.6030506@paralogos.com>
Date:   Tue, 04 May 2010 04:16:23 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     Shane McDonald <mcdonald.shane@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Unexpected behaviour when catching SIGFPE on FPU-less system
References: <E1O8lDn-0000Sk-86@localhost> <4BDF366E.5000501@paralogos.com>         <k2hb2b2f2321005031843l87f39f36h960153cae3ec5020@mail.gmail.com>         <4BDF8092.1060401@paralogos.com>         <n2pb2b2f2321005032049h56cd72ceh3ac7120c547b59c5@mail.gmail.com>         <n2rb2b2f2321005032135ze807a2aft8811a7937288de53@mail.gmail.com> <m2rb2b2f2321005032356j854934d9v42a9e50683b085a8@mail.gmail.com>
In-Reply-To: <m2rb2b2f2321005032356j854934d9v42a9e50683b085a8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
X-archive-position: 26572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Shane McDonald wrote:
> OK, I think I've found the line that's causing me the problem.
>
> On Mon, May 3, 2010 at 10:35 PM, Shane McDonald
> <mcdonald.shane@gmail.com> wrote:
>   
>> On Mon, May 3, 2010 at 9:49 PM, Shane McDonald <mcdonald.shane@gmail.com> wrote:
>>     
>>> Looking at env[0], I see that the __fpc_csr field has a value of 1024,
>>> indicating a divide-by-zero.  As soon as that ctc1 instruction
>>> is executed, the exception is raised.  I guess that makes
>>> sense, but I don't understand why __fpc_csr has a value of 1024.
>>> When I step through the call to setjmp(), it gets set to a value of 0.
>>> In longjmp(), every other field in env[0] has the value that it was
>>> set to in the call to setjmp().
>>>       
>> Wait, I take that back -- I was looking at the wrong env[0] variable!
>> I can see that __fpc_csr actually does have a value of 1024 when
>> I call setjmp(), and that's why longjmp() is setting the FCSR
>> register to indicate divide-by-zero.  If I comment out my call to
>> feenableexcept( FE_DIVBYZERO ), it is set to 0; if I include that call,
>> it is set to 1024.
>>
>> Looking further, I also see that I confused the Cause bits and the
>> Enable bits of the FCSR -- the Enable divide-by-zero bit is set,
>> not the Cause bit.  Clearly, the call to feenableexcept() must
>> be setting that bit.  But, it no longer makes sense that an exception
>> is raised when the FCSR register is restored to the value 1024.
>>     
>
> When I'm inside my handler, I see the FCSR register has the value 0x8420,
> indicating that the Z bit is set in each of the Cause, Enables, and Flags
> fields.  When longjmp() is called, it tries to write the old FCSR value
> of 0x400 (just the Z bit of the Enables field).  In the emulation code,
> at lines 392 - 394 of file cp1emu.c, is the code:
>
>     if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E) {
>             return SIGFPE;
>     }
>
> Given the original FCSR value of 0x8420 and the new value to set
> of 0x400, the Z bit of the Cause field is still set, and as a result, the
> above code causes the SIGFPE exception to be thrown.
>   
That's not how I read the code.  If ctx->fcr31 is 0x400, then the result
of the AND should be zero.
> Now that I've figured that out, I have to admit that I don't know
> if the emulator has the proper behaviour, or if not, what the fix is.
> Kevin, what do you think?
>   
I don't know where the bug is, but it doesn't look to be here.  I wonder
if someone hasn't added some code somewhere that does an extra
save/restore of the FCSR from the kernel stack, so that the explicit
write to clear the exception is undone by the restore from the stack
being emulated.  I note that there's a __build_clear_fpe macro that now
appears to clear the status bits of a real FPU on entry to the FPU
exception handler, but that there's nothing analogous which clears the
bits of the emulated register file in the emulated exception case -
because, after all, there's no new exception, just an invocation of
signal logic within the coprocessor unavailable handling of the
emulator.  That's presumably the cause of the different values you see
in the signal handlers, and very possibly a reason why we only see the
failure with the emulator.

I don't remember the name of the thing, but when I was with MIPS, there
was an old gradware test program that we used to test IEEE compliance of
the FPU and emulator.  Does this still pass with the emulator on the
kernels showing this bug?  If it does, the problem is subtle and the
test needs to be enhanced.  If it doesn't, whoever wrenches on anything
to do with the FPU in the kernel should really be running it before
committing.

          Regards,

          Kevin K.
