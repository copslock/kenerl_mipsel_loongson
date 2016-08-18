Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 13:53:15 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34718 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993243AbcHRLxJ3bonp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 13:53:09 +0200
Received: by mail-wm0-f67.google.com with SMTP id q128so5285485wma.1;
        Thu, 18 Aug 2016 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AM+i8oo+lmmduyjfJ5e32IHmjZSMoFJLHpQZyB8BMuI=;
        b=Pb4xOMeACltZMunLKaDEuVNg0iAm/IbZIhD1RAkE3ngkE+tfSQ0NM1ce7s22t9NlUS
         5u84PG0holFAcfD7AsVgPXDBG4tEXwIvKcVlHmdJnugJJ+QzkQqtcezHZ18esBn6+5Qh
         kdxNu3DOCXIawcHHOld+deHWcCGu2l28/IXD7B+4bwma1RjjrkdQUA27TS9NkZhQvvAq
         XOPvMPZ0OfNK4WiuyOkVaMGiH7kIzXELdoteU3+XuEd2EjqGn5E04jBHi4RsJk9tJX2h
         Uwt8T0J+wcU88w1qe8xqS5QNeTxN/xuspisI5sjkuyLngUlwNyxPTSNmHGR2MAT523hd
         dApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AM+i8oo+lmmduyjfJ5e32IHmjZSMoFJLHpQZyB8BMuI=;
        b=ZiayNbRRydoCFw7M+/mLI20M5mkyhUdDqZT4vnr0699xFwh5cpa08JrpjdU0Dgumy/
         9wsQK/mmfbvcl4klp/rqRy1QlRgsrW6BrISbd0/JM6xvFnieT507yON7zwXhhRnPTYtl
         hEqkKA2P39o5VnTzzMVV1f7PKGZ5N9MRmlKj5eos3/aQbJUKq1A1IV8TyTHdBy+TFVG2
         9nBbZvwTGX/U8N3MbMFjJNi+/9InBSctZptqLDYmYH+KEFQ9Ssp68nBhNgOYiZm9ARGS
         NhGz5qiw3/DQ6MSCfza6yYCAGjxd4EdCdv7jfLNsW7HlesD2LR1O0FdUN82j89bvqVcL
         848w==
X-Gm-Message-State: AEkoousnA4A6WqesKs8KD5yfTVjOIkIMaOL14s9Qg/q9tOhvib/UmzOXMUdihsVn5C4Qug==
X-Received: by 10.194.100.129 with SMTP id ey1mr2056424wjb.60.1471521184137;
        Thu, 18 Aug 2016 04:53:04 -0700 (PDT)
Received: from Red (ANice-651-1-11-220.w86-203.abo.wanadoo.fr. [86.203.162.220])
        by smtp.googlemail.com with ESMTPSA id v134sm31376789wmf.10.2016.08.18.04.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2016 04:53:03 -0700 (PDT)
Date:   Thu, 18 Aug 2016 13:53:00 +0200
From:   LABBE Corentin <clabbe.montjoie@gmail.com>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     mpm@selenic.com, Herbert Xu <herbert@gondor.apana.org.au>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Ralf Baechle <ralf@linux-mips.org>, davem@davemloft.net,
        geert@linux-m68k.org, Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>, mchehab@kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        boris.brezillon@free-electrons.com, harvey.hunt@imgtec.com,
        alex.smith@imgtec.com,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        kieran@ksquared.org.uk, Krzysztof Kozlowski <krzk@kernel.org>,
        joshua.henderson@microchip.com, yendapally.reddy@broadcom.com,
        narmstrong@baylibre.com, wangkefeng.wang@huawei.com,
        Christian Lamparter <chunkeey@googlemail.com>,
        =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>, pankaj.dev@st.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Add Ingenic JZ4780 hardware RNG driver
Message-ID: <20160818115300.GA6621@Red>
References: <1471448151-20850-1-git-send-email-prasannatsmkumar@gmail.com>
 <92a00062-9a87-0053-2c99-17bd1a304a4a@gmail.com>
 <CANc+2y55ZCkauwKNtuuCxLx-WOtm8z+A_EBKsYSjEUdc+ZbZTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANc+2y55ZCkauwKNtuuCxLx-WOtm8z+A_EBKsYSjEUdc+ZbZTQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <clabbe.montjoie@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clabbe.montjoie@gmail.com
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

On Thu, Aug 18, 2016 at 10:44:18AM +0530, PrasannaKumar Muralidharan wrote:
> >> +static int jz4780_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
> >> +{
> >> +     struct jz4780_rng *jz4780_rng = container_of(rng, struct jz4780_rng,
> >> +                                                     rng);
> >> +     u32 *data = buf;
> >> +     *data = jz4780_rng_readl(jz4780_rng, REG_RNG_DATA);
> >> +     return 4;
> >> +}
> >
> > If max is less than 4, its bad
> 
> Data will be 4 bytes.
> 

No, according to comment in include/linux/hw_random.h "drivers can fill up to max bytes of data"
So you cannot write more than max bytes without risking buffer overflow.

And if max > 4, hwrng client need to recall your read function.
The better example I found is tpm_get_random() in drivers/char/tpm/tpm-interface.c for handling both problem.

Regards
