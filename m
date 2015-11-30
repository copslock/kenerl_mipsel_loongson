Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 13:13:36 +0100 (CET)
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34550 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006865AbbK3MNbBPnWP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 13:13:31 +0100
Received: by oies6 with SMTP id s6so94595915oie.1
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 04:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9yhKz5wpcd98/imLCGiA3nNJn7xD1/pQXhOngDSlShQ=;
        b=oeYcwet8iE3HTpiBE9BP6S50PoDTtq5S3EludJ6Obcz+LliULcQoMfXuMkrU/Is4Jo
         baJNmqbkuNyM4shvtP0tlgA7P2XwjCivCVCc7bjSGj+urzQt0D2BNXVDM/G9JE+ljbh4
         tytku0rwH4FFrHxQj/fG0hDVlSlZK6omX4lPNtc+d3iAtzx40l0tPRq94MTa6aEH+8a4
         5l2sf4hvdek/gu0oJjhwc5LY5D8zXFozbgrNtJs55tiO9HViWkdQ1JuTpWg6Ya7vJZ01
         ldofqh6Y4Ww6cUdNekWk48hZpqDiqpdKL0uig+byzLtg5f6+NdyDXIB2Ov8WBFKOMuDy
         jeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=9yhKz5wpcd98/imLCGiA3nNJn7xD1/pQXhOngDSlShQ=;
        b=J9GgO4YUzMwOkxL9HN3WqLIMAWQ/ctzMbF0WnOxQ0XDwuKK3qFh4F048n1mPU992I8
         t/tmcx891QBGcIdKVlWRwTmdfCHXFaBCabTK8L9opNodzoG/b2bn2r0UJtAOVuUbGYSV
         3sYw4HNybdYqfj7FFgg8ZUhuV3WEpfQudouBXYrJiBi4MtyMjBTdJ7xnR5i6dUxiP6Ek
         W4AtW73xGn3YjEgsf/zyyNsUFs36QMDcVkBhiroRAUjmHvFlsVCSgV7djffU79bo8yHV
         h66imbWhbndUT42ko25ahah+WJL9miuxgTBGqKMB85UbKsPBjyfL2HwzilmvFwoJwDoW
         IbVw==
X-Gm-Message-State: ALoCoQmBA4Q5+5pMZyKpZLYVaNfoX+RcSSYkB+ofG777VOjz9kbM+RJyhdk+/5rmdkPO6nwcD8k2
MIME-Version: 1.0
X-Received: by 10.202.51.138 with SMTP id z132mr6538320oiz.39.1448885605136;
 Mon, 30 Nov 2015 04:13:25 -0800 (PST)
Received: by 10.182.32.70 with HTTP; Mon, 30 Nov 2015 04:13:25 -0800 (PST)
In-Reply-To: <1448532010-30930-2-git-send-email-mschiller@tdt.de>
References: <1448532010-30930-1-git-send-email-mschiller@tdt.de>
        <1448532010-30930-2-git-send-email-mschiller@tdt.de>
Date:   Mon, 30 Nov 2015 13:13:25 +0100
Message-ID: <CACRpkdakqKcujE5ZAyCOqiChZjdCMLNP=MESvG4UbUZgyHLeBw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] pinctrl/lantiq: introduce new dedicated devicetree bindings
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Martin Schiller <mschiller@tdt.de>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jonas Gorski <jogo@openwrt.org>, daniel.schwierzeck@gmail.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50169
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

On Thu, Nov 26, 2015 at 11:00 AM, Martin Schiller <mschiller@tdt.de> wrote:

> This patch introduces new dedicated "lantiq,<chip>-pinctrl" devicetree
> bindings, where <chip> is one of "ase", "danube", "xrx100", "xrx200" or
> "xrx300" and marks the "lantiq,pinctrl-xway", "lantiq,pinctrl-ase" and
> "lantiq,pinctrl-xr9" bindings as DEPRECATED.
>
> Based on the newest Lantiq Hardware Description it turend out, that there are
> some differences in the GPIO alternative functions of the Danube, xRX100 and
> xRX200 families, which makes it impossible to use only one xway_mfp table.
>
> This patch also adds support for the xRX300 family.
>
> Signed-off-by: Martin Schiller <mschiller@tdt.de>
> ---
> Changes in v3:
> None

Patch applied.

Yours,
Linus Walleij
