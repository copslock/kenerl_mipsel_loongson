Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 21:44:45 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:58808 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492716Ab0EDTom convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 May 2010 21:44:42 +0200
Received: by wyg36 with SMTP id 36so2378341wyg.36
        for <multiple recipients>; Tue, 04 May 2010 12:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=t1XZyxvIaEfsAQkmISyfvc95YDouLNsMQa8ElGADFs0=;
        b=qankxMMsmgt3t4wyIXD7pCDFn0W8w8HQQrLdJlOQp87nFeRmG4heZnhGNArS0pETtM
         L7VF2wNxLYhzm4RGvklrCzuLazb9YXI5ypcQEE+46k3dd97ircrk0Kh8XExUu2TL4Isy
         oxdeuFXsO5b70YjJ99JIw8uGLPxHJt2f6eY9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=LLr+qV0D/gSXIZRSaJeQ9Pz3ImeoRhxslnKZebPqCRcb1vfvH8wKhtOGT80FS3CNVn
         eiHd3qS5VADC++MdlabUZFYXtV6EnNAcNDG+NlM90cYSDTyulBO0pPEhxaWq9TTz7I7e
         SsTZCf+5lfLI7Fx4Xnlbx6gfE8pjMdBCzDvao=
MIME-Version: 1.0
Received: by 10.216.85.70 with SMTP id t48mr2005289wee.59.1273002274577; Tue, 
        04 May 2010 12:44:34 -0700 (PDT)
Received: by 10.216.93.131 with HTTP; Tue, 4 May 2010 12:44:34 -0700 (PDT)
In-Reply-To: <h2yf861ec6f1005041230p80a664e6o51296c106853d3fc@mail.gmail.com>
References: <E1O8lDn-0000Sk-86@localhost>
         <n2pb2b2f2321005032049h56cd72ceh3ac7120c547b59c5@mail.gmail.com>
         <n2rb2b2f2321005032135ze807a2aft8811a7937288de53@mail.gmail.com>
         <m2rb2b2f2321005032356j854934d9v42a9e50683b085a8@mail.gmail.com>
         <4BE00207.6030506@paralogos.com>
         <m2zb2b2f2321005040556g80eed954p7ac11e2cd05921c6@mail.gmail.com>
         <4BE0479E.6060506@paralogos.com>
         <20100504184457.GA21929@linux-mips.org>
         <k2s10f740e81005041228pea323400u89dfcefd4a5047d0@mail.gmail.com>
         <h2yf861ec6f1005041230p80a664e6o51296c106853d3fc@mail.gmail.com>
Date:   Tue, 4 May 2010 21:44:34 +0200
X-Google-Sender-Auth: e5c6875f379b105b
Message-ID: <s2x10f740e81005041244na95dd7c9j84fa03bac94818f@mail.gmail.com>
Subject: Re: Unexpected behaviour when catching SIGFPE on FPU-less system
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Kevin D. Kissell" <kevink@paralogos.com>,
        Shane McDonald <mcdonald.shane@gmail.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, May 4, 2010 at 21:30, Manuel Lauss <manuel.lauss@googlemail.com> wrote:
> On Tue, May 4, 2010 at 9:28 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Tue, May 4, 2010 at 20:44, Ralf Baechle <ralf@linux-mips.org> wrote:
>>> On Tue, May 04, 2010 at 09:13:18AM -0700, Kevin D. Kissell wrote:
>>>
>>>> What we used to use was what I *thought* was an old public domain
>>>> program whose name was an English word that had something to do with
>>>> being exacting.  Googling with obvious keywords didn't turn it up.
>>>
>>> Is it paranoia by any chance?  Paranoia is available as single files at:
>>>
>>>  http://www.math.utah.edu/~beebe/software/ieee/paranoia.c
>>>  http://www.math.utah.edu/~beebe/software/ieee/paranoia.h
>>
>> You also need
>>
>> http://www.math.utah.edu/~beebe/software/ieee/args.h
>>
>> Ran fine on:
>>  - Toshiba RBTX4927 (with FPU :-)
>>  - Mikrotik RouterBOARD 150 (without FPU), using an older 2.6.x OpenWRT kernel
>
> and runs into an endless loop around line 806 when built with
> a softfloat toolchain (gcc-4.4.3).

I used my kernel cross-toolchain (gcc version 4.1.2 20061115
(prerelease) (Ubuntu 4.1.1-21)),
with Debian libs, and -static to make it run on the RB150.

I retried with the OpenWRT toolchain (also 4.1.2, presumably
softfloat) I had still lying around,
and it worked, too. I got small differences in the last 2 digits,
though, so I guess it actually is
softfloat.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
