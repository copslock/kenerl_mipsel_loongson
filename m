Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 May 2017 20:23:44 +0200 (CEST)
Received: from mail-qt0-x22c.google.com ([IPv6:2607:f8b0:400d:c0d::22c]:36199
        "EHLO mail-qt0-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993457AbdE3SXhlLgAI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 May 2017 20:23:37 +0200
Received: by mail-qt0-x22c.google.com with SMTP id f55so76979385qta.3;
        Tue, 30 May 2017 11:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h7WQVNTOSy2lSLZRiK6CwCjoDXxtiXf6eADqMJXqb1w=;
        b=N8mxJKvWK7oR0pKS98wzOdPDE4uhyJMeqJwKD0NvvYq27IbPnr3zVqeMekVN0bgVmW
         y5+XZoHZd31NcKl6/FRC9MR84lE07FsUHgG9j6q0Nhq+HuXLnueuWY/3hUqkl9iEaeOX
         bMokv4lqVROFp+uxvTVvrfdsaR9GI3ATjWNrYr5RYBzIYPLnYiG4sF1wm22qgwhmtGZA
         bGMhhQBfm3oSb6mUwNrt9GwTNdVKYorsBr6llMwkP4RuWPIx8D6NwmDaqitLuyz6YoVM
         yG0t9RIkUBYP0K4+J9uJXFYDPghirOAFbjNpMqrWbNO90ZfFr3a29wu0eCs42n+dcpZH
         QrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h7WQVNTOSy2lSLZRiK6CwCjoDXxtiXf6eADqMJXqb1w=;
        b=P6n21L+Hkb/8+9t1g20ELH21/4LKbx5/ZUFUb9YEvk/g/gFAEC+GD+LnbvIlyyWrBt
         5X/LRkhHlFMcVP0Tfe3tzfHzpsPcDoUZv7xgbEULF1c7K3WDppk1/mF2pQe3LbyeFOGe
         DNoC8pSuvm6X7jbPBi0o2xUK3n+yXOQNUGf134YG00t+7LEE/LSs2H6q3XAz5iGHGIvc
         D6iRvG8Nih6ZzBzdX7sVbG201eQyGP7mWD751tAONixXXf4/z4kOB0JEVc+7H2e7/rNw
         Ul0E5p3vhKLFfGCbZfivUEF530RcKRj8EBB5k3vALtEFJF5zU4jqcJPLKZtTqBt/Vo57
         kCiQ==
X-Gm-Message-State: AODbwcAAdC+i0QAHSVSZZNGCZ1dBB3/5eG0SjM+JWYAU4KDqA5Lq/+mj
        rY8xnPNrfLrK7HJu5pV5xUKF9GtzSQ==
X-Received: by 10.237.62.12 with SMTP id l12mr25096662qtf.20.1496168607010;
 Tue, 30 May 2017 11:23:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.152.71 with HTTP; Tue, 30 May 2017 11:23:26 -0700 (PDT)
In-Reply-To: <20170528184006.31668-9-hauke@hauke-m.de>
References: <20170528184006.31668-1-hauke@hauke-m.de> <20170528184006.31668-9-hauke@hauke-m.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 May 2017 21:23:26 +0300
Message-ID: <CAHp75VcU3cF07GQG5vPV9uhmpOzO2aGD8Fj9-Do4yN3BXNN1Rg@mail.gmail.com>
Subject: Re: [PATCH v3 08/16] MIPS: lantiq: Convert the fpi bus driver to a platform_driver
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        "martin.blumenstingl" <martin.blumenstingl@googlemail.com>,
        john <john@phrozen.org>, linux-spi <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
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

On Sun, May 28, 2017 at 9:39 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Instead of hacking the configuration of the FPI bus into the arch code
> add an own bus driver for this internal bus. The FPI bus is the main
> bus of the SoC. This bus driver makes sure the bus is configured
> correctly before the child drivers are getting initialized. This driver
> will probably also be used on different SoC later.

> +Optional properties:
> +- regmap               : A phandle to the RCU syscon

> +- offset-endianness    : Offset of the endianness configuration register

Shouldn't be one of

big-endian;
little-endian;
native-endian;

?

For what purpose that register is used?
Is it configurable in RTL? IOW why you need to have it in DT?

> +               offset-endianness = <0x4c>;
> +               big-endian;

> +       /* RCU configuration is optional */
> +       rcu_regmap = syscon_regmap_lookup_by_phandle(np, "regmap");

> +       if (!IS_ERR_OR_NULL(rcu_regmap)) {

_OR_NULL is suspicious. You are doing something wrong.

-- 
With Best Regards,
Andy Shevchenko
