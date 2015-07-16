Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jul 2015 14:43:07 +0200 (CEST)
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35155 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010433AbbGPMnGJEY8G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Jul 2015 14:43:06 +0200
Received: by oihq81 with SMTP id q81so49305472oih.2
        for <linux-mips@linux-mips.org>; Thu, 16 Jul 2015 05:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=aNTU1f2RrNyGGz3bpurA4J4Qg42YNW4IxgnozaXHTNk=;
        b=AauumMm4qEq8wVhmZmEPHsWifHeaRJ73AdyvORZ6yKAMM58JUByP9JRuHPpgdpg9Bz
         FX3R4fJqNEr3MZEatSD7u+/N4C41Rd3q/t8QSD9xcDZvRMFkYIoyeND6LdnM0OIEkgUQ
         e+y2Hg0xswEe03PRxx6FkWoeV/xjJ4OolYcLkFcKvpKSvetWd9eVdFlDSg6R08Eq0NKE
         jv0aKXS0AeLyE7vjLrgy1MgcmYwi9zWK4ljcpkvvh+B0BWSuMqWCMCd7/RP1ylUG3VVN
         qepPBY3bRWqH4LPBb9k5vsML6vzJI84j6sbCtrEgCKuLFQnwWOVzYnKQ/Kxjiyi6hsMV
         o+gQ==
X-Gm-Message-State: ALoCoQmMvlXYOTCOcE2MnoHuZSDw9ZIH16ao9r1uI17/U3JhbEHcwqe79HD55QRBG4EjGipjNHkp
MIME-Version: 1.0
X-Received: by 10.182.230.70 with SMTP id sw6mr8544175obc.48.1437050580264;
 Thu, 16 Jul 2015 05:43:00 -0700 (PDT)
Received: by 10.182.204.41 with HTTP; Thu, 16 Jul 2015 05:43:00 -0700 (PDT)
In-Reply-To: <1435914709-15092-2-git-send-email-albeu@free.fr>
References: <1435914709-15092-1-git-send-email-albeu@free.fr>
        <1435914709-15092-2-git-send-email-albeu@free.fr>
Date:   Thu, 16 Jul 2015 14:43:00 +0200
Message-ID: <CACRpkdaQZpH=rXBxmOmYzcp88YkZYf2dCnS-UuN3zz8L2zFg5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: ath79: Remove the unused GPIO function API
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
X-archive-position: 48326
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

> To prepare moving the GPIO driver to drivers/gpio remove the
> platform specific pinmux API. As it is not used by any board,
> and such functionality should better be implemented using the
> pinmux subsystem just removing it seems to be the best option.
>
> Signed-off-by: Alban Bedel <albeu@free.fr>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
