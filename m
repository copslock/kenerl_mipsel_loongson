Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 17:39:04 +0100 (CET)
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33177 "EHLO
        mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012888AbbKYQjDRybe8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2015 17:39:03 +0100
Received: by ykdv3 with SMTP id v3so61729266ykd.0
        for <linux-mips@linux-mips.org>; Wed, 25 Nov 2015 08:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NvsSxbEoAe6+ZSkiT5LyD3zBnDP9+zhgL0WM4Xy9MRw=;
        b=KWV/fk/k5X8NkzaYI88WbPNx4YSOCOTmz6IZGlZfG/G2vZ/Ckh0/BDys1+96FvylIz
         eDDvDFyOXwinxCmXN6z0eWdQBpof8JqOPViGD9jWjPfawYfLDb1UtpTDl9ZuHZruuPLC
         xsOjUco/9c8LHruedDNQbFuy7eWWgsXpbjyY5Wlaqm5Lt6eX04C1zZ4qjbq83tLQnsXB
         XfAMRtXHWlFLu1Sll58OAQRIVTFCb2YxWXaXSYDQ4oCv4Ml8WE2p6rPCAWYGYdlAXKGz
         j0i/7BxWB3UB955SmtA+ZLicP50leoo/pDDITDTcK/QuWeQZCAtUQoVC+V7fGX5r8Xf4
         OkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=NvsSxbEoAe6+ZSkiT5LyD3zBnDP9+zhgL0WM4Xy9MRw=;
        b=OedJdbGj22MAcKFK9LgRh/wPyigPihAsMEfDyySpwtESChh7WyakSFF93CtxwOEm6J
         U5kKz/gnQqtNCdNdOr1yIjRC0VYEpcbSOEOFxEbzE1Bxyzp6x6WJh5Xqu1rfXjyj2mTR
         5IFQWenfFl8VX1rMVngRFxL7LDDJYOFbmeAlaJcdttXEuOVxlGEv2svKsemXQZKkGoj9
         pIfZtFH0t6Djmrf/1wa0QIoPJ5/PP7WVF9Lv3HEySsZA9u21KPEgHsdMxzb4Y8Op+lQT
         e+BmIHEF3Z9FQz+S85bsiu5TO3v1aPBih5ZgPvpLkjaUmJzjw6xP01QpgOGM5m02xUgH
         wALQ==
X-Gm-Message-State: ALoCoQkcBWqGEgERGS8wJlowcmkfRd+P2or238K4e7rKgBzOeLOhOUDxTnNA1Gs2bf6agc9jpT6S
MIME-Version: 1.0
X-Received: by 10.13.210.66 with SMTP id u63mr33596376ywd.206.1448469537501;
 Wed, 25 Nov 2015 08:38:57 -0800 (PST)
Received: by 10.13.238.195 with HTTP; Wed, 25 Nov 2015 08:38:57 -0800 (PST)
In-Reply-To: <CAPDyKFrFZgi3bQYZgrB0OVq4i3__Vor129F7abGYJ+rrPmP6EQ@mail.gmail.com>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
        <1448065205-15762-12-git-send-email-joshua.henderson@microchip.com>
        <CAPDyKFrFZgi3bQYZgrB0OVq4i3__Vor129F7abGYJ+rrPmP6EQ@mail.gmail.com>
Date:   Wed, 25 Nov 2015 17:38:57 +0100
Message-ID: <CAPDyKFph3vDzDJCxZFZYGN2BsBcqSqhvsug5F_JUdEryNa9udw@mail.gmail.com>
Subject: Re: [PATCH 11/14] mmc: sdhci-pic32: Add PIC32 SDHC host controller driver
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Jean Delvare <jdelvare@suse.de>,
        Corneliu Doban <cdoban@broadcom.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Luis de Bethencourt <luisbg@osg.samsung.com>,
        Weijun Yang <Weijun.Yang@csr.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Scott Branden <sbranden@broadcom.com>,
        Vincent Yang <vincent.yang.fujitsu@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        "ludovic.desroches@atmel.com" <ludovic.desroches@atmel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        yangbo lu <yangbo.lu@freescale.com>,
        Kevin Hao <haokexin@gmail.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Andy Green <andy.green@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulf.hansson@linaro.org
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

[...]

>> +sdhci_pic32_probe_dts(struct platform_device *pdev,
>> +                     struct pic32_sdhci_pdata *boarddata)
>> +{
>> +       struct device_node *np = pdev->dev.of_node;
>> +
>> +       if (!np)
>> +               return -ENODEV;
>> +
>> +       if (of_find_property(np, "no-1-8-v", NULL))
>
> Please don't use this property as it's broken. It has two different
> purposes and those are conflicting as discussed here[1].

Realized that I forgot to attach the reference to the discussion, here it is.

[1]
http://comments.gmane.org/gmane.linux.kernel.mmc/32751

>
> You have two options, either invent a new binding which provides
> information about which signal voltage that *is* supported, or use the
> current existing common MMC dt bindings to override the SDHCI
> capabilities register.
>

[...]

Kind regards
Uffe
