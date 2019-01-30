Return-Path: <SRS0=qUQg=QG=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470C7C4151A
	for <linux-mips@archiver.kernel.org>; Wed, 30 Jan 2019 09:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184E021874
	for <linux-mips@archiver.kernel.org>; Wed, 30 Jan 2019 09:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SPqa7QQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfA3JaR (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:30:17 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41269 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfA3JaR (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 30 Jan 2019 04:30:17 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15-v6so20069824ljc.8
        for <linux-mips@vger.kernel.org>; Wed, 30 Jan 2019 01:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aYTNODS+SExLCzBWxNqtKae9gWk4/P8WpLgQQjinLvQ=;
        b=SPqa7QQRafsp8Wa3PQ2G3cPCkhbH2aJ/3H+HhbSRePIXlZgBDHmcfGhxpeTY8Wzsrm
         JOkqw/fDdN/EwiszgzSAoxVGqYbKqFf6NPM0EXVyC3f8I4JBioFlmOV5CnuHdoTDsRio
         MbQtmcAwDlG7sGNilXBdZdjiIhhlshbZmb94M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aYTNODS+SExLCzBWxNqtKae9gWk4/P8WpLgQQjinLvQ=;
        b=HrBWRbFzpMYfa/kNjjhoenxzSJ5uua4KIJxvQIuwq6fx5KWixLwIBK9WDF7Y+IupL4
         Y7DafmacLPO9xn98/H4HYdK33PwJkOfOnk71xZv5HnIRzqudZuVjai4J+EI/q+UVwHkl
         zq75g0GlkdGAVMBkpjEQRbg4LWx1fdQTilVKYGrPogCr7S2xaBlDmzrX61t5Qo1aV93F
         tx3pTQLaylI4QhOf3ivY8NoWjiIdqTa8JIHFcAfgjOk+vfSgczWzZXWSVV0BQZ+05+P5
         E9OaN0zXXxG2HQjsdauFT/RnlJM+4GZme/kGDDHl+YvZ/6K0AYMYLpjeTROsXI4M0Qhd
         Db8g==
X-Gm-Message-State: AJcUukcZ1zc5RjUejnFDVxD7UZTonZBfrfIUCDMZLYve/+1/nZw4Xi/i
        wMQQGPKEsGUffzYEABSrhceJlZjsa4Wy/OIQIASb+1Aq
X-Google-Smtp-Source: ALg8bN4qP+N1rJBTWoMbcuXJmJDOU4FQrncPwvitjBpwNkNt36N5QxQZAOaOgHtbY553EGlgXsY/GLAlFU/dFJtnvpQ=
X-Received: by 2002:a2e:9356:: with SMTP id m22-v6mr23590611ljh.135.1548840615446;
 Wed, 30 Jan 2019 01:30:15 -0800 (PST)
MIME-Version: 1.0
References: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com>
 <1548688799-129840-1-git-send-email-zhouyanjie@zoho.com> <1548688799-129840-3-git-send-email-zhouyanjie@zoho.com>
In-Reply-To: <1548688799-129840-3-git-send-email-zhouyanjie@zoho.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Jan 2019 10:30:04 +0100
Message-ID: <CACRpkdZ08riGsySXzKsPgRxdTJL0UPLYSd95y54AP6KeUchR1A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Pinctrl: Ingenic: Add missing parts for JZ4770 and JZ4780.
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
> Add mmc2 for JZ4770 and JZ4780:
> According to the datasheet, both JZ4770 and JZ4780 have mmc2. But this
> part of the original code is missing. It is worth noting that JZ4770's
> mmc2 supports 8bit mode while JZ4780's does not, so we added the
> corresponding code for both models.
>
> Add nemc-wait for JZ4770 and JZ4780:
> Both JZ4770 and JZ4780 have a nemc-wait pin. But this part of the
> original code is missing.
>
> Add mac for JZ4770:
> JZ4770 have a mac. But this part of the original code is missing.
>
> Signed-off-by: Zhou Yanjie <zhouyanjie@cduestc.edu.cn>

Patch applied with Paul's ACK!

Yours,
Linus Walleij
