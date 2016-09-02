Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 14:57:34 +0200 (CEST)
Received: from mail-yw0-f170.google.com ([209.85.161.170]:34932 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990522AbcIBM5Xzl-4Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 14:57:23 +0200
Received: by mail-yw0-f170.google.com with SMTP id j12so69029354ywb.2;
        Fri, 02 Sep 2016 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hc3z/gaLZcTSKbeHC0zcJ1wqaJXFczrebEeOeHNkwGA=;
        b=TpcIdwaLsT6NlUHkosQ9r+0ecsaaP6gAuAjVhpKBOeX/JdtK3TOjNdszBYTBM0dU0A
         s18+nNcyWodWgnwVpDfXB+XuuRLmKD1Z4uLszZUY8086P5Atnw/Yylbvss3/4XSBZv3U
         0WYA0OBa8b177ZzS1bCraAsnu8w7o/LjrCcnf8mhDs+kexyBdI8aBP6irQx/uNnCUU02
         jGQ5/TB/y9kYNRzsurTbEMOXk61eVzngZy05fwpGod7K9BPYd8drxiNbriZVKdc6sCYh
         Yc49N/WTkk3aLyTv3nRSWsNwXK8yurXKmYxUaO2CBIwGS692/eNQjqLmFKq59YBizBj1
         Na8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hc3z/gaLZcTSKbeHC0zcJ1wqaJXFczrebEeOeHNkwGA=;
        b=jE0F7LsgYlMY7kiGMurY6z3P1vRiO/UDBxmS1gaUU1FHR1ejMpc3ARIWXEYilBLfOy
         4UOr9WK2rzRNPAoNBnezPsve3uF1hTRKsN5Lxs2mny2JyTbIkLwjG84uyxvJRXsNciu4
         lldF2WGRGy33fOOvjrUXLFlCINN34i8qguUcR4kCffn+Xw+LpoWReN/4etXdiU56yTdQ
         wsPep01geC7Gh6cG8+o6axzs8AOfu+///sZJhP75dsjmGoIP0vXjlc/Z5oxyYpaNNbLk
         BO2JmTq73jcd1uzHicvKpQd8Y1n87gkqwsMQk9o3Nh2r7nn7zNZxZ5wX6Etnc4dUxi62
         dk5g==
X-Gm-Message-State: AE9vXwNRrSshDC1G4xJZnATJxVeipO7d8zk994+Ndo4D62bgUORirAfmVRivgvQAmgVcVe3e+IdAHsZ/i36DCQ==
X-Received: by 10.13.231.199 with SMTP id q190mr19391866ywe.26.1472821038119;
 Fri, 02 Sep 2016 05:57:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.36.213 with HTTP; Fri, 2 Sep 2016 05:57:17 -0700 (PDT)
In-Reply-To: <4a7fb1cb-e0d4-31b7-7016-35adb63a659d@imgtec.com>
References: <1472321697-3094-1-git-send-email-prasannatsmkumar@gmail.com>
 <1472321697-3094-4-git-send-email-prasannatsmkumar@gmail.com> <4a7fb1cb-e0d4-31b7-7016-35adb63a659d@imgtec.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Fri, 2 Sep 2016 18:27:17 +0530
Message-ID: <CANc+2y5qm6zdfG5dvway=+80aqkkarSGjfXt+Lq__CiCOTw+Nw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] hw_random: jz4780-rng: Add RNG node to jz4780.dtsi
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     mpm@selenic.com, Herbert Xu <herbert@gondor.apana.org.au>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        boris.brezillon@free-electrons.com, harvey.hunt@imgtec.com,
        prarit@redhat.com, Florian Fainelli <f.fainelli@gmail.com>,
        joshua.henderson@microchip.com, narmstrong@baylibre.com,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

> I don't like this change. The RNG registers are documented as a part of
> the same hardware block as the clock & power stuff which the CGU driver
> handles, and indeed in the M200 SoC there is a power-related register
> after the RNG registers. So shortening the range covered by the CGU
> driver is not the right way to go.

Could not find M200 SoC PM in ingenic's website or ftp. So did not notice this.

> Perhaps you could instead have the CGU driver make use of the syscon
> infrastructure to expose a regmap which your RNG driver could pick up & use?

I will see how to use syscon and provide an updated patch.
