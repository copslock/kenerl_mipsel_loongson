Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 15:32:05 +0200 (CEST)
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33553 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026138AbcDFNcBAQl7W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Apr 2016 15:32:01 +0200
Received: by mail-oi0-f50.google.com with SMTP id w85so57916344oiw.0
        for <linux-mips@linux-mips.org>; Wed, 06 Apr 2016 06:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=/5dP1SCdREVjMitArSG8uzEfwKpYjWoYC5H7hJQewEM=;
        b=AUcq/EUcq1hQ/okPe9He+WhdHZXTbPTEvsWWTOzkerkXuDHhDWx0/yzWxzTMucGkUR
         K1Faz5KJ0xPTK30YQgX2v0uGexoUimLQa5nLyn8wPMwXmnVB5WFCEXNMF7uKPypKiIfd
         7dk4uCFAQXeMd4cye602Gb9Vp+w9DwpaH17yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/5dP1SCdREVjMitArSG8uzEfwKpYjWoYC5H7hJQewEM=;
        b=PSVk5KBqgFNIMOD6sbTDfxGMI6/GIA8yGZ3HhbDK+tznrXsyD4PUppdiuc3DBAW7sW
         jxWinsvDtBK/L6GfhfrZ3U7K0eF/Y/nsQQ7iYSmTTbanLWJhWDhTcWFJlWRlZxPM3vz6
         Z3rNwGZn6/hXLwqC9uaU8TGgkM/j1+O1o+ZhDUw621hw4bDEWOyl/a0oyTgBPgJSB6OU
         sEuEzmmpwne9iJiZz02zzIQMItZnt4GJAr5Qt1jrip+pxUifkR45IXYnX5SbVGhdqA2s
         ED9NX0zp9UL9zCiJBB/uWqW8t1H1yRgJlBoW4VMv7N0juHwu70HBPLQYRl6uqKpgkIJA
         oAvA==
X-Gm-Message-State: AD7BkJKdTdCqnK+s8F6aLvTxI3SZ88GG07oXzroVgDecrFIRRzM3EwGiWqnpxO+adxAggrBMgevSpZa0f9hmskQF
MIME-Version: 1.0
X-Received: by 10.202.187.68 with SMTP id l65mr11296588oif.94.1459949513594;
 Wed, 06 Apr 2016 06:31:53 -0700 (PDT)
Received: by 10.182.55.105 with HTTP; Wed, 6 Apr 2016 06:31:53 -0700 (PDT)
In-Reply-To: <1459946095-7637-6-git-send-email-keguang.zhang@gmail.com>
References: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
        <1459946095-7637-6-git-send-email-keguang.zhang@gmail.com>
Date:   Wed, 6 Apr 2016 15:31:53 +0200
Message-ID: <CACRpkdYGjz5n4Cw=cE45-KeWLZ1ZK82MMVEe5sYxkoCbNfZ-Yw@mail.gmail.com>
Subject: Re: [PATCH V1 5/7] gpio: Loongson1: add Loongson1 GPIO driver
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     Linux MIPS <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dmaengine@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52914
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

On Wed, Apr 6, 2016 at 2:34 PM, Keguang Zhang <keguang.zhang@gmail.com> wrote:

> From: Kelvin Cheung <keguang.zhang@gmail.com>
>
> This patch adds GPIO driver for Loongson1B.
>
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>

Nice and pretty driver.
Patch applied for v4.7.

Yours,
Linus Walleij
