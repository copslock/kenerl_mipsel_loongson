Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 00:47:15 +0100 (CET)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34408 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010714AbcATXrNXq850 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jan 2016 00:47:13 +0100
Received: by mail-lb0-f170.google.com with SMTP id cl12so14191777lbc.1
        for <linux-mips@linux-mips.org>; Wed, 20 Jan 2016 15:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=G2c4dFpm4Pq26ciFmFJdQizpKA42WQguSxlnxiSIJSg=;
        b=PypkNaepUEkuwmdury2nkNJA0vj8Z7vE2AmU2ibBIrnpuwivDyPj03XYTyu/o7yHNB
         cBg4C9p4zCBaDVHbgy2yUBqT5eOGbW2KKG1eMlRykeKi2TGKQxgbPaVP8+e5njiCjhYY
         M2qOAX8dY1h3wAALvlYpzDi+XVoOs1FTeqlXVUYEHcb/KDbYFOLdpyHHhBNCoiZoCzT4
         EaW6TwL36s8WqiK87ieSm/jxM+KGi4jUBCEGoEjr3HXRJ6Pk0vxSwJGonvhj+8cy1MrV
         Ij4/oih9lksYRv0UnbYZA2jaq2QVUcSIUY7rrBRc6+4MnYvJtirFXDFYLncZU4b+Og7B
         Bm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=G2c4dFpm4Pq26ciFmFJdQizpKA42WQguSxlnxiSIJSg=;
        b=gl5+K2ToWfv2F/07i5zk/zYWth4xiU5hhBQqwAwl+UwjjqZc4EC5nHwD8i1qhvqICF
         EjPYyMNA55+ZTo5zWk7MDcCk52ZoqVeneh4kKMKwTmIfQ3LkvXeyJaNfPK1vxAmBCLD/
         dba+Zv5d52kizm3+1J3FL3+s3S03WZ37fpYnSw1PxKd30rRA5rChqRlmzaBwLxziX3Xb
         iq0eJnse+Lnb0ELdrOjrUG4Fi5TUD/VZM0Ehxf8DHY69nQysUWASn3xTg0P4nG/xDFpZ
         DxvfsjyCp8S3zlvhYm7GFLmoRnCoEKquOuYJcomuAKaHRMiNQQ9ovwG5SO/kw1iuZpvf
         XBWQ==
X-Gm-Message-State: ALoCoQmlRdzVcV+GWsiEC5bdjqLTxza9IppE8f7zqTwhcLfALtyNUuVrQ4TE4TaNG/nfgo3Z/KgnOYbuo8HPrmRYo30ypF4ftA==
X-Received: by 10.112.12.233 with SMTP id b9mr12279122lbc.63.1453333627745;
        Wed, 20 Jan 2016 15:47:07 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id e130sm5020419lfe.9.2016.01.20.15.47.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Jan 2016 15:47:06 -0800 (PST)
Date:   Thu, 21 Jan 2016 03:12:15 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alban <albeu@free.fr>
Cc:     linux-mips@linux-mips.org,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org
Subject: Re: [RFC 1/4] WIP: MIPS: ath79: make ar933x clks more
 devicetree-friendly
Message-Id: <20160121031215.250b826347fd9c179b031288@gmail.com>
In-Reply-To: <20160118205725.0a16be8e@tock>
References: <1453074987-3356-1-git-send-email-antonynpavlov@gmail.com>
        <1453074987-3356-2-git-send-email-antonynpavlov@gmail.com>
        <20160118205725.0a16be8e@tock>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Mon, 18 Jan 2016 20:57:25 +0100
Alban <albeu@free.fr> wrote:

> On Mon, 18 Jan 2016 02:56:24 +0300
> Antony Pavlov <antonynpavlov@gmail.com> wrote:
> 
> > At the moment ar933x of-enabled drivers use use clock names
> > (e.g. "uart" or "ahb") to get clk descriptor.
> > On the other hand
> > Documentation/devicetree/bindings/clock/clock-bindings.txt states
> > that the 'clocks' property is required for passing clk to clock
> > consumers.
> 
> This patch is not need, you should set the clock-names property in
> the relevant device nodes instead.

This patch is needed for AR9331!

In ar933x_clocks_init() we have

        ath79_add_sys_clkdev("ref", ref_rate);
        clks[0] = ath79_add_sys_clkdev("cpu", cpu_rate);
        clks[1] = ath79_add_sys_clkdev("ddr", ddr_rate);
        clks[2] = ath79_add_sys_clkdev("ahb", ahb_rate);

        clk_add_alias("wdt", NULL, "ahb", NULL);
        clk_add_alias("uart", NULL, "ref", NULL);

"uart" is an alias for "ref". But "ref" is not visible via device tree!

I see this error message on ar933x-uart start:
 
     ERROR: could not get clock /ahb/apb/uart@18020000:uart(0)

 
-- 
Best regards,
  Antony Pavlov
