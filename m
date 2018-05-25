Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 12:13:16 +0200 (CEST)
Received: from mail-oi0-x241.google.com ([IPv6:2607:f8b0:4003:c06::241]:45708
        "EHLO mail-oi0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990505AbeEYKNIly2Fh convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 May 2018 12:13:08 +0200
Received: by mail-oi0-x241.google.com with SMTP id b130-v6so4081556oif.12
        for <linux-mips@linux-mips.org>; Fri, 25 May 2018 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z+f2vtx1gehbLezjQ80IUZO9lABZLaxcsWmpxODoKxE=;
        b=nuB6Am9G3sqkWXnfyRs2jVCeJd7OVvRQCIqJkOWcvC+J3LnNZL8Hy+iHAsYNpLldMb
         qpuaVTuvTVjspxwHHP/42QZVeagI/awviTXsB2p0SN4FUvGEkvBpUVvTMdtIIByRqjAy
         8/MTa3jQG2Eie0IygM7XGV1kEJvWX/h3NNcmkUeLZFoq/x/Fci8S76oViRd2RjbDKIYP
         WVdTnyOjVzn2nKvdw0KLp38TAi6gzXobF/DasnYbgSHMVuS/eWm9fH3zoOglC2mGmlWf
         Y8UHBRH4aoyZJS+sT7lk0C4oF1/W/PSDhSU+KfuglS+M7aPQ9mk33ZJs/PFlJLgc1O5R
         TAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z+f2vtx1gehbLezjQ80IUZO9lABZLaxcsWmpxODoKxE=;
        b=M7J84RQ5BL2sWfOMqRzcuY3bwHnJ0ldhnu7KgDbDIB3Z2TfauATnHM5ULKJwp4yCqy
         uxBBz9zMzly85VMvxwu3KZg+ItUQrjWwKrQNXUatsii2A6wbrOTkGnU+4FwU9NcOiwPn
         5AamIu8bkgLRgi5p0uxMLH+gy+7dj4J+uFIhAobI9O/gCF1JG7em7TCmBUW+FrBeBEJ7
         H6nGxfERsKxyP/lHHiMM5sAiVBItqVtozsbQ35DudX8k6nnPVnoeFogmo2WmB/KZK4r+
         A5A846DRUXOoCaBMrDEnXSp7lDBSh6M6jLWY5AX5iFcMn6NX8BLELEY6qNtpx634mJHq
         2VSg==
X-Gm-Message-State: ALKqPwcj2qiNwaMspIRaK8j9Dz3SdYPntKOnsN1pWuxgUPeGmP1HDf5m
        XyrCBsPqwxlUKcqJ4hiYeWbxW3RU
X-Google-Smtp-Source: ADUXVKJj/pSJ5WWb0lsbPGzh66s2g2xzQjuQuo86BC77HCv/hohiKVQe6Jn5QihKaIYl3+NuSxK4yg==
X-Received: by 2002:aca:c7c4:: with SMTP id x187-v6mr939126oif.97.1527243181817;
        Fri, 25 May 2018 03:13:01 -0700 (PDT)
Received: from mail-ot0-f181.google.com (mail-ot0-f181.google.com. [74.125.82.181])
        by smtp.gmail.com with ESMTPSA id x4-v6sm17090231otx.54.2018.05.25.03.13.00
        for <linux-mips@linux-mips.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 May 2018 03:13:01 -0700 (PDT)
Received: by mail-ot0-f181.google.com with SMTP id l13-v6so5456281otk.9
        for <linux-mips@linux-mips.org>; Fri, 25 May 2018 03:13:00 -0700 (PDT)
X-Received: by 2002:a9d:2184:: with SMTP id s4-v6mr1017884otb.237.1527243180225;
 Fri, 25 May 2018 03:13:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4081:0:0:0:0:0 with HTTP; Fri, 25 May 2018 03:12:39
 -0700 (PDT)
X-Originating-IP: [193.151.80.5]
In-Reply-To: <20180524120733.GA24269@jamesdev>
References: <1523176203-18926-1-git-send-email-dev@kresin.me>
 <20180521163932.GA12779@jamesdev> <20180524120733.GA24269@jamesdev>
From:   Mathias Kresin <dev@kresin.me>
Date:   Fri, 25 May 2018 13:12:39 +0300
X-Gmail-Original-Message-ID: <CABwW5nkcBT3FmUy6A_t3E5VU3Z78eut3anPe06=yYbLeMrtg3A@mail.gmail.com>
Message-ID: <CABwW5nkcBT3FmUy6A_t3E5VU3Z78eut3anPe06=yYbLeMrtg3A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: lantiq: gphy: Drop reboot/remove reset asserts
To:     James Hogan <jhogan@kernel.org>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        hauke@hauke-m.de, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <dev@kresin.me>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dev@kresin.me
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

2018-05-24 15:07 GMT+03:00 James Hogan <jhogan@kernel.org>:
> On Mon, May 21, 2018 at 05:39:32PM +0100, James Hogan wrote:
>> On Sun, Apr 08, 2018 at 10:30:03AM +0200, Mathias Kresin wrote:
>> > While doing a global software reset, these bits are not cleared and let
>> > some bootloader fail to initialise the GPHYs. The bootloader don't
>> > expect the GPHYs in reset, as they aren't during power on.
>> >
>> > The asserts were a workaround for a wrong syscon-reboot mask. With a
>> > mask set which includes the GPHY resets, these resets aren't required
>> > any more.
>> >
>> > Fixes: 126534141b45 ("MIPS: lantiq: Add a GPHY driver which uses the RCU syscon-mfd")
>> > Cc: stable@vger.kernel.org # 4.14+
>> > Signed-off-by: Mathias Kresin <dev@kresin.me>
>>
>> Applied for 4.17. Thanks for the acks/reviews folk!
>
> drivers/soc/lantiq/gphy.c: In function ‘xway_gphy_remove’:
> drivers/soc/lantiq/gphy.c:198:6: warning: unused variable ‘ret’ [-Wunused-variable]
>   int ret;
>       ^~~
> drivers/soc/lantiq/gphy.c:196:17: warning: unused variable ‘dev’ [-Wunused-variable]
>   struct device *dev = &pdev->dev;
>                  ^~~
>
> Easily fixed, I can drop those two lines:
>
> diff --git a/drivers/soc/lantiq/gphy.c b/drivers/soc/lantiq/gphy.c
> index 8c31ae750987..feeb17cebc25 100644
> --- a/drivers/soc/lantiq/gphy.c
> +++ b/drivers/soc/lantiq/gphy.c
> @@ -193,9 +193,7 @@ static int xway_gphy_probe(struct platform_device *pdev)
>
>  static int xway_gphy_remove(struct platform_device *pdev)
>  {
> -       struct device *dev = &pdev->dev;
>         struct xway_gphy_priv *priv = platform_get_drvdata(pdev);
> -       int ret;
>
>         iowrite32be(0, priv->membase);
>
> However it does raise the question, it sounds like a fix, but was this
> patch tested and the warning just overlooked?

Yes the patch is tested. It is committed to OpenWrt on top of 4.14
since a while.

It is as simple as I didn't noticed the warnings.

Thanks a lot for fixing the warnings
Mathias
