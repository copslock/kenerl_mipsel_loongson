Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2016 12:52:13 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36132 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992974AbcHPKwEDNcUa convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Aug 2016 12:52:04 +0200
Received: by mail-pa0-f66.google.com with SMTP id ez1so5130308pab.3;
        Tue, 16 Aug 2016 03:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7Gyke0n3GFuW7xhuj0NzxiPfXhc+HLGuj9k1jsvuhQw=;
        b=yomwUzFOSdzNqnQVEEcDzD9rl3pULWKjTgln7UgzbZo62e6WI5AYPPEWybjENwyXXm
         WsLogT6KbmHG/5Tf6vwFe0HOV4o/sCqhZd60MxZZ/xB6OUK3hrZxmvzcqOBVRWj5GkCB
         OiffLovrTE9Gzzg6vYCv+CdGFa8P4ChyKwFD1egiWzj7i6/LJb4aUZJTI/QV5wVlSnqE
         E/UBLb/0/pWyVLFSBdD/UPwF8PPqWRcIFblyeZPXpOza9AEw1qtKzoUXyTKulZ5ArXZZ
         rIZPzJExnTdQCpEV//nL4Rcz5Z9FdTMAZV4TblB8Sr+aqe3heslKI3cIKi6uTlKycy4J
         ry0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7Gyke0n3GFuW7xhuj0NzxiPfXhc+HLGuj9k1jsvuhQw=;
        b=CwYSxW3IIf6b1ROOXoG/qXv5x+V+qkRvFZwyQwQ8BczZmLmxwBwqjqX4hCfMaFsVD7
         YFUKbFbIeaGDO5O9/zhH95yDccc9IvrNb6l0UDXZHJJO122J1fV4J3DYvf27UdwhopSR
         WV7Uk+rhafxfhQoWldtn96p1DYtnhXBYoYw4fNqVY5s+gV56G8yyYzZLNZ3eAq5xEJek
         G7g+DRBaDru7N6tlx2aq/5rWKkdFaTog6cYIh/hUWkvOt7U2pl1qFSVpWDi54Guw7GEM
         pPJG7rjgcEqiAbVcm6q28XGGc3MHKBqNvtbrJxoTCH0klNRNclEbUviLItPKJlMZwJq/
         IolA==
X-Gm-Message-State: AEkoouupkbR6qyAq+c7H48DBKcHDfQ4mnRDXQf+x62iqe4ly2o+gkaS8YXqvDJdilnxblA==
X-Received: by 10.66.127.38 with SMTP id nd6mr3870292pab.74.1471344718023;
        Tue, 16 Aug 2016 03:51:58 -0700 (PDT)
Received: from [172.16.1.101] ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id fj19sm38341629pab.37.2016.08.16.03.51.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Aug 2016 03:51:57 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [v3 3/5] MIPS: BMIPS: Add support SDHCI device nodes
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <2d8ad754-e9b7-e80e-9925-15ccd9c15856@gmail.com>
Date:   Tue, 16 Aug 2016 19:51:56 +0900
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <68351690-87EA-44E4-A6D3-6BB298855F5B@gmail.com>
References: <20160812085231.53290-1-jaedon.shin@gmail.com> <20160812085231.53290-4-jaedon.shin@gmail.com> <2d8ad754-e9b7-e80e-9925-15ccd9c15856@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.3124)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Hi Florian,

On Aug 13, 2016, at 8:24 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> On 08/12/2016 01:52 AM, Jaedon Shin wrote:
>> Adds SDHCI device nodes to BCM7xxx MIPS based SoCs.
> 
> While this looks good, I don't think you will have working SDHCI
> interfaces on the 7425/7435 without additional pinmuxing, because
> sometimes the bootloader indicates in a scratch register whether the
> SDHCI0 is usable and the default pinmuxing does not necessarily make
> this possible:
> 
> https://github.com/Broadcom/stblinux-3.3/blob/master/linux/drivers/brcmstb/board.c#L325
> 
> We have some currently out of tree patches using the pinctrl-single and
> some CFE shim to fix that.
> 
> Other than that:
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> -- 
> Florian

Sure, It is need to set pinmux, scratch register, endian and avoid broken enable, but I
think that is CFE's role. (eg. BCM7346 should be set the endian while run in little
endian mode) If we cannot update the CFE, we should consider adding sun_top_ctrl_pin_mux
and aon_pin_ctrl_pin_mux_ctrl in device tree with counterpart and endian patch in
sdhci-brcmstb.

Anyway, that's not the work of device tree.

