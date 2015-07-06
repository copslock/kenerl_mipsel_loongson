Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 12:36:46 +0200 (CEST)
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36706 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010117AbbGFKgnPvr5e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 12:36:43 +0200
Received: by oiaf66 with SMTP id f66so82883464oia.3
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 03:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oEreES7K2rcN4rykfE78+tquvIIEQ60dXJqwKshG8M4=;
        b=lFqiHp9hw6hAILXeLpTEzDfmAtg518wVCGQw+aZ9PxBlRUr4xvQK90wqwdDiMPX5cv
         H4ypUlZ2xPGk8Xr7XyGCBXYTZgFfHnCdO3afvGTiXrDoSL6KS3lk7bp6hzTJcBwiOXSk
         AsIUZuxhdK4plU6nhcL+5XNPCVQbi1khv3MTK/ZPkmbAkNjIvUZcfae8mFldUe7pq/Kt
         Q3Ofjo7J9izJi2sSmaEbXsSQTdzI1Tz1rP/GpVWLNjMd98iKOyWSOa7Xdm4qJnKh2ge8
         jsUtqkIbUROWaVQNo5fX50mMxSh4s4hdyX+s5Ya0NyF2q4ysxYNJGoyktF18tWr4g5Zl
         eUaA==
X-Gm-Message-State: ALoCoQkDJDNaFuMKasIxmosQp2mnznWeIYyzt6q9TjxrTOnj1DOY9/jzYZpiCjMX+4us7Fr/GycE
MIME-Version: 1.0
X-Received: by 10.202.65.67 with SMTP id o64mr5104543oia.45.1436178997182;
 Mon, 06 Jul 2015 03:36:37 -0700 (PDT)
Received: by 10.182.204.41 with HTTP; Mon, 6 Jul 2015 03:36:37 -0700 (PDT)
In-Reply-To: <1435914709-15092-1-git-send-email-albeu@free.fr>
References: <1435914709-15092-1-git-send-email-albeu@free.fr>
Date:   Mon, 6 Jul 2015 12:36:37 +0200
Message-ID: <CACRpkdbS8mTLN0de6neJNk=+0VBNZOwhzT-18CSS8n=uwLGa1A@mail.gmail.com>
Subject: Re: [PATCH 0/2] MIPS: ath79: Move the GPIO driver to drivers/gpio
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Alban Bedel <albeu@free.fr>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48064
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

On Fri, Jul 3, 2015 at 11:11 AM, Alban Bedel <albeu@free.fr> wrote:

> as requested when I posted the ATH79 OF support serie, here is the move of
> the GPIO driver to the GPIO drivers directory. While at it I also removed
> the custom pinmux API as it not used by any board.

First:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please apply to the MIPS tree, because it is better to have all
GPIO mess collected in one place than spread out over the kernel.

Admittedly not having it in "my" folder makes me sloppy and not try to
push for modernizing the GPIO driver(s)...

This driver could use some modernization and platform cleanup though.
I'll comment on the move patch for reference, don't see it as any blocker,
more as a TODO list.

Yours,
Linus Walleij
