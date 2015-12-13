Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Dec 2015 21:25:56 +0100 (CET)
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34939 "EHLO
        mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013272AbbLMUZyzZlna (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Dec 2015 21:25:54 +0100
Received: by obc18 with SMTP id 18so117400110obc.2
        for <linux-mips@linux-mips.org>; Sun, 13 Dec 2015 12:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gAhVnIIwgo1H4W0516KJm3L0GG/UlN+9eVxTanPsvrA=;
        b=NLtyh1LhsJ0cy5+Zrqwx3MyioWu7oXrxr/4OpDZT8944kWcm1TYt7JHVdvXIpS6Xzn
         bpiqDvYusgHXhuBvacstvq9RJVoUZq1p8zqexk+Tkuma+jYXvjOhKRQ0OzZLwPOhmhiR
         YBuztYRRZNtOvHgm89iXEvLncDn35WOdQcx0xSRLqgdBdDupz+L1nxSMM4R4ItVWE6tL
         F2sChyLB8EQwusZPSSUretmmaS3WvBoG3DqXfYNl2XN7dHR/QsgjqAUqKjK+Lv5/BgL6
         STz6/9I+/3AJV9k541VnY3HS3i/xnLxMtOETfUisp99vyIQOVOwwdSHCrlyl7UD7Evh4
         J59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=gAhVnIIwgo1H4W0516KJm3L0GG/UlN+9eVxTanPsvrA=;
        b=V5rfB9QQc9TYP++GFB5KwHVcvSX1Bk8blZHHUUUQtKg6BLEw1gMj84quBzbwkiKU3z
         xx0tqlyMZsEa+HIYsX/Ze6LQ8Cyvk7xdu7acQicP7fRbXAPOwYtdRyh+oF5AjJOx3SK/
         OqnSOkZbXPpUlf0TPosLjcEQrH6y7gZU9FGFxWfEqh7Df+jABNyd1HEUifJvV+ZKX6B2
         Lgtlw2LDtqsDlYSGiVVc8BQAD/zplIZMDF0UEyPg7AaKbSgkMzVIq/avZSZqyLHWwvlt
         Z2nJkvOoQxM2k9p6lWN0thaMGfQ5622Nvd/jZ71+/lacg/XZY5KJih06lQJQkhpay90K
         iV8A==
X-Gm-Message-State: ALoCoQkD25b0kKsysnEJnc3E3GpYqhSF+DEB3Yx5DBaB0POv351YdxA847ByZ1NY23r2h/LPYoCdofxIqV/diUUvicA4ge+9DK+QtMxg9UH07Y3Kl8V1exw=
MIME-Version: 1.0
X-Received: by 10.182.247.105 with SMTP id yd9mr22431546obc.21.1450038348738;
 Sun, 13 Dec 2015 12:25:48 -0800 (PST)
Received: by 10.182.32.70 with HTTP; Sun, 13 Dec 2015 12:25:48 -0800 (PST)
In-Reply-To: <CAOLZvyGe5SV044P+uje5ro+F5yHoUVqz6or4QBMfdCgXW92sbA@mail.gmail.com>
References: <1449668342-4446-1-git-send-email-linus.walleij@linaro.org>
        <CAOLZvyGe5SV044P+uje5ro+F5yHoUVqz6or4QBMfdCgXW92sbA@mail.gmail.com>
Date:   Sun, 13 Dec 2015 21:25:48 +0100
Message-ID: <CACRpkdbmpE5i4_WmUcG-EZZBrTKpAtLwjLwrH48F6hxGEA9JvQ@mail.gmail.com>
Subject: Re: [PATCH 135/182] MIPS: alchemy: switch to gpiochip_add_data()
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Michael Welling <mwelling@ieee.org>,
        Markus Pargmann <mpa@pengutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50569
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

On Wed, Dec 9, 2015 at 10:44 PM, Manuel Lauss <manuel.lauss@gmail.com> wrote:
> On Wed, Dec 9, 2015 at 2:39 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> ---
>> Ralf: please ACK this so I can take it through the GPIO tree.
>> BTW: would be nice if the MIPS GPIO drivers could move down
>> to drivers/gpio in the long run.
>
> Is there a specific reason?  I have no objections to moving it, but
> on the other hand I also like that (in this case) most/all chip-specific
> code is grouped together and not scattered around the tree.

Here is a reason. This patch series. If I could just change all that and have
the dependencies inside the GPIO tree, refactoring struggles would be
so much easier.

Yours,
Linus Walleij
