Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2018 04:40:08 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:40037
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990391AbeCBDkAFGPPp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Mar 2018 04:40:00 +0100
Received: by mail-qk0-x243.google.com with SMTP id o25so10422844qkl.7
        for <linux-mips@linux-mips.org>; Thu, 01 Mar 2018 19:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8uiO0IrDbipueEzucl1qpmq6ZtMM0qLCCDoyaSD4pX0=;
        b=kySagCvpDHhbOBD16PsIbPZ7NbioIAtvroNfyeyFbnLCIl4RYfRuw1z6y0YgnxUEXG
         5tWd+pTSX26yzyknI9kpfAmXZQsq9IfKBywxagEJWI1l6R2ajIJRUCSKvvOjUqVBkBAt
         8/4YVwlsFgzNwSt5S/v++rdy2RnIChzbOgv3F6srn/a2i6au1QJAL/o24RhfMmj56Kjx
         mHtRmBthGuZ7y1KDbhv8LAuWIghvCrP84m/gfjzGMeNXjEhBxNdP3Hq+NJ3hXkaKdRIX
         BOuSNLF0AlOZ/x+yiLcrYk+rZpxB8pRMwAjrFr/3tSwq+TCXMBSoG0Yvebl0V/NHgbNl
         QpFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8uiO0IrDbipueEzucl1qpmq6ZtMM0qLCCDoyaSD4pX0=;
        b=g5JS93z3AIz6yulGc520dHlHo8PR/vOHgx5uBJPnPmG+CwrdOlX82pxLJ9blSdeGHW
         hzVlRulBd0HTdpIa9lhiaK+ZACtONQvibMXNkGB6hHZEypJn2uK1Mr+3LNHl7onS7rHk
         puTGu5i6b9vKM1Q7b9NjJXaN6RypEFPasdgCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8uiO0IrDbipueEzucl1qpmq6ZtMM0qLCCDoyaSD4pX0=;
        b=TevKWJaaq1lWYTPg9HxijwNyBtV8chP23RN0Ot7PFJaclqn6bLhthkkYc1x446HZFa
         gMx1VyhFn+O0XcLclqbQMibK+UwgdTdAJr4oDtIQgJ3b6PnJfCpmvrT9QyMwwXUTwTfV
         7I87b+zhei4OUpJPwVNtZiO6ZP1/ZGdJzMz1q9gCdLsajJphD5Ztrxmq7/MYcHhkzdKF
         XAg5FdPJPd+Dmvpq4tC5exo0uWUSs51yaf28cP+nuToBh+Oea3EFluVijSUE4sqX/CYR
         qHxAySHfFBxk6exrGIW0oF56/P1UUlF9a7e+B59fp2usYm6lU6AoJlKyTU8/YpTzXQYp
         UDIA==
X-Gm-Message-State: AElRT7H46F8x3IOt7V18JjLwWwf3Xtmwj1DzUUr7O7lXmCwyqyIJsO09
        SM5OFrxHhPSoWrKpCC5RvNHfYeidpavZqrGbXEk=
X-Google-Smtp-Source: AG47ELuKarD1dmix7SLHU9Po2SnfxCz2zVvjrV5rmLJcQleJFRDjfFUB/91QWOTzrGNKDKFY4S4OghdMcVQWozs3ODI=
X-Received: by 10.55.111.66 with SMTP id k63mr6371818qkc.25.1519961991475;
 Thu, 01 Mar 2018 19:39:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.50.69 with HTTP; Thu, 1 Mar 2018 19:39:31 -0800 (PST)
In-Reply-To: <20180228150209.2525-1-marcus.folkesson@gmail.com>
References: <20180228150209.2525-1-marcus.folkesson@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 2 Mar 2018 14:09:31 +1030
X-Google-Sender-Auth: 3aAiYr3xqTARXdQLDRGv_AFd4lE
Message-ID: <CACPK8Xd2W1559soSAfviY6AS0uMRCxYEmOrhHAof5gX6y_63Cg@mail.gmail.com>
Subject: Re: [PATCH v4] watchdog: add SPDX identifiers for watchdog subsystem
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Baruch Siach <baruch@tkos.co.il>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jimmy Vance <jimmy.vance@hpe.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        Andreas Werner <andreas.werner@men.de>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Zwane Mwaikambo <zwanem@gmail.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-mips@linux-mips.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <joel.stan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joel@jms.id.au
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

On Thu, Mar 1, 2018 at 1:31 AM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> - Add SPDX identifier
> - Remove boiler plate license text
> - If MODULE_LICENSE and boiler plate does not match, go for boiler plate
>   license
>

For this one:

>  drivers/watchdog/aspeed_wdt.c          |  5 +---

Acked-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
