Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 13:25:44 +0200 (CEST)
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33074 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012078AbbHCLZmfrjTE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Aug 2015 13:25:42 +0200
Received: by oig1 with SMTP id 1so34745512oig.0
        for <linux-mips@linux-mips.org>; Mon, 03 Aug 2015 04:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BbssXS9Bt4o2l5u1tUtRfhRNYMv/8afTNgEkTJa/YVI=;
        b=YD4cH7HLioOXm1+RNrRaYDCIx4MOiaabauEe2uimpVke2M791U0hACLLjtFZU4LTEA
         1bgq/OxfBuKtfLqQ0E0KjsM9YxLy4JaGvwYGgTE0V6X2OSa0w3aOHI8VTMQNs/F8eXJl
         xFcIQ8JQm15+mDRleZ1F0mjIKAnKPBDqhh+c7GjmqH//d348h6AMklVmIWgeAlRyu3Zw
         k55BsnMzr4b34aqMxIj5wc/c8R6cxK7AGlhR3yvQUqpKAYujWco+C2Vv1Y/0TnFkD2Qh
         zrnc0ym7X86qP4xecgOjAbzNwGbtHsdSpR4xYrohS+RrWytvdXG49UXnElktf5fUdGbO
         yBPQ==
X-Gm-Message-State: ALoCoQm1BlhxnH3Hy0suGg8xuJCeqIM0+1v0G7hNx4Pri3xNTOOuzgR0e4ZdNmDfzdUxKgPtWHWg
MIME-Version: 1.0
X-Received: by 10.202.65.67 with SMTP id o64mr15372679oia.45.1438601136734;
 Mon, 03 Aug 2015 04:25:36 -0700 (PDT)
Received: by 10.182.204.100 with HTTP; Mon, 3 Aug 2015 04:25:36 -0700 (PDT)
In-Reply-To: <20150803072332.GC16650@linux-mips.org>
References: <1438277338-7246-1-git-send-email-albeu@free.fr>
        <CACRpkdbUhYysC+mGuJY6Y8kd18LQLoWu+av81+ZD4UZo2nM-Yw@mail.gmail.com>
        <20150803072332.GC16650@linux-mips.org>
Date:   Mon, 3 Aug 2015 13:25:36 +0200
Message-ID: <CACRpkdYk13TQXYVfG0cOvmz9RTZ717rFWax+fij7oPbaUoqpOA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Remove all the uses of custom gpio.h
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Alban Bedel <albeu@free.fr>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Florian Fainelli <florian@openwrt.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Joe Perches <joe@perches.com>,
        Daniel Walter <dwalter@google.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Varka Bhadram <varkabhadram@gmail.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Michael Buesch <m@bues.ch>,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        abdoulaye berthe <berthe.ab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48542
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

On Mon, Aug 3, 2015 at 9:23 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Aug 03, 2015 at 09:13:27AM +0200, Linus Walleij wrote:
>
>> Very good job being done here.
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> I guess this better go in through the MIPS tree.
>> Given all the OpenWRT ports using MIPS this is excellent
>> progress for a large hobbyist community.
>
> Alban has posted a v2 [1] already but I take it that your Reviewed-by: applies
> to the v2 patch as well?

Sure thing. Green light for this.

Yours,
Linus Walleij
