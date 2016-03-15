Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Mar 2016 09:58:47 +0100 (CET)
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34160 "EHLO
        mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006789AbcCOI6pWONBQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Mar 2016 09:58:45 +0100
Received: by mail-ob0-f179.google.com with SMTP id ts10so10473200obc.1
        for <linux-mips@linux-mips.org>; Tue, 15 Mar 2016 01:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=dOTzPN16StE+NWLhOMI8prz3qHhOLEPwBcdOU2wOkAE=;
        b=ZWiMJh3rWIjL82hhzC6O59SSW0xOJim/EKdCYV/BjsQiTObmaNisBum9LM2vuqGuCL
         U+vbyeX3G953gJ8RSNqC1sAAu3dBA1w9ewBZQZf9TDlpg+rszFbN/au6DxIemaWLgSK+
         1Qh6hQ0XYT5NIYcCYRFMNaHhDXa4tWi5qZcXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=dOTzPN16StE+NWLhOMI8prz3qHhOLEPwBcdOU2wOkAE=;
        b=Tp9hDUz9LF/vFEGP/NJ5ctMPryogKz8D2faMe8xzbJzTLeDxL8ffCPlJFZj1rFUbDi
         4b28sqmfo1zZeBZ+zS0g3KtTWX7FiqvyXUhrKMEb+2avMKkC+/L33w0TaO1ap50kXgXB
         p9yrKvt0Q3IKfYZOC5HgpGeBMICjvZe7Md2dNKscYRWiZtimELT/HJNdLws/FEQ2GM20
         NcR+EAoXoSGR3CCcl1NfTsQ0DIjngnrzEE128o/37IExon54n5LDgORsBdG3uOKFrzIk
         wCuSnzgiFgd4H3/KEUDK/OiyJiz/BSYD8woRH5lZvqGEnaHo+8BxWumantoSBomFaS/k
         ffUg==
X-Gm-Message-State: AD7BkJIV8NqV+JBUNv5iuoLMzT3ymUlcYjwsHhXClO95MK/wn9zimJ+yjg6n9lEBu8HqOBZGMUxZFdBXtyb20H6O
MIME-Version: 1.0
X-Received: by 10.60.73.99 with SMTP id k3mr16673821oev.10.1458032318630; Tue,
 15 Mar 2016 01:58:38 -0700 (PDT)
Received: by 10.182.55.105 with HTTP; Tue, 15 Mar 2016 01:58:38 -0700 (PDT)
In-Reply-To: <1457105302-15070-1-git-send-email-Govindraj.Raja@imgtec.com>
References: <1457105302-15070-1-git-send-email-Govindraj.Raja@imgtec.com>
Date:   Tue, 15 Mar 2016 09:58:38 +0100
Message-ID: <CACRpkdaGy-X8qatpMkaDz-7sGrL9vmmrJeZCWy3UYPePrO2+gQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pistachio: fix mfio84-89 function description
 and pinmux.
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Govindraj Raja <Govindraj.Raja@imgtec.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        James Hartley <James.Hartley@imgtec.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Fri, Mar 4, 2016 at 4:28 PM, Govindraj Raja
<Govindraj.Raja@imgtec.com> wrote:

> mfio 84 to 89 are described wrongly, fix it to describe
> the right pin and add them to right pin-mux group.
>
> The correct order is:
>         pll1_lock => mips_pll   -- MFIO_83
>         pll2_lock => audio_pll  -- MFIO_84
>         pll3_lock => rpu_v_pll  -- MFIO_85
>         pll4_lock => rpu_l_pll  -- MFIO_86
>         pll5_lock => sys_pll    -- MFIO_87
>         pll6_lock => wifi_pll   -- MFIO_88
>         pll7_lock => bt_pll     -- MFIO_89
>
> Fixes: cefc03e5995e("pinctrl: Add Pistachio SoC pin control driver")
> Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Andrew Bresticker <abrestic@chromium.org>
> Cc: linux-mips@linux-mips.org
> Cc: James Hartley <James.Hartley@imgtec.com>
> Cc: <stable@vger.kernel.org> # v4.2+

Patch applied for fixes with the ACKs and all.

Yours,
Linus Walleij
