Return-Path: <SRS0=qAeu=OX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C96C43444
	for <linux-mips@archiver.kernel.org>; Fri, 14 Dec 2018 14:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA6820656
	for <linux-mips@archiver.kernel.org>; Fri, 14 Dec 2018 14:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BxbYWoKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbeLNO4y (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:56:54 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34966 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730264AbeLNO4y (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 14 Dec 2018 09:56:54 -0500
Received: by mail-lf1-f65.google.com with SMTP id e26so4472721lfc.2
        for <linux-mips@vger.kernel.org>; Fri, 14 Dec 2018 06:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f7qHdv4d+TSPqVBsntahUoP51/tk6CvuxKnleedRPlg=;
        b=BxbYWoKwfEgxYks4R5O7lU7FvNf7zt8Zjh3eJWA5t70HuXnsV5mBJEAExAx+zsrVqz
         IOaunLc1jU0V+O2LSs8ekmdfltkRIAgtcbjr8JUu1Bp97t1hF6Eq0OqLP136GvC5Epav
         IKdxBAF2odHcXc7KRymB2BE5i2Ufh/nin1EuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f7qHdv4d+TSPqVBsntahUoP51/tk6CvuxKnleedRPlg=;
        b=N4hRl/GQ/YOxc5PMM3XaHVUkhLYuR4B38aADX6ROfIRZINIMCokiFPQmDv1Q2iBZ16
         3AJtFh4nZfVNWwD9k0bIC6CrpWL2UdxNlqVCNiLQjIufs2pLa4NlW/y31C2meTT6gU7Y
         TfoBGUA3yt7xx4kAJoJKpnGz7GBdPCW9FFoFYNHDS6vFqEo+RVDRBHFEfRLxqLNXVNyn
         vRoby1lGjN8EWDiV0faXB82BgQiyewyUgO42pdH/OIKGIkrwkRw2S+ma+aEGj+wIo/vd
         SjHNklfNJuAeENn7gFB7eD+j2cBVqF6SPQHQCiBGnJb5oC5GH9tVCYbOmTmevEdczB+f
         n0NQ==
X-Gm-Message-State: AA+aEWYWvz0ZZifvFOSY9h5qDqnM4CLiqwMgV8upDIIVgGOqGWV1m+Kx
        XOBLUpOh5f1pdmzmxsMf8rHLBLRPfbzyizB74j0/dQ==
X-Google-Smtp-Source: AFSGD/U0kDZwRiK6+GFjOlhZAXTsRddSHE6PgC9Tw7aCth5If+HZHvrVIztNuN74AKxXk1nijt0jg+3rejVKDplpCCQ=
X-Received: by 2002:a19:f813:: with SMTP id a19mr1949724lff.67.1544799411698;
 Fri, 14 Dec 2018 06:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20181212220922.18759-1-paul@crapouillou.net> <20181212220922.18759-16-paul@crapouillou.net>
 <20181213092409.ml4wpnzow2nnszkd@pengutronix.de> <1544709795.18952.1@crapouillou.net>
 <20181213204219.onem3q6dcmakusl2@pengutronix.de> <CACRpkdbABtDgwKai=8Pfji7qVb-XHsX8pDsuDdS5hhg7qEN0Bw@mail.gmail.com>
 <20181214142628.zwi4hadrju53z6f3@pengutronix.de>
In-Reply-To: <20181214142628.zwi4hadrju53z6f3@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Dec 2018 15:56:39 +0100
Message-ID: <CACRpkdYo0RrQTnjQhxG=CRa1AWoRrVjL9naYC_ZCz2_dzAz-Jg@mail.gmail.com>
Subject: Re: [PATCH v8 15/26] pwm: jz4740: Add support for the JZ4725B
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Malaterre <malat@debian.org>, ezequiel@collabora.co.uk,
        prasannatsmkumar@gmail.com, linux-pwm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>, od@zcrc.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, Dec 14, 2018 at 3:26 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Fri, Dec 14, 2018 at 02:50:20PM +0100, Linus Walleij wrote:

> > So if the PWM case is something similar, then by all means add
> > num-pwms.
>
> .. or "npwms" to use the same nomenclature as the gpio binding?

Either works for me, I don't have a very high need of consistency
but there are others that have so your suggestion seems wise.

Yours,
Linus Walleij
