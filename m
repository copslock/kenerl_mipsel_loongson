Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Feb 2016 21:16:26 +0100 (CET)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34876 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013221AbcBSUQZ0A4Z0 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Feb 2016 21:16:25 +0100
Received: by mail-pa0-f41.google.com with SMTP id ho8so57037709pac.2
        for <linux-mips@linux-mips.org>; Fri, 19 Feb 2016 12:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=content-type:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=A73IFlfsr6Tnq3MShZZeubRWnDaW8cb9gJDTgdfbiwg=;
        b=cZ3fPTQYq/EPsnplC1gInyXxGWa0XtkO9F+oN2s8lrxTTHZ27hJKWA0zfEnCt2jrdj
         SGGAjCZMZRUlk9x91phNWhfK/ElPwociDyDuyuyUFPx5XK1UZucS473XkkR1Yy6cIDZz
         cR0qVJCGzJ2nBxlBMbJATtkB9aq0cWnolHxcEddkPqUAbrFfQrzVMZvUsV/HwJsD8ZVR
         YrhlGNLTrWv2lsn/TDrp7WwK34+uQcPaEXG0FdZyD50TYJFGw8PKZ6e2HGNMT8rTHup5
         IkNjaxHNVB7KEXT1pBB02QB9EKGEL7RYWfjDPNd6KBA4R0pDcqxAShoOjxQel+DBHC3R
         beBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version
         :content-transfer-encoding:to:from:in-reply-to:cc:references
         :message-id:user-agent:subject:date;
        bh=A73IFlfsr6Tnq3MShZZeubRWnDaW8cb9gJDTgdfbiwg=;
        b=Db8z34vMRByw0I/qHdxgseN0fMLb2eGrgcMxJJvwnd0v9upq/BYxO3rPVyBfGBD+2Y
         JImWBtYCmy8PezPstccQHuXKeH2XdgGN/2uJ72wOkmMjtAKV16q1sJ4jfZ0E3KJjPU4Y
         589mujjl0VXKMgMi1QWLHW8o8BXiaHBQWZfUrC9Izh7O/PuTwY0nv/uKQ94tIVbeioQo
         2PHLXuS5qClGQIWgRMW+LhmkIkki+IVTeM9fnHcHDKeyKWHI0QOG7dUnVofZR7Yo5hw0
         iVNaWhlVVNcwTEkjHmRAlkeKn8QQEblMbtWbXqQA+a4bgOSlxKsGFUaeLX/XxmYWOsXe
         oJ4Q==
X-Gm-Message-State: AG10YOTEpjR2bICfftD/cYi9l1YS8tnXBF3YY3bTOq+trvJHZm/PXqFlVagGnx76VkLGRy+Q
X-Received: by 10.66.101.36 with SMTP id fd4mr20993681pab.76.1455912978013;
        Fri, 19 Feb 2016 12:16:18 -0800 (PST)
Received: from localhost (cpe-172-248-200-249.socal.res.rr.com. [172.248.200.249])
        by smtp.gmail.com with ESMTPSA id u84sm19637559pfa.57.2016.02.19.12.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2016 12:16:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Joshua Henderson <joshua.henderson@microchip.com>,
        linux-kernel@vger.kernel.org
From:   Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <1455899179-14097-3-git-send-email-joshua.henderson@microchip.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        "Purna Chandra Mandal" <purna.mandal@microchip.com>,
        "Joshua Henderson" <joshua.henderson@microchip.com>,
        "Stephen Boyd" <sboyd@codeaurora.org>, linux-clk@vger.kernel.org
References: <1455899179-14097-1-git-send-email-joshua.henderson@microchip.com>
 <1455899179-14097-3-git-send-email-joshua.henderson@microchip.com>
Message-ID: <20160219201615.2278.2909@quark.deferred.io>
User-Agent: alot/0.3.6
Subject: Re: [PATCH v7 2/3] clk: clk-pic32: Add PIC32 clock driver
Date:   Fri, 19 Feb 2016 12:16:15 -0800
Return-Path: <mturquette@baylibre.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mturquette@baylibre.com
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

Quoting Joshua Henderson (2016-02-19 08:25:35)
> +const struct clk_ops pic32_roclk_ops = {
> +       .enable                 = roclk_enable,
> +       .disable                = roclk_disable,
> +       .is_enabled             = roclk_is_enabled,
> +       .get_parent             = roclk_get_parent,
> +       .set_parent             = roclk_set_parent,
> +       .determine_rate         = roclk_determine_rate,
> +       .recalc_rate            = roclk_recalc_rate,
> +       .round_rate             = roclk_round_rate,
> +       .set_rate_and_parent    = roclk_set_rate_and_parent,
> +       .set_rate               = roclk_set_rate,
> +       .init                   = roclk_init,
> +};

You can remove .round_rate and only use .determine_rate.

...
> +CLK_OF_DECLARE(pic32mzda_clk, "microchip,pic32mzda-clk", pic32mzda_clock_init);

Can you make this a platform_driver instead of using CLK_OF_DECLARE? I
asked this in v6 but there was no response.

Regards,
Mike

> -- 
> 1.7.9.5
> 
