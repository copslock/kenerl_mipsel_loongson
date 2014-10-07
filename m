Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 10:01:04 +0200 (CEST)
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36035 "EHLO
        mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010665AbaJGIBDSu0Lp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 10:01:03 +0200
Received: by mail-ig0-f179.google.com with SMTP id h18so4267101igc.0
        for <linux-mips@linux-mips.org>; Tue, 07 Oct 2014 01:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fbO0x+dbtEI+osNOFoN6mlB2Ti38IfEik6IoHTaZtD4=;
        b=aBGi9U9rjvcBqxMvtcZVdsDDXCAG2OFUrHUud+z2kjU2p3gY27nt3GmTRl+/X94pwU
         oIOZ5DS83sGajM7jb9z55Ahh8dln8PIM5SK+Nu4vtkjQ2JLwXX48Qnbu6FOxhe6SlZzG
         ICc0apL0/JPT39aDi6Ahg5xqS8WfoKl/AATqVeqzo1ZRDE6F6iFjIsh8bjxEBJxNeGyH
         s8oelKxRnt3YGrjR/Rg273VV+iyGP5mIszUWPcKgS6o8wSYlX2yShuIn00oVqDqSagi/
         CicqXyI7dZxhnY0A2rzR3ZvuNiPFQkkpT2hrTmhpuJgCWBCZtFa7w3FY2eIRSZEXMz85
         DkiQ==
X-Gm-Message-State: ALoCoQlePIQ8nMSu2HVbSlLfL1JoYFyxyRZHzLuiDK7k6BwZHhEpmcZoGsuIgkYGgITV8K0rD1BD
X-Received: by 10.42.61.137 with SMTP id u9mr2520721ich.54.1412668857025;
        Tue, 07 Oct 2014 01:00:57 -0700 (PDT)
Received: from lee--X1 (host109-148-233-9.range109-148.btcentralplus.com. [109.148.233.9])
        by mx.google.com with ESMTPSA id j2sm11554920igm.21.2014.10.07.01.00.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Oct 2014 01:00:56 -0700 (PDT)
Date:   Tue, 7 Oct 2014 09:00:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
        linux-cris-kernel@axis.com, linux-efi@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        openipmi-developer@lists.sourceforge.net,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 12/44] mfd: ab8500-sysctrl: Register with kernel poweroff
 handler
Message-ID: <20141007080048.GB25331@lee--X1>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-13-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1412659726-29957-13-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <lee.jones@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lee.jones@linaro.org
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

On Mon, 06 Oct 2014, Guenter Roeck wrote:

> Register with kernel poweroff handler instead of setting pm_power_off
> directly. Register with a low priority value of 64 to reflect that
> the original code only sets pm_power_off if it was not already set.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/mfd/ab8500-sysctrl.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
> index 8e0dae5..677438f 100644
> --- a/drivers/mfd/ab8500-sysctrl.c
> +++ b/drivers/mfd/ab8500-sysctrl.c
> @@ -6,6 +6,7 @@

[...]

> +static int ab8500_power_off(struct notifier_block *this, unsigned long unused1,
> +			    void *unused2)
>  {
>  	sigset_t old;
>  	sigset_t all;
> @@ -34,11 +36,6 @@ static void ab8500_power_off(void)
>  	struct power_supply *psy;
>  	int ret;
>  
> -	if (sysctrl_dev == NULL) {
> -		pr_err("%s: sysctrl not initialized\n", __func__);
> -		return;
> -	}

Can you explain the purpose of this change please?

>  	/*
>  	 * If we have a charger connected and we're powering off,
>  	 * reboot into charge-only mode.
> @@ -83,8 +80,15 @@ shutdown:
>  					 AB8500_STW4500CTRL1_SWRESET4500N);
>  		(void)sigprocmask(SIG_SETMASK, &old, NULL);
>  	}
> +
> +	return NOTIFY_DONE;
>  }

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
