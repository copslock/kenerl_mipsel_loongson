Return-Path: <SRS0=5ps2=ZU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097D2C432C0
	for <linux-mips@archiver.kernel.org>; Thu, 28 Nov 2019 09:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C302221789
	for <linux-mips@archiver.kernel.org>; Thu, 28 Nov 2019 09:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xVzjp37o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfK1JUN (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:20:13 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33512 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfK1JUN (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 28 Nov 2019 04:20:13 -0500
Received: by mail-lj1-f193.google.com with SMTP id t5so27708671ljk.0
        for <linux-mips@vger.kernel.org>; Thu, 28 Nov 2019 01:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKR+fGqhagGvX2eqNQLxdhFJr4K9V1rTJpQxJ6x3WKk=;
        b=xVzjp37ouQN75mH6Dt3mGkMwNKrRX6u+HpSWcYWq2CKwOIVa4TeQWRlVLMbh5GYNWS
         rUaE3h/xK5KaEsNpV8oKQKfEA7tB9HaWB59KyDjgjsDWhiAIpLrkHa+IVaUnHmNXtKMI
         JcgvsN6kBKLnN/fbkdSSqvrCGbbl7IENhcYoXSr+B67mJTdgn/uGRaCbqwn57whuajhx
         igP/yRCKxskbgKUkTlTi7gxS2EFkBG6Y3d8IATowKofWe+r9nttIBFOZL+KEJfaiu8lq
         L0Y7uuR0GIisTqKWLlcsxv+hOAZqCm8PNQc8ldrfVKyLEkiwuKFkg0mCa+NdeqeZiz2w
         sq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKR+fGqhagGvX2eqNQLxdhFJr4K9V1rTJpQxJ6x3WKk=;
        b=AsXKAs9XDCnvRo1V694aK7JgvhvHXU1qeIGVzWxE9dwSxxNj2qGx0JmykvpjmvFx9e
         i7xVufuBZyA7/AgyzwpwRtokoOBx8vB5G7MLXLzd/kD9pcgfHd540ETRaggXz3k1tP1M
         0pperMj94+rLSs03X09sxcd4AXVSujUKHoHgClKXpq+Rv9GU+RtaUkVglxkk/TxaurfA
         8qoulvXnX24omuza02HEfloUrUEKnuP5r+BbkDC0j3Ga7pvaU/bOlOQsyHy0a5vCPRH1
         WvdnRvUjsu0jZXQ3nNrTowZESarl2SS5D0+C4dCbGKEWDA1/m4bcVQhCY/DzW5wFDL5i
         WOdg==
X-Gm-Message-State: APjAAAWTm1HEBuEt+2Szl21Z/4qBNS31TuzvdfGYhIWrpCLeTFy84s1Q
        UjDW6eDKjwphI2KTq7Ie+oGBdmNs6EMj8dOI7bIgAQ==
X-Google-Smtp-Source: APXvYqxZngPrEEmUgnY2zxc0OBJBb0pB01VZiWH9/1Zz0lACCnn4dlER3/eAp847pj8LENQxBB3sJsaZ+TqR8fP3EoM=
X-Received: by 2002:a2e:161b:: with SMTP id w27mr33968538ljd.183.1574932811602;
 Thu, 28 Nov 2019 01:20:11 -0800 (PST)
MIME-Version: 1.0
References: <1574533806-112333-1-git-send-email-zhouyanjie@zoho.com>
In-Reply-To: <1574533806-112333-1-git-send-email-zhouyanjie@zoho.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Nov 2019 10:20:00 +0100
Message-ID: <CACRpkdYZfwXTfdiVtZgbTy9U7VxCE471N2ysWF7Vo7Fasn0Uxw@mail.gmail.com>
Subject: Re: Fix bugs in X1000/X1500 and add X1830 pinctrl driver v4.
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Paul Burton <paulburton@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Sat, Nov 23, 2019 at 7:30 PM Zhou Yanjie <zhouyanjie@zoho.com> wrote:

> v3->v4:
> 1.Use local variables to streamline code.
> 2.Prevents processors older than X1830 from being
>   configured in HiZ mode.

I see the buildrobot is complaining about patch 4.

Please wait for v5.5-rc1 and rebase on that and resend
after the merge window.

Yours,
Linus Walleij
