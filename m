Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2011 19:46:31 +0100 (CET)
Received: from gateway14.websitewelcome.com ([67.18.70.2]:53981 "HELO
        gateway14.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1490981Ab1AGSq2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jan 2011 19:46:28 +0100
Received: (qmail 7244 invoked from network); 7 Jan 2011 18:48:44 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway14.websitewelcome.com with SMTP; 7 Jan 2011 18:48:44 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=uTXH/tK2g8prZGl4qiobaAU2NGYK8BcKTw4nOoMVK7hDWpmP/mDUyKLas3OWj3f8CdIH9emDx2cxayZL4iTM27pxJK6/syJt4ow6x6CsVFi7qhNIXWqOqRKvVPbn/v33;
Received: from [216.239.45.4] (port=1541 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PbHKQ-0003TC-9N; Fri, 07 Jan 2011 12:46:22 -0600
Message-ID: <4D275F80.2000307@paralogos.com>
Date:   Fri, 07 Jan 2011 10:46:24 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
Subject: Re: SMTC support status in latest git head.
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88F@EXV1.corp.adtran.com>      <1293470392.27661.202.camel@paanoop1-desktop>   <1293524389.27661.210.camel@paanoop1-desktop>   <4D19A31E.1090905@paralogos.com>        <1293798476.27661.279.camel@paanoop1-desktop>   <4D1EE913.1070203@paralogos.com>        <1294067561.27661.293.camel@paanoop1-desktop>   <4D21F5D3.50604@paralogos.com>  <1294082426.27661.330.camel@paanoop1-desktop>   <4D22D7B3.2050609@paralogos.com>        <1294146165.27661.361.camel@paanoop1-desktop>   <1294151822.27661.375.camel@paanoop1-desktop>   <4D235717.1000603@paralogos.com>        <1294163657.27661.386.camel@paanoop1-desktop>   <4D2367EE.7000702@paralogos.com>        <1294233097.27661.391.camel@paanoop1-desktop>   <4D24C525.5000306@paralogos.com>        <1294345396.27661.422.camel@paanoop1-desktop>   <4D2650D6.4030102@paralogos.com> <1294387019.27661.458.camel@paanoop1-desktop>
In-Reply-To: <1294387019.27661.458.camel@paanoop1-desktop>
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
X-archive-position: 28883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

On 01/06/11 23:56, Anoop P A wrote:
> On Thu, 2011-01-06 at 15:31 -0800, Kevin D. Kissell wrote:
>> I'm sure I've said this before, and it's in various comments in the SMTC
>> code, but...
As an aside to this conversation, would it be possible to create a
Documentation/mips/SMTC.txt file that would actually propagate
upstream, so that I'd stop being the sole repository of SMTC folklore?
I only maintain it as a hobby.
> Ok. Well thanks much for your detailed explanation. Well I hope I found
> the root cause . smtc_clockevent_init() was overriding irq_hwmask even
> if are using platform specific get_c0_compare_int. With following patch
> everything seems to be working for me.
> ------------------------------------------------------------------------
> diff --git a/arch/mips/kernel/cevt-smtc.c b/arch/mips/kernel/cevt-smtc.c
> index 2e72d30..a25fc59 100644
> --- a/arch/mips/kernel/cevt-smtc.c
> +++ b/arch/mips/kernel/cevt-smtc.c
> @@ -310,9 +310,14 @@ int __cpuinit smtc_clockevent_init(void)
>   		return 0;
>   	/*
>   	 * And we need the hwmask associated with the c0_compare
> -	 * vector to be initialized.
> +	 * vector to be initialized. However incase of platform
> +	 * specific get_co_compare_int, don't override irq_hwmask
> +	 * expect platform code to set a valid mask value.
>   	 */
> -	irq_hwmask[irq] = (0x100<<  cp0_compare_irq);
> +
> +	if (!get_c0_compare_int)
> +		irq_hwmask[irq] = (0x100<<  cp0_compare_irq);
> +
>   	if (cp0_timer_irq_installed)
>   		return 0;
> -----------------------------------------------------------------------
I'm still not clear on one point that, to me, is pretty important when
engineering a fix here.  Are you, in fact, using the Count/Compare
interrupt system, but having the externalization of the compare
interrupt routed back through an intervening interrupt controller,
or is your timer coming from another source?

In the former case, I think you're on the right track as to the
possible cause of a problem, but the fix should actually be simpler
and rather more elegant.  Why can't you simply see to it that
cp0_compare_irq is set to the right value, either at compile time,
or in your earliest platform initialization of the interrupt controller?
That would be a one-line, inline change and spare us another
cryptic conditional.

In the later case, you'll presumably be having lots of other problems,
as cevt-smtc.c is intertwined with cevt-r4k.c and the Count/Compare
paradigm.

             Regards,

             Kevin K.
