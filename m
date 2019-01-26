Return-Path: <SRS0=bwn4=QC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C782C282C7
	for <linux-mips@archiver.kernel.org>; Sat, 26 Jan 2019 12:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D144218A6
	for <linux-mips@archiver.kernel.org>; Sat, 26 Jan 2019 12:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAoNpvNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfAZMKz (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 26 Jan 2019 07:10:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43345 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfAZMKv (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 26 Jan 2019 07:10:51 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so10511207lji.10
        for <linux-mips@vger.kernel.org>; Sat, 26 Jan 2019 04:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWt+a+DApXXFI1Z66adeohhEeOQI8/QFCZ31i+hC8ps=;
        b=DAoNpvNAai+Ul+1SZPMK2Lk3EP1oyCKUSQO1SHw9BI/MpPXGr1Nm9fpU/laydHmkse
         2wzg3f0nY97yJtqrX1nuyPx0w9RvKpe4+rkEjUyy5zvxYkhxagXLmx/niVnYSCTX8+hl
         BP2lxQZFjeqqK8v4bb+08anBWYk9TkChT+PSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWt+a+DApXXFI1Z66adeohhEeOQI8/QFCZ31i+hC8ps=;
        b=eAkW9gyLYDQpwBARR53FTLGuZZ+h7KrNv0zxcKObHiZC79ERJ61KJyxetf1Jcbq6E9
         2SujrErzMFQiCBCOvQtnTi8ZisrUi2Hwj6jWREhFeFtJ4iJpIr5B+K/rSHJiHSpXYJW/
         05hG5JpvAhy2WnqzPlScnBCb1o6OakB2V1ad77FqAupthLSWibOLKoAoRCmEaCdaJAgt
         Ax6eih/0TGjDbn2FfV3e1upBDQWDZHxZiUgBBjui8fQcD+BH6UsXIHwLpYX5NbZ0Hnti
         +zgalhpOi+5QWpCfDMUmJrl7grR7o/Dr0nTkaVymISMKqJ4z/AYt/ZKxISrxx2T1v2/P
         ICHw==
X-Gm-Message-State: AJcUukcuq7D7nd4VjWNnwUp0GQdPiq5/vcnoN3O3W63XErecS/y2+Xg5
        YZsh2klZkWBhJA4LVP+qyLJ6z4UTitJqhK6a6cVZsA==
X-Google-Smtp-Source: ALg8bN6NITiklHR3i0avIacW92OpM5c5UyspsWPojNI0W2bSlry2L4cujLNodG6FVgCOLP/zuDbx/5iCS4h6qungMrg=
X-Received: by 2002:a2e:568d:: with SMTP id k13-v6mr12588444lje.105.1548504649038;
 Sat, 26 Jan 2019 04:10:49 -0800 (PST)
MIME-Version: 1.0
References: <20190125200927.21045-1-paul@crapouillou.net>
In-Reply-To: <20190125200927.21045-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 26 Jan 2019 13:10:37 +0100
Message-ID: <CACRpkdbhgpkEJ2B2bEDpmM9WLHxUxM8SWhWw28Of5ZRcZ7okSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: jz4740: Remove platform data and use standard APIs
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-mips@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, Jan 25, 2019 at 9:09 PM Paul Cercueil <paul@crapouillou.net> wrote:

> Drop the custom code to get the 'cd' and 'wp' GPIOs. The driver now
> calls mmc_of_parse() which will init these from devicetree or
> device properties.
>
> Also drop the custom code to get the 'power' GPIO. The MMC core
> provides us with the means to power the MMC card through an external
> regulator.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Execellent patching!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

For all three patches.

Yours,
Linus Walleij
