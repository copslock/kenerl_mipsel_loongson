Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Aug 2013 00:14:12 +0200 (CEST)
Received: from mail-oa0-f54.google.com ([209.85.219.54]:65527 "EHLO
        mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6839460Ab3HUWOIyKqXs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Aug 2013 00:14:08 +0200
Received: by mail-oa0-f54.google.com with SMTP id o6so2054421oag.41
        for <linux-mips@linux-mips.org>; Wed, 21 Aug 2013 15:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8knI7xwhXbv9oR672p9NYX0aJgMAPkaHw5AshrafYmE=;
        b=kvuzhSCCeYC9SQ7Kq4I5gUwsGwBLKdGyTwB0/xQQrw2LRTaXG3+zXAz6HDHUoaSHyi
         tMi3pkNrhzqv/B1NZa59k1sO6ZY5j21Jnouy2F1w51mBEYH6GgeSPBZSgw8Ah2gf26Ss
         GF1IeGxcKKOU28oCZBPlIxJmHLwNCaSMqLiGw/xKOKhE7WhYMNCJhsX15Ceh1w2p4atc
         q978RCGcWXyrVcClBPsLbM4LUp8G4zkrLpvEYrt015zl7c+U8g9B/RMrz9BVCBZizNFW
         wIvG/EV+grY1/rJ1H1N9WVsfNZyTjWKUgW3RpgiQXCWBhxYgEE+OGp2E9K7K10gBpcNB
         sK7A==
X-Gm-Message-State: ALoCoQmCqGuThatru0Lt9b0+AwGMTlngE+833RxPGGmh7WoDi5EwYEDg8S1YAG1yivLU5sPnDS6j
MIME-Version: 1.0
X-Received: by 10.50.118.105 with SMTP id kl9mr1154362igb.3.1377123242359;
 Wed, 21 Aug 2013 15:14:02 -0700 (PDT)
Received: by 10.42.79.9 with HTTP; Wed, 21 Aug 2013 15:14:02 -0700 (PDT)
In-Reply-To: <1376606573-15093-1-git-send-email-syin@broadcom.com>
References: <1376606573-15093-1-git-send-email-syin@broadcom.com>
Date:   Thu, 22 Aug 2013 00:14:02 +0200
Message-ID: <CACRpkdaUacAbLd+i4Y=DXv=aSaUwBSz6-icPV9SVjxZkUjheww@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Pass all configs to driver on pin_config_set()
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sherman Yin <syin@broadcom.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        matt.porter@linaro.org, Christian Daudt <csd@broadcom.com>,
        Markus Mayer <mmayer@broadcom.com>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37636
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

Hi Sherman,

On Fri, Aug 16, 2013 at 12:42 AM, Sherman Yin <syin@broadcom.com> wrote:

> When setting pin configuration in the pinctrl framework, pin_config_set() or
> pin_config_group_set() is called in a loop to set one configuration at a time
> for the specified pin or group.
>
> This patch 1) removes the loop and 2) changes the API to pass the whole pin
> config array to the driver.  It is now up to the driver to loop through the
> configs.  This allows the driver to potentially combine configs and reduce the
> number of writes to pin config registers.
>
> Signed-off-by: Sherman Yin <syin@broadcom.com>
> Reviewed-by: Christian Daudt <csd@broadcom.com>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> Change-Id: I99cbfa2ae7b774456eb71edb276711b1ddcd42c8
> ---
> Please refer to the discussion with Linus W. "[PATCH] ARM: Adds pin config API
> to set all configs in one function" here:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/166567.html
>
> All c files changed have been build-tested to verify the change compiles and
> that the corresponding .o are successfully generated.

Good work! This is obviously the right thing to do and it's looking
very good.

Right now this does not apply to my "devel" branch, so I'd like you
to rebase on that right now. (This is what will go into v3.12).

This is also late in the development cycle so I believe this is going to
be v3.13 material unless there are more release candidates.

You can also hold on until after the v3.12 merge window and then
rebase it and we'll merge it as a first patch in the v3.13 development
cycle.

What do you say?

Yours,
Linus Walleij
