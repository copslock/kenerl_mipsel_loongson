Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 06:59:22 +0200 (CEST)
Received: from resqmta-ch2-03v.sys.comcast.net ([69.252.207.35]:53757 "EHLO
        resqmta-ch2-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006931AbbDAE7SYj7pu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Apr 2015 06:59:18 +0200
Received: from resomta-ch2-17v.sys.comcast.net ([69.252.207.113])
        by resqmta-ch2-03v.sys.comcast.net with comcast
        id AUzA1q0052TL4Rh01UzCjC; Wed, 01 Apr 2015 04:59:12 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-17v.sys.comcast.net with comcast
        id AUzB1q00242s2jH01UzBxk; Wed, 01 Apr 2015 04:59:12 +0000
Message-ID: <551B7B19.30305@gentoo.org>
Date:   Wed, 01 Apr 2015 00:59:05 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Linux/MIPS <linux-mips@linux-mips.org>,
        rtc-linux@googlegroups.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] MIPS: IP32: Add platform data hooks to use DS1685
 driver
References: <54EFD536.2080508@gentoo.org> <20150331105650.GA28951@linux-mips.org>
In-Reply-To: <20150331105650.GA28951@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1427864352;
        bh=TE/C9hgoQsTcWKj0cMedlsa4D9sBcYwbL1OGUo1tuRk=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=gf4vC+6f8sna13S4tcy2xAztndFsGgB4FPfcF1fhgsttc4VgVn2kMPPNDeZ69ujrC
         8r5v1DhI9DZszJstQf2etlfaA1AH2A9GtrmdLYRlniOP8lHWCjnPXCr2GL0X7Xe3ER
         lKhWYkZ5MI9OoDnHF0ONooSCROQaOQxTfkP3MPT9AIDqrtOPSFh1FHD47BRN58pXV8
         8FIGKFJqA7JUbIatlX48zN+mkmHsYZJOK9q+NxV2x150i67LaErFCAAAf3LSXRYvSr
         QWj+kXhbGwz1okXDUbhKUqqJFCpBdX8GAshg+d/cqRFkwXvCyZCnZ/krBnCtoSyifG
         KOkJMbBAoso7g==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 03/31/2015 06:56, Ralf Baechle wrote:
> On Thu, Feb 26, 2015 at 09:23:50PM -0500, Joshua Kinard wrote:
> 
>> This modifies the IP32 (SGI O2) platform and reset code to utilize the new
>> rtc-ds1685 driver.  The old mc146818rtc.h header is removed and ip32_defconfig
>> is updated as well.
> 
> In general - good cleanup.  But:
> 
>> index 511e9ff..ec9eb7f 100644
>> --- a/arch/mips/sgi-ip32/ip32-platform.c
>> +++ b/arch/mips/sgi-ip32/ip32-platform.c
> [...]
>>  MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
>>  MODULE_LICENSE("GPL");
>> -MODULE_DESCRIPTION("8250 UART probe driver for SGI IP32 aka O2");
>> +MODULE_DESCRIPTION("IP32 platform setup for SGI IP32 aka O2");
> 
> This isn't even a kernel module so I've just nuked all these MODULE_*
> calls.

Works for me, thanks!


>> diff --git a/arch/mips/sgi-ip32/ip32-reset.c b/arch/mips/sgi-ip32/ip32-reset.c
>> index 44b3470..ef21706 100644
>> --- a/arch/mips/sgi-ip32/ip32-reset.c
>> +++ b/arch/mips/sgi-ip32/ip32-reset.c
> [...]
>> -static void ip32_machine_restart(char *cmd)
>> +static __noreturn void ip32_poweroff(void *data)
>>  {
>> -	crime->control = CRIME_CONTROL_HARD_RESET;
>> -	while (1);
>> -}
>> +	void (*poweroff_func)(struct platform_device *) =
>> +		symbol_get(ds1685_rtc_poweroff);
>> +
>> +#ifdef CONFIG_MODULES
>> +	/* If the first __symbol_get failed, our module wasn't loaded. */
>> +	if (!poweroff_func) {
>> +		request_module("rtc-ds1685");
>> +		poweroff_func = symbol_get(ds1685_rtc_poweroff);
>> +	}
>> +#endif
> 
> symbol_get() calls are high on my list of items that indicate a piece of
> code is probably ill-structured.

That was the only function I could find that would attempt to fetch the
ds1685_rtc_poweroff() function from kernel memory and return an indication of
success or failure that could be checked.  If there's a better way to do that,
I'll be happy to re-write that section.  I looked through the docs back then
and couldn't find another way that worked with and without modules.


> While RTCs often deal with power the RTC really only wants to deal with
> time and so power stuff should rather go elsewhere.  I suggest to take a
> look at drivers/power/reset/.  A small driver there could set pm_power_off
> approriately.  drivers/power/reset/restart-poweroff.c is a very compact
> example.

Except this code is in a file called "ip32-reset.c", and the original code
there did the exact same thing -- powered off the machine.  The
ds1685_rtc_poweroff() function is defined in the core DS1685 driver
(drivers/rtc/rtc-ds1685.c) that got added to linux-next a few weeks ago (no one
had any complaints about that).  This code just checks to see if the RTC driver
is loaded and then calls that function to power the machine down.

IP30 uses a similar setup as well, since both machines share the same RTC
chip/family.


>> @@ -190,15 +141,12 @@ static __init int ip32_reboot_setup(void)
>>  
>>  	_machine_restart = ip32_machine_restart;
>>  	_machine_halt = ip32_machine_halt;
>> -	pm_power_off = ip32_machine_power_off;
>> +	pm_power_off = ip32_machine_halt;
> 
> So halt and power_off no do the same?
> 

They always did.  This is the original ip32_machine_halt function:

static inline void ip32_machine_halt(void)
{
       ip32_machine_power_off();
}

I just got rid of the added level of misdirection and set both _machine_halt
and pm_power_off to call the same function (especially since there's no
sleeping these kinds of machines -- maybe hibernate, but that'll still properly
poweroff).  Seemed the logical thing to do.  In either case, it'll lead to the
RTC driver handling the poweroff routine, which seems to be the only way SGI
designed these machines to power off.  I'll wager the ARCS firmware internally
does the same thing.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
