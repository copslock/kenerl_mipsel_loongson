Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jan 2011 20:23:24 +0100 (CET)
Received: from gateway01.websitewelcome.com ([69.93.139.19]:46183 "HELO
        gateway01.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1490958Ab1AETXV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jan 2011 20:23:21 +0100
Received: (qmail 9604 invoked from network); 5 Jan 2011 19:22:53 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway01.websitewelcome.com with SMTP; 5 Jan 2011 19:22:53 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=HM6JhP31QDGYGCrZCeCq57wQKYk5IANoTR8HN73SBqoTUvgbxKOIfU90iBzstuMkoTpyh7XrUj1yZX2eMOq3z0DbhyL/XhM1QxES7NA4A9RwWHrHQFpZaenyPCSTVM59;
Received: from [216.239.45.4] (port=34984 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PaYx0-0006Fz-OA; Wed, 05 Jan 2011 13:23:14 -0600
Message-ID: <4D24C525.5000306@paralogos.com>
Date:   Wed, 05 Jan 2011 11:23:17 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
Subject: Re: SMTC support status in latest git head.
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88F@EXV1.corp.adtran.com>         <1293470392.27661.202.camel@paanoop1-desktop>         <1293524389.27661.210.camel@paanoop1-desktop>         <4D19A31E.1090905@paralogos.com>         <1293798476.27661.279.camel@paanoop1-desktop>         <4D1EE913.1070203@paralogos.com>         <1294067561.27661.293.camel@paanoop1-desktop>         <4D21F5D3.50604@paralogos.com>         <1294082426.27661.330.camel@paanoop1-desktop>         <4D22D7B3.2050609@paralogos.com>         <1294146165.27661.361.camel@paanoop1-desktop>         <1294151822.27661.375.camel@paanoop1-desktop>         <4D235717.1000603@paralogos.com>         <1294163657.27661.386.camel@paanoop1-desktop>         <4D2367EE.7000702@paralogos.com> <1294233097.27661.391.camel@paanoop1-desktop>
In-Reply-To: <1294233097.27661.391.camel@paanoop1-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

On 01/05/11 05:11, Anoop P A wrote:
> On Tue, 2011-01-04 at 10:33 -0800, Kevin D. Kissell wrote:
>> On 01/04/11 09:54, Anoop P A wrote:
>>> On Tue, 2011-01-04 at 09:21 -0800, Kevin D. Kissell wrote:
>>>> I'm trying to figure out a reason why your change below should help, and
>>>> offhand, modulo tool bugs, I don't see it.  I'm assuming that your diff
>>>> below is a diff relative to the pre-patch stackframe.h.   I wouldn't
>>> Yes patch created against stock code .
>>>
>>>> bless it as an alternative because it moves code and comments
>>>> unnecessarily - all you should really have to do is to move the
>>>>
>>>>
>>>>     190                 mfc0    v1, CP0_STATUS
>>>>     191                 LONG_S  $2, PT_R2(sp)
>>>>
>>>> to be just after the #endif /* CONFIG_MIPS_MT_SMTC */ at around line 201.
>>> Actually I just moved code under CONFIG_MIPS_MT_SMTC to previous block
>>> of code ( which store $0 ) . git diff did the rest on behalf of me :)
>>>
>>>> If moving the save of zero to PT_R0(sp) actually makes a difference,
>>>> it's evidence that you've got problems in your toolchain (or, heaven
>>>> forbid, your pipeline)!
>>> In previous version of patch usage of V0 was creating issue. I have
>>> verified this with previous version of code ( working code before
>>> David's instruction rearrangement patch.) .
>> Argh.  It's not very clearly commented, but it looks as if the system
>> call trap handler has an implicit assumption that v0 has never been
>> changed by SAVE_SOME, TRACE_IRQS_ON_RELOAD, or STI.  So yeah, moving the
>> code around to fix the v1 conflict ends up being better than using v0 -
>> otherwise, we'd need to add a LONG_L v0, PT_R2(sp) somewhere after the
>> LONG_S v0, PT_TCSTATUS(sp) of the original patch.
> Well, Here is the patch.
>
> diff --git a/arch/mips/include/asm/stackframe.h
> b/arch/mips/include/asm/stackframe.h
> index 58730c5..19418c4 100644
> --- a/arch/mips/include/asm/stackframe.h
> +++ b/arch/mips/include/asm/stackframe.h
> @@ -187,8 +187,6 @@
>   		 * need it to operate correctly
>   		 */
>   		LONG_S	$0, PT_R0(sp)
> -		mfc0	v1, CP0_STATUS
> -		LONG_S	$2, PT_R2(sp)
>   #ifdef CONFIG_MIPS_MT_SMTC
>   		/*
>   		 * Ideally, these instructions would be shuffled in
> @@ -199,6 +197,8 @@
>   		.set	mips0
>   		LONG_S	v1, PT_TCSTATUS(sp)
>   #endif /* CONFIG_MIPS_MT_SMTC */
> +		mfc0	v1, CP0_STATUS
> +		LONG_S	$2, PT_R2(sp)
>   		LONG_S	$4, PT_R4(sp)
>   		LONG_S	$5, PT_R5(sp)
>   		LONG_S	v1, PT_STATUS(sp)

That's exactly what I'd propose as the cleanest minimal fix.  I've got a 
version that also replaces the .set mips32 / .set mips0 with the .set 
push / .set pop paradigm, which I'd have used in the original code if 
I'd known at the time about that assembler directive.  I'm hoping to be 
able to test on a Malta/34K reference platform, and make sure there 
isn't breakage on that platform branch as well, before we commit to the 
repository.

Your msp_smtc.c file looks plausible on the face of it.  The 
init_secondary function has the quirk that it expects to execute on each 
"CPU" in numerical order, which is very likely but not guaranteed. It 
*ought* to be harmless in the rare case where it fails, but the 
assumption is worth a comment, IMHO.

At this point, there shouldn't be a whole lot of SMTC-specific mystery 
to get your timer running on the second VPE.  You know it's taking 
interrupts, because of the IPIs getting through, so in principle you 
just need to run the chain of enables from the clock peripheral itself 
through the CIC to the CPU core and the IM bits.

It would be really cool if we could get a stable repository branch that 
boots SMTC out-of-the-box on both Malta and the MSP platform.

             Regards,

             Kevin K.
