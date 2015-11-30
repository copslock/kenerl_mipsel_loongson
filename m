Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 13:11:34 +0100 (CET)
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35851 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007917AbbK3MLbvm6UP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 13:11:31 +0100
Received: by oiww189 with SMTP id w189so93494318oiw.3
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 04:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=az/jUj7VOqI1+koWde3DYGQ4n7swqjQ+/C9XLP9bocs=;
        b=b5F8Vbo2yYJoVh8ng7xvqTD7bkzre0KbztHlP4bs2bGnTpLjZHU9rjdKgAdI74My4a
         DpjVwrBaBPp5PC4gImEzfY348TaFXkMcRViBH+95CLg5D9LvR3useHIR6yoWT7Hn/6rL
         4jOTHrEHa5GaDgbkXYQEre4pbicjDMZmHLiFNoqNu/t+rJO1M44INUEl4RrPIQecuVfD
         tor3GMG7kCgYBm1Bja3pXNxMVXaVZ3YQQufYwSLdBYfQ17X7JYK22Wt8CQJ3pNp+0BvS
         7YpnJho08mr/SKFPeJlWzNmfHnb0rWklQI5GwZuqmUAyXMFo8ikkbqXLdoeiyelfyGzE
         tqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=az/jUj7VOqI1+koWde3DYGQ4n7swqjQ+/C9XLP9bocs=;
        b=l5VF3LK9XOJ6RnKg6pAl5RIcFdTZbsByaBlbPe48xYxDBNM07T4yGdPiyhdcbESEM0
         TVwvudCGV1fsAiL0LjEQVVL7SbZVkAhK0DZymF7rbEGYCg3j8BBqDm29BmdDAXA05xWk
         Wi1AbZcsIrCcgxI/jAx7Hi0VFsdjWvzYtGezg7aIVHm2Tb7jBzF43aHd/x5bDvE2iJrp
         KlWnKRqsdX9KZ4L1yP9w56cH8A1tpAXmSs6Yqyu2wESw7BeAw8km6iBX/NSIZuLfEFU/
         YvIzWLpr94yky/ewTLfdLJU0EDmOetXZLxBWfj2uPXUfxvUAuIp1fBzXikTQR0UnoAeq
         /Efw==
X-Gm-Message-State: ALoCoQnSdU4miVxMUwF0etUOUvV6fyphOgmPSmX5lCjbVYGsB4lmNthrFbULJIKrA7B8/OQYtoiM
MIME-Version: 1.0
X-Received: by 10.202.195.202 with SMTP id t193mr43156337oif.94.1448885485899;
 Mon, 30 Nov 2015 04:11:25 -0800 (PST)
Received: by 10.182.32.70 with HTTP; Mon, 30 Nov 2015 04:11:25 -0800 (PST)
In-Reply-To: <1448532010-30930-1-git-send-email-mschiller@tdt.de>
References: <1448532010-30930-1-git-send-email-mschiller@tdt.de>
Date:   Mon, 30 Nov 2015 13:11:25 +0100
Message-ID: <CACRpkdZbWJeg9erANW3onEYFXb7LnNkegeaWi6m2AzB37c41uw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] pinctrl/lantiq: updating devicetree binding description
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
X-archive-position: 50168
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

> This patch adds the new dedicated "lantiq,<chip>-pinctrl" compatible strings
> to the devicetree bindings Documentation, where <chip> is one of "ase",
> "danube", "xrx100", "xrx200" or "xrx300" and marks the "lantiq,pinctrl-xway",
> "lantiq,pinctrl-ase" and "lantiq,pinctrl-xr9" compatible strings as DEPRECATED.
>
> Signed-off-by: Martin Schiller <mschiller@tdt.de>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v3:
> None

Patch applied.

Yours,
Linus Walleij
