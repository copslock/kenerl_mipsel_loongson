Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 22:44:48 +0100 (CET)
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37920 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011794AbbLIVopmFOhi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 22:44:45 +0100
Received: by wmec201 with SMTP id c201so92785466wme.1;
        Wed, 09 Dec 2015 13:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EKCM4pKjl8IKn44eWhnP53rbDW+/3zjfM2H2HT+YOaU=;
        b=qoZNuHdbZ18Fm5sHzHeOHRSQFGeGSrbM+EP26x14kdeWSfpDx5zfrON7pSGoAG6+sD
         omwclY/nLHJo8Q7jRMr+BkESJFbK6Z3Vuc/t87cdKC25lgXtYAEDlOSDX101+H4jJh9M
         M3lAcc3WIsRCIbaF8UWA6EHeSxFu+fP3EeIRYAdMQXyZ97YCIPb5A8kQX6t03dNaOZlv
         krH6Q08mTAkp57TekCLo5gge6Lk396DKAZkNz/DMN30BMUNwjbDIcQ/6JAsEf6Er0QMO
         K5aZ7vwtKfn7XmNg+xIUvEHPbiQI5mIgUl6F6gsMOH+1dZ7aVCO3wW/k2/kyWam7GfhN
         qbLQ==
X-Received: by 10.194.242.195 with SMTP id ws3mr8402323wjc.131.1449697480511;
 Wed, 09 Dec 2015 13:44:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.216.85 with HTTP; Wed, 9 Dec 2015 13:44:01 -0800 (PST)
In-Reply-To: <1449668342-4446-1-git-send-email-linus.walleij@linaro.org>
References: <1449668342-4446-1-git-send-email-linus.walleij@linaro.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Wed, 9 Dec 2015 22:44:01 +0100
Message-ID: <CAOLZvyGe5SV044P+uje5ro+F5yHoUVqz6or4QBMfdCgXW92sbA@mail.gmail.com>
Subject: Re: [PATCH 135/182] MIPS: alchemy: switch to gpiochip_add_data()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Michael Welling <mwelling@ieee.org>,
        Markus Pargmann <mpa@pengutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Wed, Dec 9, 2015 at 2:39 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> ---
> Ralf: please ACK this so I can take it through the GPIO tree.
> BTW: would be nice if the MIPS GPIO drivers could move down
> to drivers/gpio in the long run.

Is there a specific reason?  I have no objections to moving it, but
on the other hand I also like that (in this case) most/all chip-specific
code is grouped together and not scattered around the tree.

Manuel
