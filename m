Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Feb 2016 00:19:54 +0100 (CET)
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35963 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012774AbcBRXTw1KUby (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Feb 2016 00:19:52 +0100
Received: by mail-oi0-f52.google.com with SMTP id w5so878305oie.3
        for <linux-mips@linux-mips.org>; Thu, 18 Feb 2016 15:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZAQ9QRO+t4fhTDyFjqBcMxCVU/jq2Dk3+W0s/k+GSbU=;
        b=TJwGjY78t5thhIVdOR+t2/GG89nrwzZYw6yAxGo+HWlGWrDvc6CesM75wuj7Okjx7Z
         CNkC13XzvWX0ZESjJjruVwpinxCADrFfhLZi5GvQr0D/u5DhFEVoe0XsxhTnhWLwHLWU
         RfujsZTedUpi00gG8miwNXOKNYnmajiqX6o8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ZAQ9QRO+t4fhTDyFjqBcMxCVU/jq2Dk3+W0s/k+GSbU=;
        b=Doa//qzZR0He+0/JJ7IzOiYAFDZQ21uqg1cFV3BQKZr1nTK41Gbn5rrfq9brRPJvV+
         uIrcTR/eWK3z6Sr7Jd0Dt1YRllMcwMuR25x8KJ2oNjuvQ4pDlDxTAKV5trX+nPKv/9yb
         x8rX9LT3RP5Jt1nH57fTttdyUBdAe76qPaXg901xX1hZ+PCkqEvWSIAQP0eqNnq2KDBj
         0pjURE/AHvWCtnJ+F3yNo6G5T4G3JwzlDid2XTkPs5op+G3XfoUK6GIVibaZ/V9QR/4g
         KUDLKiity2Ie4KpSeqw0qbP+Q+/ZQjeT3kg4XGJUfnvJG2wEEqtJJyoxu8bTXEFDYa9O
         IS2g==
X-Gm-Message-State: AG10YOTFggZfNQCnRnf1lo8UKs+VChfDhy3qENHaOwwJ1scOlSPg3d7W3jY7IkR1HnNQ0IDfCoNEM/1HgDbyICzV
MIME-Version: 1.0
X-Received: by 10.202.235.3 with SMTP id j3mr8512474oih.94.1455837586871; Thu,
 18 Feb 2016 15:19:46 -0800 (PST)
Received: by 10.182.55.105 with HTTP; Thu, 18 Feb 2016 15:19:46 -0800 (PST)
In-Reply-To: <1455637261-2920972-2-git-send-email-arnd@arndb.de>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
        <1455637261-2920972-1-git-send-email-arnd@arndb.de>
        <1455637261-2920972-2-git-send-email-arnd@arndb.de>
Date:   Fri, 19 Feb 2016 00:19:46 +0100
Message-ID: <CACRpkdaNA0p95f8i4o0+Abqc-YshvaBhOBAWbi=s1AfFmeHY_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] gpio: remove broken irq_to_gpio() interface
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52124
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

On Tue, Feb 16, 2016 at 4:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> gpiolib has removed the irq_to_gpio() API several years ago,
> but the global header still provided a non-working stub.
>
> To prevent new users of this broken function from showing
> up, let's remove the stubs as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