Thanks,
Jaedon 
From daniel.lezcano@linaro.org Tue Aug 16 15:57:37 2016
Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2016 15:57:46 +0200 (CEST)
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36655 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992630AbcHPN5hYVYH4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Aug 2016 15:57:37 +0200
Received: by mail-wm0-f45.google.com with SMTP id q128so145657686wma.1
        for <linux-mips@linux-mips.org>; Tue, 16 Aug 2016 06:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=xE/EfN4RwLUvHZ05oHGgzsBmjVW+211eiwC2OZwWf/U=;
        b=adROcAF79lgSJJwyIGzFw97EhUwxl2Q4TzpBaFpRYwUBU7c09r9jRfpk/JubNk3wU9
         jXGYTP+2ZoVZjqvPCtGQFL5YfQD0SsCf8V+e2LbN/G+xlZqWqPFJ98O7kcwRLYfTXeM/
         Y/AF3n/ssMN0Ky5Ucow4PGndsU5CsHEqADmVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=xE/EfN4RwLUvHZ05oHGgzsBmjVW+211eiwC2OZwWf/U=;
        b=hWngMoizjOt4lEZpXZdeCpnKXWIenxTmSpg1I77yiTcuUWHBaX5vSdV3eILRSvDBKm
         IOmGE6E/NhxvFeTco93WoMnzEd5iF4IKhSvoPlFd4BNJ1vdcFCDPkJsPiR/eaflyVYyO
         teeqkFyyB4GCr1PS2kVluo5MSwCHQtE9LqfYiPSKq3+hBSnX+xJ8vthKomn0dJmU6Jwd
         4YfD2DjTnSCSWwLpbNTgYmX4nINkKWDHtWN8zgEAVqG8Dc0vSUGRorHzQ1iVd8P8jg3e
         Wnw4od4j/Urs/tGlpO5MqGkIwq8ZGA5cCOJkA0BIuu9Pmz1Kvmc3+ciN8oAVi+rZ2uPC
         u0vQ==
X-Gm-Message-State: AEkoous2qwxInx60CGCaDbSdTm5Q1hmwntvqB3TL+ZmgWG+bvh8dd+DdBc/swzEyskjfIAAO
X-Received: by 10.194.78.74 with SMTP id z10mr42921861wjw.68.1471355849817;
        Tue, 16 Aug 2016 06:57:29 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5dc9:f51b:9609:799b? ([2a01:e34:ed2f:f020:5dc9:f51b:9609:799b])
        by smtp.googlemail.com with ESMTPSA id g7sm26872011wjx.10.2016.08.16.06.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Aug 2016 06:57:28 -0700 (PDT)
Subject: Re: [PATCH] clocksource: mips-gic-timer: make gic_clocksource_of_init
 return int
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org
References: <20160801033546.26472-1-paul.gortmaker@windriver.com>
Cc:     linux-mips@linux-mips.org
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <57B31BC7.8000401@linaro.org>
Date:   Tue, 16 Aug 2016 15:57:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20160801033546.26472-1-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

On 08/01/2016 05:35 AM, Paul Gortmaker wrote:
> In commit d8152bf85d2c057fc39c3e20a4d623f524d9f09c:
>   ("clocksource/drivers/mips-gic-timer: Convert init function to return error")
> 
> several return values were added to a void function resulting in:
> 
>  clocksource/mips-gic-timer.c: In function 'gic_clocksource_of_init':
>  clocksource/mips-gic-timer.c:175:3: warning: 'return' with a value, in function returning void [enabled by default]
>  clocksource/mips-gic-timer.c:183:4: warning: 'return' with a value, in function returning void [enabled by default]
>  clocksource/mips-gic-timer.c:190:3: warning: 'return' with a value, in function returning void [enabled by default]
>  clocksource/mips-gic-timer.c:195:3: warning: 'return' with a value, in function returning void [enabled by default]
>  clocksource/mips-gic-timer.c:200:3: warning: 'return' with a value, in function returning void [enabled by default]
>  clocksource/mips-gic-timer.c:211:2: warning: 'return' with a value, in function returning void [enabled by default]
>  clocksource/mips-gic-timer.c: At top level:
>  clocksource/mips-gic-timer.c:213:1: warning: comparison of distinct pointer types lacks a cast [enabled by default]
>  clocksource/mips-gic-timer.c: In function 'gic_clocksource_of_init':
>  clocksource/mips-gic-timer.c:183:18: warning: ignoring return value of 'PTR_ERR', declared with attribute warn_unused_result [-Wunused-result]
> 
> Given that the addition of the return values was intentional, it seems
> that the conversion of the containing function from void to int was
> simply overlooked.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---

Hi Paul,

Thomas is in vacation and I'm returning back.

So I applied this patch as a fix.

Thanks!

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
