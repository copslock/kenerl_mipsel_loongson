Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 May 2010 21:20:19 +0200 (CEST)
Received: from gateway12.websitewelcome.com ([69.93.243.6]:48851 "HELO
        gateway12.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492428Ab0EETUP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 May 2010 21:20:15 +0200
Received: (qmail 21082 invoked from network); 5 May 2010 19:23:18 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway12.websitewelcome.com with SMTP; 5 May 2010 19:23:18 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=S7T5NXASQ2ttYMgdjbb4sw0S2dLAL1Q2EVFyD0IJv2AWveWviGFu6LqPXu0l3PO8p6z1UYqV45sZaAvg7LalIIZYGQZTcNROWyCIGQQGdTkN3aQIemnxz0oSyiPO6342;
Received: from 216-239-45-4.google.com ([216.239.45.4]:39454 helo=epiktistes.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1O9k8Y-0000Dw-75; Wed, 05 May 2010 14:20:02 -0500
Message-ID: <4BE1C4EA.1020202@paralogos.com>
Date:   Wed, 05 May 2010 12:20:10 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100317)
MIME-Version: 1.0
To:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:     ralf@linux-mips.org, mcdonald.shane@gmail.com,
        linux-mips@linux-mips.org
Subject: Re: [MIPS] FPU emulator: allow Cause bits of FCSR to be writeable
 by ctc1
References: <4BE122D1.3000609@paralogos.com>    <20100505091159.GA4016@linux-mips.org>  <4BE19214.4010209@paralogos.com> <20100506.012240.118951273.anemo@mba.ocn.ne.jp>
In-Reply-To: <20100506.012240.118951273.anemo@mba.ocn.ne.jp>
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
X-archive-position: 26606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Wed, 05 May 2010 08:43:16 -0700, "Kevin D. Kissell" <kevink@paralogos.com> wrote:
>   
>>>> I'm glad to hear that the patch is functional.  It was pretty clear that
>>>> it would solve your problem, but I was concerned that the inability to
>>>> write the Cause bits was done as a way around some other problem. 
>>>> Someone went to a certain amount of trouble to not accept them as
>>>> inputs, in violation of spec.  I just looked back, and the bug was
>>>> introduced as part of a patch of Ralf's from April 2005 entitled "Fix
>>>> Preemption and SMP problems in the FP emulator".  It's unlikely that
>>>> overriding CTC semantics actually fixed any underlying problems, but it
>>>> may have masked symptoms of problems that we can only hope have been
>>>> fixed in the mean time. Anyone run this patch on an FPUless SMP?   Oh,
>>>> for a 34Kf with a bunch of TCs! ;o)
>>>>         
>>> That's commit ID 72402ec9efdb2ea7e0ec6223cf20e7301a57da02 and the patch
>>> was comitted during the CVS days which only records the comitter but not
>>> the author.  The actual author is Atsushi Nemoto.  
>>>       
>> Well,. I certainly understood that you were simply the guy who did the
>> commit.  Didn't mean to make it sound like an accusation, but it was
>> marginally easier to type your name and date than to find, cut, and
>> paste the commit ID.  Sorry if it came off wrong.  It would be cool if
>> Atsushi remembered the reasoning behind the change, but empirical proof
>> that undoing it doesn't create a subtle problem for current SMP kernels
>> would be better still.
>>     
>
> Yes, that's my patch.  Though I cannot remember precisely, maybe I
> just had (mis)thought Cause bits in FCSR are read-only at that time.
> I have never used real SMP MIPS platforms, so there must be no
> SMP-related issues.
>
> I'm OK with Kevin's fix.  Thank you very much for reporting and
> investigating.
>   
The patch was labeled for "preemption and SMP problems", and if you 
weren't working on an SMP system, I'd guess that you were working with 
full preemption and seeing a problem that you might have assumed was 
also relevant to SMP.  The FPU emulator *shouldn't* have pre-emption 
issues, since it works off of data structures that are instantiated per 
thread context.  The FCSR seen by thread A is logically independent of 
that seen by thread B, so that even if one emulation was preempted in 
the middle by another, they shouldn't be able to interfere with one 
another.  That was the concept, anyway.

I'm cool with the patch as is, but in the general spirit of regarding 
numeric constants other than 0 and 1 as instruments of Satan, it would 
probably be even better if those reserved bits were defined 
(FPU_CSR_RSVD, or whatever is compatible with existing convention for 
such bits) along with the other FCSR bit masks in mipsregs.h, so that 
the assigment looks like:

          ctx->fcr31 = (value & ~(FPU_CSR_RSVD | 0x3)) |
                   ieee_rm[value & 0x3];

That way, in the unlikely event that those reserved bits get 
architecturally assigned, the definition of the field can be changed, 
and that absolute hex mask won't be hardwired and burried in the code to 
screw things up.  If you don't want to touch mipsregs.h, then you should 
consider just using 0x3 as the value mask, and not 0x1c0003 as I 
proposed.  I honestly can't think of any problems that would arise from 
implementing those bits as R/W, even though they aren't in hardware, 
apart from maybe not successfully running AVPs as user-mode Linux binaries.

          Regards,

          Kevin K.
