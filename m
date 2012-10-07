Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Oct 2012 06:18:11 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:48835 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870427Ab2JGESCU4Dp2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 7 Oct 2012 06:18:02 +0200
Received: by mail-pa0-f49.google.com with SMTP id bi5so3286152pad.36
        for <linux-mips@linux-mips.org>; Sat, 06 Oct 2012 21:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=ZJEdv/ttnDk9B8RTOwF0h+FGi82yUwQBRRk8fpUr+5A=;
        b=I3nLx9b/Yok2wjvzTsEyHPIQwaxCxeYFlQA/6U/E3m0/FJZPFDxmOrjbl8Xf5MAo9L
         Xdpc/yA00m0UYsHqgXtJh2XkIgPy7pi2nyhyIyWv6eY5px9AZYnzv8IBabI5xyWXkASw
         mqbETaApv4EkdkiFenw0yQrs96nvE08i8+hwMF1JOjJt5z9LEIIAAU2GvqgsAKqrioDC
         MU/iGNX66gPI8/DPmVXCpNnyssLM3UDB3F+/zfAxNreMqYcCfXS8yL7gVBMTmRfskr9+
         otZNNXrLpIHsXS2zf1FfLaalJCY5+/5La3tvM4p+/Zx2hEYjdxOLwLuGcsnAuVQNnnaz
         zj4A==
Received: by 10.68.130.201 with SMTP id og9mr42849457pbb.12.1349583475332;
        Sat, 06 Oct 2012 21:17:55 -0700 (PDT)
Received: from S2101-09.ap.freescale.net ([114.216.233.66])
        by mx.google.com with ESMTPS id it6sm8568133pbc.14.2012.10.06.21.17.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Oct 2012 21:17:54 -0700 (PDT)
Date:   Sun, 7 Oct 2012 12:17:50 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Thierry Reding <thierry.reding@avionic-design.de>
Cc:     linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bryan Wu <bryan.wu@canonical.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Ashish Jangam <ashish.jangam@kpitcummins.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH] pwm: Get rid of HAVE_PWM
Message-ID: <20121007041748.GN20231@S2101-09.ap.freescale.net>
References: <1349330819-11924-1-git-send-email-thierry.reding@avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1349330819-11924-1-git-send-email-thierry.reding@avionic-design.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQm/t381o4M8tLksQn098H96bGvRfU86HedgabPJaMGB/QUWavLF+KhsBnUahh0EKHdbbwgo
X-archive-position: 34643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shawn.guo@linaro.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Oct 04, 2012 at 08:06:59AM +0200, Thierry Reding wrote:
> Now that all drivers have been moved to the PWM subsystem, remove the
> legacy HAVE_PWM symbol and replace it with the new PWM symbol. While at
> it, select the PWM subsystem and corresponding PWM driver on boards that
> require PWM functionality.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Bryan Wu <bryan.wu@canonical.com>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Ashish Jangam <ashish.jangam@kpitcummins.com>
> Cc: Andrew Jones <drjones@redhat.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-input@vger.kernel.org
> Cc: linux-leds@vger.kernel.org
> ---
>  arch/arm/Kconfig           |  6 ++----
>  arch/arm/mach-mxs/Kconfig  |  6 ++++--

Shawn Guo <shawn.guo@linaro.org>

>  arch/arm/mach-pxa/Kconfig  | 42 ++++++++++++++++++++++++++++--------------
>  arch/mips/Kconfig          |  3 ++-
>  drivers/input/misc/Kconfig |  4 ++--
>  drivers/leds/Kconfig       |  2 +-
>  include/linux/pwm.h        |  2 +-
>  7 files changed, 40 insertions(+), 25 deletions(-)
