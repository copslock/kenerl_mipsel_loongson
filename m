Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 19:10:47 +0200 (CEST)
Received: from mail-wg0-f50.google.com ([74.125.82.50]:44009 "EHLO
        mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012276AbaJWRKpogeFk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 19:10:45 +0200
Received: by mail-wg0-f50.google.com with SMTP id a1so1586864wgh.33
        for <multiple recipients>; Thu, 23 Oct 2014 10:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=M0AK679KWy4Lhl/b85O5rFrWyEpkfAaUw6DBBdidtkI=;
        b=TQnyrjCVe2K5sP4H0Bip6UVYlhJdZdxTJ/F9JFGUIVd0d83+9Kf30kH62t5y1TpWW+
         aOhiOOT1uVxSDHoJ7nyg5iUs20NgKWUoRhYtLqIinsEdnQxIdv6jGfqn0zpIUEeHnLj9
         BTqK//3O0Jol3nwGu1ie1bNmwF7qLi0Jmk5K5BA4OKaTxljewZAmgMgGHZMhJ0FJqm3R
         TwWNsbt+2SfVfLeWPJLSSOIK25of25IrL0yFgs4RUaj2D8nbVCneN4Y5Mjvuvqv25HE+
         TiaAMb1rrm5WZGAazUYOLrjD8Vvt15D19GyZCIWIwX94XBN+TN/Xz3MkjWMLAxqTxSUC
         Vspw==
X-Received: by 10.180.74.237 with SMTP id x13mr14693409wiv.6.1414084240410;
 Thu, 23 Oct 2014 10:10:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.217.55.200 with HTTP; Thu, 23 Oct 2014 10:10:00 -0700 (PDT)
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235320F31A9C@LEMAIL01.le.imgtec.org>
References: <1413022164-317664-1-git-send-email-manuel.lauss@gmail.com>
 <54491CC4.2060304@imgtec.com> <6D39441BF12EF246A7ABCE6654B0235320F31A9C@LEMAIL01.le.imgtec.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Thu, 23 Oct 2014 19:10:00 +0200
Message-ID: <CAOLZvyHWOmCCKJLKpNL-nu2CXxNDWG53diXH9XxeF-H+XzRP1Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3] MIPS: fix build with binutils 2.24.51+
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
Cc:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, Oct 23, 2014 at 6:21 PM, Matthew Fortune
<Matthew.Fortune@imgtec.com> wrote:
> Markos Chandras <Markos.Chandras@imgtec.com> writes:
>> (top posting so Matthew can see the entire patch)
>>
>> +CC Matthew Fortune who has some comments on the patch.
>>
>> On 10/11/2014 11:09 AM, Manuel Lauss wrote:
>> > diff --git a/arch/mips/include/asm/asmmacro-32.h
>> b/arch/mips/include/asm/asmmacro-32.h
>> > index e38c281..a97ce53 100644
>> > --- a/arch/mips/include/asm/asmmacro-32.h
>> > +++ b/arch/mips/include/asm/asmmacro-32.h
>> > @@ -12,6 +12,9 @@
>> >  #include <asm/fpregdef.h>
>> >  #include <asm/mipsregs.h>
>> >
>> > +   .set push
>> > +   SET_HARDFLOAT
>> > +
>> >     .macro  fpu_save_single thread tmp=t0
>> >     cfc1    \tmp,  fcr31
>> >     swc1    $f0,  THREAD_FPR0_LS64(\thread)
>> > @@ -86,6 +89,8 @@
>> >     ctc1    \tmp, fcr31
>> >     .endm
>> >
>> > +   .set pop
>> > +
>
> Any reason for putting the push/pop outside of the macro here but
> inside the macros elsewhere?

I think I figured I just enclose all float-using macros with this
in one go.  I'll fix it.


>> > diff --git a/arch/mips/include/asm/mipsregs.h
>> b/arch/mips/include/asm/mipsregs.h
>> > index cf3b580..889c012 100644
>> > --- a/arch/mips/include/asm/mipsregs.h
>> > +++ b/arch/mips/include/asm/mipsregs.h
>> > @@ -1324,6 +1324,7 @@ do {
>>       \
>> >  /*
>> >   * Macros to access the floating point coprocessor control registers
>> >   */
>> > +#ifdef GAS_HAS_SET_HARDFLOAT
>> >  #define read_32bit_cp1_register(source)                                    \
>> >  ({                                                                 \
>> >     int __res;                                                      \
>> > @@ -1334,11 +1335,29 @@ do {
>>               \
>> >     "       # gas fails to assemble cfc1 for some archs,    \n"     \
>> >     "       # like Octeon.                                  \n"     \
>> >     "       .set    mips1                                   \n"     \
>> > +   "       .set    hardfloat                               \n"     \
>> >     "       cfc1    %0,"STR(source)"                        \n"     \
>> >     "       .set    pop                                     \n"     \
>> >     : "=r" (__res));                                                \
>> >     __res;                                                          \
>> >  })
>> > +#else
>> > +#define read_32bit_cp1_register(source)                                    \
>> > +({                                                                 \
>> > +   int __res;                                                      \
>> > +                                                                   \
>> > +   __asm__ __volatile__(                                           \
>> > +   "       .set    push                                    \n"     \
>> > +   "       .set    reorder                                 \n"     \
>> > +   "       # gas fails to assemble cfc1 for some archs,    \n"     \
>> > +   "       # like Octeon.                                  \n"     \
>> > +   "       .set    mips1                                   \n"     \
>> > +   "       cfc1    %0,"STR(source)"                        \n"     \
>> > +   "       .set    pop                                     \n"     \
>> > +   : "=r" (__res));                                                \
>> > +   __res;                                                          \
>> > +})
>> > +#endif
>
> This looks fairly ugly. I believe you can just add the hardfloat using:
>
>> >     "       # gas fails to assemble cfc1 for some archs,    \n"     \
>> >     "       # like Octeon.                                  \n"     \
>> >     "       .set    mips1                                   \n"     \
>> > +   "       "STR(SET_HARDFLOAT)"                    \n"     \
>> >     "       cfc1    %0,"STR(source)"                        \n"     \
>> >     "       .set    pop                                     \n"     \
>> >     : "=r" (__res));                                                \
>> >     __res;                                                          \

I didn't know that, thanks!


> The ctc1/cfc1 instructions are quite unusual as they were (before my binutils
> patch) floating point instructions but are general purpose after the patch.
> While that may indicate that you don't need .set hardfloat to use ctc1/cfc1
> that is not true when you consider using a new compiler and/or the
> -Wa,-msoft-float CFLAGS patch with an old assembler. It would therefore be
> wise to test the kernel patch with an assembler which pre-dates my FPXX
> patch to make sure that all instances of ctc1/cfc1 have been caught.

Actually, I did test the patch with 2.24 first, but just with my mips32r1
alchemy target.  I'll try to fix everything, retest and resend.


Thank you,
      Manuel
