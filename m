Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 02:12:41 +0200 (CEST)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:38580
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990407AbdJEAMeCjePm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 02:12:34 +0200
Received: by mail-pg0-x244.google.com with SMTP id y192so14505775pgd.5;
        Wed, 04 Oct 2017 17:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TWos4rwWr1EDtdhPwwu8I1me2a3PXMCqdfbuTXMh0JY=;
        b=Xy/i3wwYg5J+LHb6mnxPUm7BP1OnHkbvCmYynKnQHSDjahypTkcAoRk02gtfl5bEru
         soTgux9wMYfcwOgDF/tLi2Ff1p8sUq87Y9wkIKhJhkTTEnwnLDh0jW1FKnb7pCLMcWXH
         HR8a+osv7ZHepmkt/uZJ6xtW2km9BsgrF75uGFPr2h643s3y1WtI/+MiyURUROOz0TM6
         c62RnI49s8xJDt2F6aoFMv/Uyugs7e4+6Y3shslCzXTzsg8KRWkQSMBfahboGHvOE2rB
         AcrF2TdctuuKDYbx68tj+zAtFPUsoUh5HJll4wV3x3ZRTSwZJUfHo05jFix7AMEXsBl4
         tONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TWos4rwWr1EDtdhPwwu8I1me2a3PXMCqdfbuTXMh0JY=;
        b=JPLjne2Rm8QwEs1zqsWYIql/DzQKrC6TJiLzgFRvxpoN5Fg9JzuftD7fcUEH6k3PnZ
         QBT7Yi+9vzhBSc+SmJRjO/va5l/Umc1a5lQ+MO+P1wWP5bQEWUlF9Py6Kedk4cNZYKl0
         iyGs9AgkSzxd9kauLoxBtbH5lMBXE4edRa7wtycsMQ9NYCx0EOlTxPRH6e3cLaT7RgDj
         NAJD4GaLheQaZnSv1jY4fxn8KTDZBQsimyE/sRaf9mjKNUYopAmCp80xFu69vA8Vhm4p
         /oeOOwscWkOIKIZS1jNZTPoznLh/01ojYNxN7XXQX2YmrDI3AFFk/UHkFF0byX66HEql
         w0CA==
X-Gm-Message-State: AHPjjUjm+rf+oeeBQToZX2W5k7rRH0Lkc1owhOAmPfU5YyvRacYIuL48
        DRwD3GSwsubrVKtj8Qh6Qng=
X-Google-Smtp-Source: AOwi7QCVhcU1bNfk3rNIbbDgsYIQ1QCkx0uErHJ0WuoekAbc9oAJpdP2S+lRtRhajQDUPngnu5MQbA==
X-Received: by 10.99.180.7 with SMTP id s7mr19321987pgf.171.1507162345789;
        Wed, 04 Oct 2017 17:12:25 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j6sm17562599pgn.68.2017.10.04.17.12.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 17:12:24 -0700 (PDT)
Subject: Re: [PATCH 09/13] timer: Remove users of expire and data arguments to
 DEFINE_TIMER
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harish Patil <harish.patil@cavium.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <len.brown@intel.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Mark Gross <mark.gross@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Reed <mdr@sgi.com>, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sebastian Reichel <sre@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux1394-devel@lists.sourceforge.net, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
 <1507159627-127660-10-git-send-email-keescook@chromium.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8219ece3-429a-1a25-1fd5-5ee5bacde53c@roeck-us.net>
Date:   Wed, 4 Oct 2017 17:12:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1507159627-127660-10-git-send-email-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 10/04/2017 04:27 PM, Kees Cook wrote:
> The expire and data arguments of DEFINE_TIMER are only used in two places
> and are ignored by the code (malta-display.c only uses mod_timer(),
> never add_timer(), so the preset expires value is ignored). Set both
> sets of arguments to zero.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-watchdog@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

For watchdog:

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/mips/mti-malta/malta-display.c | 6 +++---
>   drivers/watchdog/alim7101_wdt.c     | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/mti-malta/malta-display.c b/arch/mips/mti-malta/malta-display.c
> index d4f807191ecd..ac813158b9b8 100644
> --- a/arch/mips/mti-malta/malta-display.c
> +++ b/arch/mips/mti-malta/malta-display.c
> @@ -36,10 +36,10 @@ void mips_display_message(const char *str)
>   	}
>   }
>   
> -static void scroll_display_message(unsigned long data);
> -static DEFINE_TIMER(mips_scroll_timer, scroll_display_message, HZ, 0);
> +static void scroll_display_message(unsigned long unused);
> +static DEFINE_TIMER(mips_scroll_timer, scroll_display_message, 0, 0);
>   
> -static void scroll_display_message(unsigned long data)
> +static void scroll_display_message(unsigned long unused)
>   {
>   	mips_display_message(&display_string[display_count++]);
>   	if (display_count == max_display_count)
> diff --git a/drivers/watchdog/alim7101_wdt.c b/drivers/watchdog/alim7101_wdt.c
> index 665e0e7dfe1e..3c1f6ac68ea9 100644
> --- a/drivers/watchdog/alim7101_wdt.c
> +++ b/drivers/watchdog/alim7101_wdt.c
> @@ -71,7 +71,7 @@ MODULE_PARM_DESC(use_gpio,
>   		"Use the gpio watchdog (required by old cobalt boards).");
>   
>   static void wdt_timer_ping(unsigned long);
> -static DEFINE_TIMER(timer, wdt_timer_ping, 0, 1);
> +static DEFINE_TIMER(timer, wdt_timer_ping, 0, 0);
>   static unsigned long next_heartbeat;
>   static unsigned long wdt_is_open;
>   static char wdt_expect_close;
> @@ -87,7 +87,7 @@ MODULE_PARM_DESC(nowayout,
>    *	Whack the dog
>    */
>   
> -static void wdt_timer_ping(unsigned long data)
> +static void wdt_timer_ping(unsigned long unused)
>   {
>   	/* If we got a heartbeat pulse within the WDT_US_INTERVAL
>   	 * we agree to ping the WDT
> 
