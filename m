Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 21:07:14 +0200 (CEST)
Received: from gateway04.websitewelcome.com ([67.18.1.2]:39346 "HELO
        gateway04.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492723Ab0EFTHI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 21:07:08 +0200
Received: (qmail 3707 invoked from network); 6 May 2010 19:10:40 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway04.websitewelcome.com with SMTP; 6 May 2010 19:10:40 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=tzVbIVbsSzasHANvdAj88J9U1iu44w/pBboxw8xAezPKfLyiOrFXE4u0Xkly8JVGCqpFCW1SD9THj3SOBqX2QiiWCD1oyThu/7D2TINh5Rubod619DRI9X7Rtiz/JL78;
Received: from 216-239-45-4.google.com ([216.239.45.4]:50575 helo=epiktistes.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1OA6PK-00031V-Lr; Thu, 06 May 2010 14:06:55 -0500
Message-ID: <4BE31353.2030007@paralogos.com>
Date:   Thu, 06 May 2010 12:06:59 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100317)
MIME-Version: 1.0
To:     Shane McDonald <mcdonald.shane@gmail.com>
CC:     Sergei Shtylyov <sshtylyov@mvista.com>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [MIPS] FPU emulator: allow Cause bits of FCSR to be writeable
 by     ctc1
References: <4BE122D1.3000609@paralogos.com>     <20100505091159.GA4016@linux-mips.org>  <4BE19214.4010209@paralogos.com>        <20100506.012240.118951273.anemo@mba.ocn.ne.jp>         <4BE1C4EA.1020202@paralogos.com> <4BE2A6EE.80705@mvista.com>    <4BE2E445.5050809@paralogos.com> <o2yb2b2f2321005061142v431dbc78n2a21722676a72501@mail.gmail.com>
In-Reply-To: <o2yb2b2f2321005061142v431dbc78n2a21722676a72501@mail.gmail.com>
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
X-archive-position: 26638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Shane McDonald wrote:
> On Thu, May 6, 2010 at 9:46 AM, Kevin D. Kissell <kevink@paralogos.com> wrote:
>   
>> Sergei Shtylyov wrote:
>>     
>>> Kevin D. Kissell wrote:
>>>
>>>       
>>>> I'm cool with the patch as is, but in the general spirit of regarding
>>>> numeric constants other than 0 and 1 as instruments of Satan, it
>>>> would probably be even better if those reserved bits were defined
>>>> (FPU_CSR_RSVD, or whatever is compatible with existing convention for
>>>> such bits) along with the other FCSR bit masks in mipsregs.h, so that
>>>> the assigment looks like:
>>>>
>>>>          ctx->fcr31 = (value & ~(FPU_CSR_RSVD | 0x3)) |
>>>>                   ieee_rm[value & 0x3];
>>>>         
>>>   0x3 is still neither 0 nor 1, and so remains an instrument of Satan.
>>> How about #defining it also? :-)
>>>       
>> In some software engineering cultures, that would be considered a good
>> idea or even mandatory.  This being the Linux kernel, I think it's OK,
>> because, as Shane remarked, it's a mask that's local to the module and
>> whose value is "obvious", and such things are pretty commonly handled as
>> numeric constants in the kernel.
>>
>> There actually *is* a #define for that field, FPU_CSR_RD, which could be
>> used here in place of the 0x3, but I'm a little torn about its use.  On
>> one hand "value & ~(FPU_CSR_RSVD | FPU_CSR_RD)" is more clear about what
>> we're doing, but on the other hand, it's less obvious that "value &
>> FPU_CSR_RD" is generating an integer in the range 0-3 for an index.  So
>> I'm absolutely fine with the code as written, but wouldn't complain if
>> someone wanted to make it use the symbolic constant.
>>     
>
> I'm torn here, which is why I hadn't changed that at all.  I'd rather not
> use FPU_CSR_RD, because that defines a value in the rounding mode
> bits (which happens to have all the bits set), rather than a mask for the
> bits.  I'd prefer to define a new constant FPU_CSR_RM with the
> value 0x00000003 -- a better name might be FPU_CSR_RM_MASK,
> but that's inconsistent with the names of the other FCSR fields.
> And, as Kevin said, it doesn't make it clear that we're trying to generate
> an index in the range of 0 - 3.  I guess we could also define a constant
> for the number of bits to shift to get the RM bits into the low order bits,
> something like
>
> #define FPU_CSR_RM_SHIFT 0
>
> at which point our code could look like
>
> ctx->fcr31 = (value & ~(FPU_CSR_RSVD | FPU_CSR_RM)) |
>                    ieee_rm[(value & FPU_CSR_RM) >> FPU_CSR_RM_SHIFT];
>
> I'm a little wary of adding the FPU_CSR_RM_SHIFT, because there aren't
> any other SHIFT defines for the FCSR, and because the shift value is 0.
> But, the above code doesn't look as bad as I originally thought it would,
> and it probably is clearer.
>
> Comments?
>   
I agree with Ralf's suggestion to make the further cleanup
a separate patch.  Since there isn't a precedent for having
shift counts for the FCSR fields, another option would be
to define a macro, let's call it modeindex() for the sake of
the argument, that's defined wherever ieee_rm is declared,
and which converts an FCSR value into the index:

#define modeindex(v) ((v) & FPU_CSR_RM)

Then the actual code in cop1emu.c could look like:

    ctx->fcr31 = (value & ~(FPU_CSR_RSVD | FPU_CSR_RM)) |
                                   ieee_rm[modeindex(value)];

Which is pretty clear, has no cursed constants, and doesn't
create a universe of shift counts where the only one we
care about is zero.
> There's also use of the 0x3 magic number in a number of other cases
> in this file. 
If all the others treat it as a mask, then your proposed
FPR_CSR_RM should be fine for them.  If they don't...

          Regards,

          Kevin K.
