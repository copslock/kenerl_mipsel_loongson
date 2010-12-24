Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Dec 2010 00:34:31 +0100 (CET)
Received: from gateway15.websitewelcome.com ([67.18.137.87]:43214 "HELO
        gateway15.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491098Ab0LXXe1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Dec 2010 00:34:27 +0100
Received: (qmail 10294 invoked from network); 24 Dec 2010 23:34:30 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway15.websitewelcome.com with SMTP; 24 Dec 2010 23:34:30 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=h4675lkYmZ/Scntbz1255AsLG43RXH3tt9vjS8jME3aFnyx9kJnm/aGP3jhjz1RqFtMgSemlHc16QENZbg3ZvKv/A5NkwsUchxwvb5GsF+H7mK33BqpO+Uy7XG1R6nEH;
Received: from [88.123.214.42] (port=49378 helo=kkissell-macbookpro.local)
        by gator750.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PWH9N-0005rY-ER; Fri, 24 Dec 2010 17:34:18 -0600
Message-ID: <4D152DFA.5090504@paralogos.com>
Date:   Fri, 24 Dec 2010 15:34:18 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
Subject: Re: SMTC support status in latest git head.
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88D@EXV1.corp.adtran.com>      <4D1492E0.5090407@paralogos.com>        <1293201545.27661.55.camel@paanoop1-desktop>    <4D14B3FA.5080304@paralogos.com> <1293206536.27661.63.camel@paanoop1-desktop>
In-Reply-To: <1293206536.27661.63.camel@paanoop1-desktop>
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
X-archive-position: 28715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Ah, well, at least we have a stackframe.h fix that preserves David's 
performance tweak for the deeper pipelined processors.  In looking for 
this, I did notice that someone did some modification to the SMTC clock 
tick logic that I was skeptical had ever been tested.  If you've still 
got that kernel binary handy, you might check to see if it boots with 
maxtcs=1 maxvpes=1, maxtcs=2 maxvpes=1, and/or maxtcs=2 maxvpes=2.

Oh, yes, and Merry Christmas one and all!

             Regards,

             Kevin K.

On 12/24/10 8:02 AM, Anoop P A wrote:
> On Fri, 2010-12-24 at 06:53 -0800, Kevin D. Kissell wrote:
>> Excellent!  Now, does the attached patch (relative to 2.6.37.11) also
>> fix things, while preserving the other fixes and performance enhancements?
>>
> I have tested that patch with 2.6.37 branch it well passes calibration
> loop but hangs after switching to mips closource
>
> TC 6 going on-line as CPU 6
> Brought up 7 CPUs
> bio: create slab<bio-0>  at 0
> SCSI subsystem initialized
> Switching to clocksource MIPS
>
> I Presume this is a different issue as restoring older file didn't help
> much to get rid of this hang.
>
> diff --git a/arch/mips/include/asm/stackframe.h
> b/arch/mips/include/asm/stackframe.h
> index 58730c5..7fc9f10 100644
> --- a/arch/mips/include/asm/stackframe.h
> +++ b/arch/mips/include/asm/stackframe.h
> @@ -195,9 +195,9 @@
>   		 * to cover the pipeline delay.
>   		 */
>   		.set	mips32
> -		mfc0	v1, CP0_TCSTATUS
> +		mfc0	v0, CP0_TCSTATUS
>   		.set	mips0
> -		LONG_S	v1, PT_TCSTATUS(sp)
> +		LONG_S	v0, PT_TCSTATUS(sp)
>   #endif /* CONFIG_MIPS_MT_SMTC */
>   		LONG_S	$4, PT_R4(sp)
>   		LONG_S	$5, PT_R5(sp)
>
>
>> /K.
>>
>> On 12/24/10 6:39 AM, Anoop P A wrote:
>>> Hi Kevin, Stuart ,
>>>
>>> Woohooo You guys spotted !.
>>>
>>>    http://git.linux-mips.org/?p=linux.git;a=commit;h=d5ec6e3c seems to be
>>> the culprit
>>>
>>> Once I restored previous version of stackframe.h 2.6.33-stable started
>>> booting !.
>>>
>>> Thanks,
>>> Anoop
>>>
>>> On Fri, 2010-12-24 at 04:32 -0800, Kevin D. Kissell wrote:
>>>> Thank you, Stuart!  I've spotted some definite breakage to SMTC between
>>>> those versions.  In arch/mips/include/asm/stackframe.h, someone moved
>>>> the store of the Status register value in SAVE_SOME (line 169 or 204,
>>>> depending on the version) from two instructions after the mfc0 to a
>>>> point after the #ifdef for SMTC, presumably to get better pipelining of
>>>> the register access.  Unfortunately, the v1 register is also used in the
>>>> SMTC-specific fragment to save TCStatus, so the Status value gets
>>>> clobbered before it gets stored.  This will eventually result in the
>>>> Status register getting a TCStatus value, which has some bits on common,
>>>> but isn't identical and sooner or later Bad Things will happen.
>>>>
>>>> I'm a little surprised this wasn't caught by visual inspection of the patch.
>>>>
>>>> Possible solutions would include reverting the store of the CP0_STATUS
>>>> value to the block above the #ifdef, or, to retain whatever performance
>>>> advantage was obtained by moving the store downward, to use v0/$2
>>>> instead of v1/$3, as the staging register for the TCStatus value.  I'd
>>>> lean toward the second option, but I'm not in a position to test and
>>>> submit a patch just now.
>>>>
>>>>                Regards,
>>>>
>>>>                Kevin K.
>>>>
>>>> On 12/23/10 1:09 PM, STUART VENTERS wrote:
>>>>> Kevin,
>>>>>
>>>>> I'm not sure if it's useful,
>>>>>       but finally I got the time to look at the two kernel versions Anoop pointed out.
>>>>>        works   2.6.32-stable with patch 804
>>>>>        works_not 2.6.33-stable
>>>>>
>>>>> greping for files with CONFIG_MIPS_MT_SMTC
>>>>>       and looking for timer interrupt related stuff found the following differences:
>>>>>
>>>>>
>>>>> arch/mips/include/asm/irq.h
>>>>> arch/mips/kernel/irq.c
>>>>>      do_IRQ
>>>>>
>>>>> arch/mips/include/asm/stackframe.h
>>>>>      SAVE_SOME SAVE_TEMP get/set_saved_sp
>>>>>
>>>>> arch/mips/include/asm/time.h
>>>>>      clocksource_set_clock
>>>>>
>>>>> arch/mips/kernel/process.c
>>>>>      cpu_idle
>>>>>
>>>>> arch/mips/kernel/smtc.c
>>>>>      __irq_entry
>>>>>      ipi_decode
>>>>>          SMTC_CLOCK_TICK
>>>>>
>>>>>
>>>>> Enclosed are the two subsets of files for a more expert look.
>>>>>
>>>>> I'll try to look in more detail after Christmas.
>>>>>
>>>>>
>>>>> Cheers,
>>>>>
>>>>> Stuart
>>>>>
>>>>>
>>>>>
>>>>>
>
