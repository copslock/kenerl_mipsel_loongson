Return-Path: <SRS0=qUQg=QG=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7FEC282D7
	for <linux-mips@archiver.kernel.org>; Wed, 30 Jan 2019 09:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9862085B
	for <linux-mips@archiver.kernel.org>; Wed, 30 Jan 2019 09:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZCQ3Ikc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfA3J2w (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:28:52 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45288 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfA3J2v (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 30 Jan 2019 04:28:51 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so16829433lfa.12
        for <linux-mips@vger.kernel.org>; Wed, 30 Jan 2019 01:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bAHyGO+lnhPxkCWAbECpUO67RxYdWDgKVewRjoakAYI=;
        b=ZCQ3Ikc1sERKhKD0GzADeHcKGVAVT0dPyXCqsanEEOUlJs1mPB1VLvMYf8n8zeTfjs
         KH1P3BbLc8cNONeCuIRrU2fv9fXi4sA6MHz08PBQ6586JjCxX36q10l6+PCZne4CA8n5
         sWby4c2ZX05lGtnaa18wkrtchGw0xRmtfUg2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAHyGO+lnhPxkCWAbECpUO67RxYdWDgKVewRjoakAYI=;
        b=EOKajnUtDCTcF1jssVl9JT+OHX5RlVsWWxSyXEylJetWMfFY61GU+b0n09DQf1/rPa
         ZvHXq3nOlSSVq0vQYn6ERhpvEyBzZ2dKTpOpHNkiG9H4vBk6/CcglBiSP0J7DewW3w0z
         BSwbEbSbI2V7qMWBNN+lPadRa4TqIqYQFHUJ4IP8VKSR8h7Ukf3mB70jUo6RN8meIpFB
         sPovqPvEk5FVQsvK4iNKxfbAsjTGOwLKCikCqi1cR7fFofY1cjqK7DcpFmtlHMNPxDmy
         BA4ZSwpf9FT6hgyqjrY1boxWWSEN8ZrvK7ybkqGByj10MmUTUbWL5L0lEpU6IFktqJ8r
         3hiQ==
X-Gm-Message-State: AJcUukeZDCWrd+AtJ2Cjc1SroCbTTQJmyH48UO4SC1f+0mzaNoMpNcrH
        +7jS+brNBcly6W4StldHhezZCMxWByMj0eBZ7sPz5g==
X-Google-Smtp-Source: ALg8bN466+fXTSbL5WwKHV6aeDxmersWbdmvjuobfmSxhx4W8Xo5kVP8PDTZ0banaCj/fyanfGIArUo0W0lEo26RlRo=
X-Received: by 2002:ac2:53b1:: with SMTP id j17mr22324090lfh.167.1548840529706;
 Wed, 30 Jan 2019 01:28:49 -0800 (PST)
MIME-Version: 1.0
References: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com>
 <1548688799-129840-1-git-send-email-zhouyanjie@zoho.com> <1548688799-129840-2-git-send-email-zhouyanjie@zoho.com>
In-Reply-To: <1548688799-129840-2-git-send-email-zhouyanjie@zoho.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Jan 2019 10:28:38 +0100
Message-ID: <CACRpkdZHxB=iTZQvdjG7npLtEXz1x9iZfiPOpHMWXTJup3ubxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Pinctrl: Ingenic: Fix bugs caused by differences
 between JZ4770 and JZ4780.
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Paul Cercueil <paul@crapouillou.net>, syq@debian.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, 772753199@qq.com,
        Zhou Yanjie <zhouyanjie@cduestc.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon, Jan 28, 2019 at 4:28 PM Zhou Yanjie <zhouyanjie@zoho.com> wrote:

> From: Zhou Yanjie <zhouyanjie@cduestc.edu.cn>
>
> Delete uart4 and i2c3/4 from JZ4770:
> According to the datasheet, only JZ4780 have uart4 and i2c3/4. So we
> remove it from the JZ4770 code and add a section corresponding the JZ4780.
>
> Fix bugs in i2c0/1:
> The pin number was wrong in the original code.
>
> Fix bugs in uart2:
> JZ4770 and JZ4780 have different uart2 pins. So the original section JZ4770
> has been modified and the corresponding section of JZ4780 has been added.
>
> Fix bugs in mmc0:
> JZ4770 and JZ4780 assigned different pins to mmc0's 4~7 data lines. So the
> original section JZ4770 has been modified and the corresponding section of
> JZ4780 has been added.
>
> Fix bugs in mmc1:
> JZ4770's mmc1 has 8bit mode, while JZ4780 doesn't. So the original
> section JZ4770 has been modified and the corresponding section of
> JZ4780 has been added.
>
> Fix bugs in nemc:
> JZ4770's nemc has 16bit mode, while JZ4780 doesn't. So the original section
> JZ4770 has been modified and the corresponding section of JZ4780 has been
> added. And add missing cs2~5 groups for JZ4770 and JZ4780.
>
> Fix bugs in cim:
> JZ4770's cim has 12bit mode, while JZ4780 doesn't. So the original
> section JZ4770 has been modified and the corresponding section of
> JZ4780 has been added.
>
> Fix bugs in lcd:
> Both JZ4770 and JZ4780 lcd should be 24bit instead of 32bit.
>
> Signed-off-by: Zhou Yanjie <zhouyanjie@cduestc.edu.cn>

Patch applied for v5.1 with Paul's review tag.

Yours,
Linus Walleij
