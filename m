Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2012 21:16:03 +0200 (CEST)
Received: from mail-we0-f177.google.com ([74.125.82.177]:41582 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903345Ab2ICTPu convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Sep 2012 21:15:50 +0200
Received: by weyr3 with SMTP id r3so3195103wey.36
        for <multiple recipients>; Mon, 03 Sep 2012 12:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9zi9DPWS4MkL+lX8mG4g1bHR3Y2ZqNFSnF3Jdunm9Lg=;
        b=YLpN5z2Rd86PDfqk658IU0RPvfjz3Pn6RM12lkVvpg1P8zyXYX488VYZvvGzFLWs5t
         YAo/ulbLm/qccqV0+oh8Eu4Q08YEk+kkKos2zWyXlf3OSctxyS3JEXVP+UT1VVU/Ovli
         qexjHIm/nS/FBIBLUpX4nybZYmdP37WridajsSDWZajEDpHUU0DGn+o8+PKN8bsyzeCJ
         Iqd/nFWaA3blgUhal9iohgWKKz6pqU+HHHw3105GRrnb8IfWnhVqXqRhrubiMMPKBxmF
         aTRWzDtm9eQm92y0SNKslbZYGm15cbAbYEJPE57D1rUtElPeF9vCmto4Zlaz0AUOukFJ
         2MCg==
MIME-Version: 1.0
Received: by 10.216.23.202 with SMTP id v52mr10089113wev.32.1346699744878;
 Mon, 03 Sep 2012 12:15:44 -0700 (PDT)
Received: by 10.216.169.136 with HTTP; Mon, 3 Sep 2012 12:15:44 -0700 (PDT)
In-Reply-To: <1346427485-12801-3-git-send-email-hauke@hauke-m.de>
References: <1346427485-12801-1-git-send-email-hauke@hauke-m.de>
        <1346427485-12801-3-git-send-email-hauke@hauke-m.de>
Date:   Mon, 3 Sep 2012 21:15:44 +0200
Message-ID: <CACna6rwb15pfbM6rM5ros0yCSW+uv1CbwWz5pUz8OgvONKKrvg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] bcma: add GPIO driver for SoCs
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, john@phrozen.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, florian@openwrt.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 34412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

2012/8/31 Hauke Mehrtens <hauke@hauke-m.de>:
> +u32 bcma_gpio_in(struct bcma_bus *bus, u32 mask)
> +{
> +       unsigned long flags;
> +       u32 res = 0;
> +
> +       spin_lock_irqsave(&bus->gpio_lock, flags);
> +       res = bcma_chipco_gpio_in(&bus->drv_cc, mask);
> +       spin_unlock_irqrestore(&bus->gpio_lock, flags);
> +
> +       return res;
> +}
> +EXPORT_SYMBOL(bcma_gpio_in);


Could we put here direct ops on ChipCommon regs and drop GPIO
functions from driver_chipcommon.c?

-- 
Rafał
