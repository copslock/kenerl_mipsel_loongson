Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jun 2017 14:23:09 +0200 (CEST)
Received: from mail-qk0-x22b.google.com ([IPv6:2607:f8b0:400d:c09::22b]:33796
        "EHLO mail-qk0-x22b.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992160AbdF3MXCf0ipM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jun 2017 14:23:02 +0200
Received: by mail-qk0-x22b.google.com with SMTP id d78so98902228qkb.1;
        Fri, 30 Jun 2017 05:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dIx6h6xzUutg7K091U1neMjooGAbOLYMeN5eW0vZemg=;
        b=JH7KJ/XbSh00Pg4522zV+jmStLdJy68h2BkJK/u4c69sXW8PzaeR2OpH2sQmQ0SPJR
         SFyKovmyBJLWN34iU7ro6biaNKrksPAs1pBuPEmdyWN+OOX25ehvugAzFHKwL3ybHIkQ
         z0VdvL3vMKQ8L/2wUXpCGPXIDCREUMb4+rwvnGlUT1hb0lln4mq2U899qtMwmlN6Bbcg
         ziNY7M7G2uQLO9yZLNCucUe4J3v8b/Q5WeD/JdMi8H3VLlvE33dRPkolCj62tn609q3a
         Rhc9bqgTJVpY2RjX+Mvp5zug0qRq2vs7KUnGKOZdQOUsieS3mFTqw76Lmd0SDetn+Ti1
         3Xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dIx6h6xzUutg7K091U1neMjooGAbOLYMeN5eW0vZemg=;
        b=RM8EwieziozJ7IBTz+iHdT/9e2S+aZ5+lFgfnDWCHFPT/kYc41XByXO/D03DjeaepR
         w7eh6eM4sZED7Xg6PqwGr9BYgY1CqyYP+lpgvEZTV4rcScbbs+d4rzHivaD0kllRso1c
         +7PYeJlS0XWR958AhyN0pTdP8G6prc9zUCMN3FlQyrWiOF05SRt5L5PhvEX8uvhL3sz2
         dtWwnY8Os/GGsSXuuCJcpwLe4GbzfKqctz0ssTkbQy+3v4WLY31boFwuXjIAWYIRGxhH
         P82HIeGQlxZO2a7M6tUs/rzCrGf8ZvgsF7hLYagvcMSGHGTgdl9Bq+4UFfQxr3GfgNf/
         uMgg==
X-Gm-Message-State: AKS2vOzS6HsCLQPJqO/w4oJFNM5RIL306WNr4h8iRKeVZdys+1Ad3RxG
        hVp+KWfIYnsjfNMw8b9L9CLzkWk+3Q==
X-Received: by 10.55.15.234 with SMTP id 103mr23290172qkp.242.1498825376932;
 Fri, 30 Jun 2017 05:22:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.137 with HTTP; Fri, 30 Jun 2017 05:22:56 -0700 (PDT)
In-Reply-To: <20170629213951.31176-11-hauke@hauke-m.de>
References: <20170629213951.31176-1-hauke@hauke-m.de> <20170629213951.31176-11-hauke@hauke-m.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Jun 2017 15:22:56 +0300
Message-ID: <CAHp75Ve+oO7Zzk4jN3BOVCWWsEVki0yNQfpkfuw4Q5K85CMQHg@mail.gmail.com>
Subject: Re: [PATCH v6 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
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
X-archive-position: 58940
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

On Fri, Jun 30, 2017 at 12:39 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:

> +static int lantiq_rcu_reset_update(struct reset_controller_dev *rcdev,
> +                                  unsigned long id, bool assert)
> +{
> +       struct lantiq_rcu_reset_priv *priv = to_lantiq_rcu_reset_priv(rcdev);
> +       unsigned int set = id & 0x1f;


> +       int ret;
> +       u32 val;
> +
> +       if (assert)
> +               val = BIT(set);
> +       else
> +               val = 0;

I would put this as

u32 val = assert ? BIT(set) : 0;
int ret;

...but it's up to you.

The rest looks fine.

> +
> +       ret = regmap_update_bits(priv->regmap, priv->reset_offset, BIT(set),
> +                                val);
> +       if (ret) {
> +               dev_err(priv->dev, "Failed to set reset bit %u\n", set);
> +               return ret;
> +       }
> +
> +
> +       ret = lantiq_rcu_reset_status_timeout(rcdev, id, assert);
> +       if (ret)
> +               dev_err(priv->dev, "Failed to %s bit %u\n",
> +                       assert ? "assert" : "deassert", set);
> +
> +       return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko
