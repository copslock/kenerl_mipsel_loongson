Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 12:56:53 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55961 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010149AbbCaK4vi0fAR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Mar 2015 12:56:51 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2VAupWb031375;
        Tue, 31 Mar 2015 12:56:51 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2VAuoHi031374;
        Tue, 31 Mar 2015 12:56:50 +0200
Date:   Tue, 31 Mar 2015 12:56:50 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Linux/MIPS <linux-mips@linux-mips.org>,
        rtc-linux@googlegroups.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] MIPS: IP32: Add platform data hooks to use DS1685
 driver
Message-ID: <20150331105650.GA28951@linux-mips.org>
References: <54EFD536.2080508@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54EFD536.2080508@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Feb 26, 2015 at 09:23:50PM -0500, Joshua Kinard wrote:

> This modifies the IP32 (SGI O2) platform and reset code to utilize the new
> rtc-ds1685 driver.  The old mc146818rtc.h header is removed and ip32_defconfig
> is updated as well.

In general - good cleanup.  But:

> index 511e9ff..ec9eb7f 100644
> --- a/arch/mips/sgi-ip32/ip32-platform.c
> +++ b/arch/mips/sgi-ip32/ip32-platform.c
[...]
>  MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
>  MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("8250 UART probe driver for SGI IP32 aka O2");
> +MODULE_DESCRIPTION("IP32 platform setup for SGI IP32 aka O2");

This isn't even a kernel module so I've just nuked all these MODULE_*
calls.

> diff --git a/arch/mips/sgi-ip32/ip32-reset.c b/arch/mips/sgi-ip32/ip32-reset.c
> index 44b3470..ef21706 100644
> --- a/arch/mips/sgi-ip32/ip32-reset.c
> +++ b/arch/mips/sgi-ip32/ip32-reset.c
[...]
> -static void ip32_machine_restart(char *cmd)
> +static __noreturn void ip32_poweroff(void *data)
>  {
> -	crime->control = CRIME_CONTROL_HARD_RESET;
> -	while (1);
> -}
> +	void (*poweroff_func)(struct platform_device *) =
> +		symbol_get(ds1685_rtc_poweroff);
> +
> +#ifdef CONFIG_MODULES
> +	/* If the first __symbol_get failed, our module wasn't loaded. */
> +	if (!poweroff_func) {
> +		request_module("rtc-ds1685");
> +		poweroff_func = symbol_get(ds1685_rtc_poweroff);
> +	}
> +#endif

symbol_get() calls are high on my list of items that indicate a piece of
code is probably ill-structured.

While RTCs often deal with power the RTC really only wants to deal with
time and so power stuff should rather go elsewhere.  I suggest to take a
look at drivers/power/reset/.  A small driver there could set pm_power_off
approriately.  drivers/power/reset/restart-poweroff.c is a very compact
example.

> -	shuting_down = 1;
> +	shutting_down = 1;

I'm amazed nobody of the church of speel patchology has caught this earlier.

> @@ -190,15 +141,12 @@ static __init int ip32_reboot_setup(void)
>  
>  	_machine_restart = ip32_machine_restart;
>  	_machine_halt = ip32_machine_halt;
> -	pm_power_off = ip32_machine_power_off;
> +	pm_power_off = ip32_machine_halt;

So halt and power_off no do the same?

  Ralf
