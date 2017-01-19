Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2017 07:39:10 +0100 (CET)
Received: from mail-qt0-x234.google.com ([IPv6:2607:f8b0:400d:c0d::234]:34982
        "EHLO mail-qt0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992903AbdASGjEBX26I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2017 07:39:04 +0100
Received: by mail-qt0-x234.google.com with SMTP id x49so51715174qtc.2
        for <linux-mips@linux-mips.org>; Wed, 18 Jan 2017 22:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5Jz4pj3a1uqg0Xiith9F/TmQ7vwzTk+YpBdimMrlG50=;
        b=IAo5HmC00ic5jnEUYH7+ssjF9Q8ALYFlM1HhJeDb8uMCRsZrcscMqvOn+AuAw7I6TU
         fotIG0lqXjSF7W9Ifrw1/re1KeHsnVuQUQBsEauApzgx+aAnuepGbNEZYQvKy1FUtkar
         VYuADr4ooJ3ySALV3Qxwsu1XODOeoZaSAGkkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5Jz4pj3a1uqg0Xiith9F/TmQ7vwzTk+YpBdimMrlG50=;
        b=S+S74sNHzIPgZB7geaIKQiEUBid32kPb4irD2Bsh0HrRUICp5/9MHYh2g3771Qy1s8
         UqBjqtwiNZAOEaOCoP110PiuOu1Mt67XxyzbJvzkRm7OogcTd8YiCisMsopXeYmC66FK
         PLNtv34ALvNkADEeHs2oHQkfGK9nKlwuWrYkVaN1yZls7pWam4Jj6dznWdoEU4fFTD6z
         bb35ouWShi2SBawcv0Cu2TF0plV8mAsImmxjRudvucky2ayr4CZKHrv4SyTZg6TkQMc8
         tA44m5HZmPCAtgyxHYn5wiSMjPx2qq16YJ9TAKgHxb478EU7HZYn8SrCQMa46khLXjj3
         B0TA==
X-Gm-Message-State: AIkVDXL4HPmVF6hcd/TQ09ZtidTaQXKo6wBovSW+AU6qX6R+nhuumoELeAzFNqkFJY85wW04ninmvFIfY6BWcc1v
X-Received: by 10.55.207.197 with SMTP id v66mr1117172qkl.116.1484807938181;
 Wed, 18 Jan 2017 22:38:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.177.145 with HTTP; Wed, 18 Jan 2017 22:38:57 -0800 (PST)
In-Reply-To: <20170117231421.16310-1-paul@crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Jan 2017 07:38:57 +0100
Message-ID: <CACRpkdYJFsgVN4Q+7XbMcNC1topUan7+o6PCBWBC4aifM8sq-g@mail.gmail.com>
Subject: Re: [PATCH 00/13] Ingenic JZ4740 / JZ4780 pinctrl driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56405
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

On Wed, Jan 18, 2017 at 12:14 AM, Paul Cercueil <paul@crapouillou.net> wrote:

> One problem still unresolved: the pinctrl framework does not allow us to
> configure each pin on demand (someone please prove me wrong), when the
> various PWM channels are requested or released. For instance, the PWM
> channels can be configured from sysfs, which would require all PWM pins
> to be configured properly beforehand for the PWM function, eventually
> causing conflicts with other platform or board drivers.

Why do you think this?

- Pincontrol handles can be obtained at runtime.
- Pincontrol states can be changed at runtime.

The fact that a the handle is retrived by the device core and set to
the states named "init" or "default" during boot is just a convenience.

You can have as many and as fine-grained states as you want. They
can pertain to just one pin too.

Linus Walleij
