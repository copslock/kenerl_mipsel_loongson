Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Aug 2013 19:42:55 +0200 (CEST)
Received: from mail-oa0-f47.google.com ([209.85.219.47]:47127 "EHLO
        mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827302Ab3HWRmilBsSo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Aug 2013 19:42:38 +0200
Received: by mail-oa0-f47.google.com with SMTP id g12so1100532oah.20
        for <linux-mips@linux-mips.org>; Fri, 23 Aug 2013 10:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lwYj3eVZ1IQANVXVNs6tJRkg/8OpMPmK+5vii7fNcyg=;
        b=UwlMAOUKt63YnS4ZYFjaD3kBPrI7V7Ds8ifUT/pkqfbS45tDoYJ858+Y2MKcrS2uRE
         VLKLskO6OL81+nhpH/2so7PeCwoI+Rz++Fp47nMNlsmtmY7h6ygseesbzorF02RC0EZ2
         Yyq7SeuticvPj6/TlXMcN4Bawh0CxkK76zRe1OnxdMzXhq9WrclZVDDyjYV6NfdkqzQ2
         L56a9mlBgFCWwT1+CP6eDcAwS/rAat88FDtc1e4F7LQwzX57FZzic7hK5S4KaGu+s0Wm
         4vHOXaq3Rle62gzMd/ghKcJGmAuCHiij3e/b+Avr1C5JKAsO0uIt5sCKl7e/OFoBe/Au
         Dt5Q==
X-Gm-Message-State: ALoCoQkAwzIrZUA5Xh17T/dSA+FlAy2zE0SIEdWfcQmmNH9IUlzy1flK30QWO3rW3zhxDIwQjid0
MIME-Version: 1.0
X-Received: by 10.182.48.230 with SMTP id p6mr800346obn.1.1377279752356; Fri,
 23 Aug 2013 10:42:32 -0700 (PDT)
Received: by 10.182.120.7 with HTTP; Fri, 23 Aug 2013 10:42:32 -0700 (PDT)
In-Reply-To: <1377134300-25480-1-git-send-email-syin@broadcom.com>
References: <1376606573-15093-1-git-send-email-syin@broadcom.com>
        <1377134300-25480-1-git-send-email-syin@broadcom.com>
Date:   Fri, 23 Aug 2013 19:42:32 +0200
Message-ID: <CACRpkdZeET601+jOsjQxu-VAhi1owgtMX60Fij=uU489eGVFXg@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: Pass all configs to driver on pin_config_set()
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sherman Yin <syin@broadcom.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        Matt Porter <matt.porter@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Thu, Aug 22, 2013 at 3:18 AM, Sherman Yin <syin@broadcom.com> wrote:

> When setting pin configuration in the pinctrl framework, pin_config_set() or
> pin_config_group_set() is called in a loop to set one configuration at a time
> for the specified pin or group.
>
> This patch 1) removes the loop and 2) changes the API to pass the whole pin
> config array to the driver.  It is now up to the driver to loop through the
> configs.  This allows the driver to potentially combine configs and reduce the
> number of writes to pin config registers.
>
> All c files changed have been build-tested to verify the change compiles and
> that the corresponding .o is successfully generated.
>
> Signed-off-by: Sherman Yin <syin@broadcom.com>
> Reviewed-by: Christian Daudt <csd@broadcom.com>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>

Didn't you get review from Stephen Warren?

> ---
> Please refer to the discussion with Linus W. "[PATCH] ARM: Adds pin config API
> to set all configs in one function" here:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/166567.html
>
> All c files changed have been build-tested to verify the change compiles and
> that the corresponding .o are successfully generated.
>
> [v2]    rebased on LinusW's linux-pinctrl.git "devel" branch.  Fixed and build-
>         tested pinctrl-sunxi.c
> ---
>  drivers/pinctrl/mvebu/pinctrl-mvebu.c |   26 +++--
>  drivers/pinctrl/pinconf.c             |   42 ++++----
>  drivers/pinctrl/pinctrl-abx500.c      |  187 ++++++++++++++++++---------------
>  drivers/pinctrl/pinctrl-at91.c        |   48 +++++----
>  drivers/pinctrl/pinctrl-bcm2835.c     |   43 ++++----
>  drivers/pinctrl/pinctrl-exynos5440.c  |  113 +++++++++++---------
>  drivers/pinctrl/pinctrl-falcon.c      |   63 ++++++-----
>  drivers/pinctrl/pinctrl-imx.c         |   28 ++---
>  drivers/pinctrl/pinctrl-mxs.c         |   91 ++++++++--------
>  drivers/pinctrl/pinctrl-nomadik.c     |  125 ++++++++++++----------
>  drivers/pinctrl/pinctrl-rockchip.c    |   57 ++++++----
>  drivers/pinctrl/pinctrl-samsung.c     |   17 ++-
>  drivers/pinctrl/pinctrl-single.c      |   33 ++++--
>  drivers/pinctrl/pinctrl-st.c          |   11 +-
>  drivers/pinctrl/pinctrl-sunxi.c       |   95 +++++++++--------
>  drivers/pinctrl/pinctrl-tegra.c       |   69 ++++++------
>  drivers/pinctrl/pinctrl-tz1090-pdc.c  |  135 ++++++++++++++----------
>  drivers/pinctrl/pinctrl-tz1090.c      |  140 +++++++++++++-----------
>  drivers/pinctrl/pinctrl-u300.c        |   18 ++--
>  drivers/pinctrl/pinctrl-xway.c        |  119 +++++++++++++--------
>  drivers/pinctrl/sh-pfc/pinctrl.c      |   42 ++++----
>  drivers/pinctrl/vt8500/pinctrl-wmt.c  |   54 +++++-----
>  include/linux/pinctrl/pinconf.h       |    6 +-
>  23 files changed, 889 insertions(+), 673 deletions(-)

Please try to put all the maintainers for the above files on the To: line
so they get a chance to review/ack the patch.

Yours,
Linus Walleij
