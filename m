Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Mar 2015 11:02:55 +0100 (CET)
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34763 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008665AbbCRKCyAkpd2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Mar 2015 11:02:54 +0100
Received: by oier21 with SMTP id r21so31905116oie.1
        for <linux-mips@linux-mips.org>; Wed, 18 Mar 2015 03:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Rl54zVgRKLonxcd8Ig+/Lj9NzEDH6deRMAWzwTuV0Eo=;
        b=L+6h7waWJeiWFnvGiyHvXP2pS3+A6iOdd+UtD6qaswVUIc/PQcuOf78/n0pAI8o9K6
         UWFQX64wLQmaWReQFPA2iMdYwZj2McigZQTlGeEx9PfQMZCABPCEI4QPjUZjqBqk4ZfZ
         ifA5RjvNgRUoFyas6WH3J1GmJK24k+ZQ+Ox7PHSCmo3yyRmz1chPP/jHgv2dY0UoCL3Q
         eg5wtNnknquWXKrpfC7q3WYJsJuxoFtPwlgcMxJPeiTALojPSs0wC/Vd4sCdZN21+Gou
         zXi1Tr99UIGJHNyQUlHZnOL1C8kL19M2XLZFag9M3qGCmdA+wBMuO77G7WDY8KLaS8Kr
         632Q==
X-Gm-Message-State: ALoCoQn/DrUTm0mLdw1hE1nBlhwQuCZThVFyoRXZIfB+HBI9k6Vt9bm1NiQaMyVhc9wSQVG1ZB2X
MIME-Version: 1.0
X-Received: by 10.182.241.99 with SMTP id wh3mr13343721obc.81.1426672968705;
 Wed, 18 Mar 2015 03:02:48 -0700 (PDT)
Received: by 10.182.180.4 with HTTP; Wed, 18 Mar 2015 03:02:48 -0700 (PDT)
In-Reply-To: <5500803A.7080409@freebox.fr>
References: <54FDDE00.7030100@freebox.fr>
        <54FFD15E.3040202@nvidia.com>
        <5500803A.7080409@freebox.fr>
Date:   Wed, 18 Mar 2015 11:02:48 +0100
Message-ID: <CACRpkdYqkZAyV1kXVHWYP8TCSqRF9X7fLOcsKNu8wL7t0MX2Mg@mail.gmail.com>
Subject: Re: bcm63xx gpio issue on 3.19
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Nicolas Schichan <nschichan@freebox.fr>
Cc:     Alexandre Courbot <acourbot@nvidia.com>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46438
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

On Wed, Mar 11, 2015 at 6:49 PM, Nicolas Schichan <nschichan@freebox.fr> wrote:

> Moving the bcm63xx_gpio_init() call from board_prom_init() to
> bcm63xx_register_devices() (an arch_initcall) is enough to get called when
> kmalloc is working. If code poking GPIOs is invoked earlier by a board code,
> it will have to move in the board_register_devices() function though there
> doesn't seem to any problems with the mainline bcm63xx board code in that regard.
>
> I can produce a patch for that if it is an accepted solution. It has the
> advantage of not requiring changes to the gpiolib code.

It would be *awesome* if you can come up with a patch like this.
Because it makes our life so much more simple.

(Maybe there is already such a patch in my INBOX somewhere...)

Yours,
Linus Walleij
