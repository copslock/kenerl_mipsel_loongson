Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 08:57:06 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:44598 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491874Ab0EDG5C convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 May 2010 08:57:02 +0200
Received: by vws8 with SMTP id 8so850541vws.36
        for <linux-mips@linux-mips.org>; Mon, 03 May 2010 23:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=37J2d+2MKoHFaK6wvRgL00P3aoH2Lkp+yBGosmFQ+ow=;
        b=WgzrHhTa5rkyGP4H5YjclyxfX2T3SVdH4UmskP1VV9XrtWO1Gsv/aIKWg5KpddgWlx
         WFBUWkHfOwWfSnjs/b2+ie9QOnv+hxdCUp1U8p6enEfR6jrYcYYQD8MKZLwWjlEdbyGQ
         C3h48UuwAZnd1JTyqaQq8ZN4zTRjx2poqpzSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=K+6IM7jOiDHcSTsaiKLptNxhZqnGvkpTulvvFEXgo32HrOqSZ6ClQ3IVmP7WciZjGS
         ccVkpBdFTwN4eLeyRVF4Gof9l8y5UCQ751LK+WvNz59BxzwKiI/xbUovRePNAq6ATHvG
         mIjTwr/k8TCDqac1e9Jxf7SG6U2CFAkYnVJo4=
MIME-Version: 1.0
Received: by 10.220.129.14 with SMTP id m14mr394066vcs.75.1272956216146; Mon, 
        03 May 2010 23:56:56 -0700 (PDT)
Received: by 10.220.19.212 with HTTP; Mon, 3 May 2010 23:56:56 -0700 (PDT)
In-Reply-To: <n2rb2b2f2321005032135ze807a2aft8811a7937288de53@mail.gmail.com>
References: <E1O8lDn-0000Sk-86@localhost> <4BDF366E.5000501@paralogos.com>
         <k2hb2b2f2321005031843l87f39f36h960153cae3ec5020@mail.gmail.com>
         <4BDF8092.1060401@paralogos.com>
         <n2pb2b2f2321005032049h56cd72ceh3ac7120c547b59c5@mail.gmail.com>
         <n2rb2b2f2321005032135ze807a2aft8811a7937288de53@mail.gmail.com>
Date:   Tue, 4 May 2010 00:56:56 -0600
Message-ID: <m2rb2b2f2321005032356j854934d9v42a9e50683b085a8@mail.gmail.com>
Subject: Re: Unexpected behaviour when catching SIGFPE on FPU-less system
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

OK, I think I've found the line that's causing me the problem.

On Mon, May 3, 2010 at 10:35 PM, Shane McDonald
<mcdonald.shane@gmail.com> wrote:
> On Mon, May 3, 2010 at 9:49 PM, Shane McDonald <mcdonald.shane@gmail.com> wrote:
>> Looking at env[0], I see that the __fpc_csr field has a value of 1024,
>> indicating a divide-by-zero.  As soon as that ctc1 instruction
>> is executed, the exception is raised.  I guess that makes
>> sense, but I don't understand why __fpc_csr has a value of 1024.
>> When I step through the call to setjmp(), it gets set to a value of 0.
>> In longjmp(), every other field in env[0] has the value that it was
>> set to in the call to setjmp().
>
> Wait, I take that back -- I was looking at the wrong env[0] variable!
> I can see that __fpc_csr actually does have a value of 1024 when
> I call setjmp(), and that's why longjmp() is setting the FCSR
> register to indicate divide-by-zero.  If I comment out my call to
> feenableexcept( FE_DIVBYZERO ), it is set to 0; if I include that call,
> it is set to 1024.
>
> Looking further, I also see that I confused the Cause bits and the
> Enable bits of the FCSR -- the Enable divide-by-zero bit is set,
> not the Cause bit.  Clearly, the call to feenableexcept() must
> be setting that bit.  But, it no longer makes sense that an exception
> is raised when the FCSR register is restored to the value 1024.

When I'm inside my handler, I see the FCSR register has the value 0x8420,
indicating that the Z bit is set in each of the Cause, Enables, and Flags
fields.  When longjmp() is called, it tries to write the old FCSR value
of 0x400 (just the Z bit of the Enables field).  In the emulation code,
at lines 392 - 394 of file cp1emu.c, is the code:

    if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E) {
            return SIGFPE;
    }

Given the original FCSR value of 0x8420 and the new value to set
of 0x400, the Z bit of the Cause field is still set, and as a result, the
above code causes the SIGFPE exception to be thrown.

Now that I've figured that out, I have to admit that I don't know
if the emulator has the proper behaviour, or if not, what the fix is.
Kevin, what do you think?

Shane
