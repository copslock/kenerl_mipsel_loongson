Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2018 22:06:13 +0100 (CET)
Received: from mail-pg1-x543.google.com ([IPv6:2607:f8b0:4864:20::543]:39200
        "EHLO mail-pg1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991783AbeKLVET1z7pE convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Nov 2018 22:04:19 +0100
Received: by mail-pg1-x543.google.com with SMTP id r9-v6so4600335pgv.6
        for <linux-mips@linux-mips.org>; Mon, 12 Nov 2018 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=41H+lAG5eJZVfIC2g3mWh9vIj8/xyUsXAyPBoAu6Ldw=;
        b=v0/tyzzn+qeUo/qOi9HTQqS/TSFr5zNe4NN9vJyob+UNqqE7pIHWD4AY4eAs2pI4xL
         zuJxtziIWCASHgnTxfp7Y8HFwSQ4JBrmit05BjYg21VVc070Gu2lFfDJfx2Uxa2HHkqm
         xeqLE3KoUoFpiAZPi9qxyvVDu6OfRKjix2tSrIj1c0A5G063y4Ms8cKfiBx72CK1/Ys2
         T/qyqcpES3puWUaDWgnh3SFDHN//gVLGVvXfgraisBzkRtil8Wucr7CbYKbjYqrHIKMW
         Tsi9Zngt71LjK8w/zbRIGJI7RfND6WRNK5Ozw0lc6GNWvEI2RCts2bQ4rfA+O6onSxGG
         MivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=41H+lAG5eJZVfIC2g3mWh9vIj8/xyUsXAyPBoAu6Ldw=;
        b=mLeIsgNe1snt/7472wvIdX9dLI+MlT4G2I0WabNqrDqsUFVq8bY7eRrWb2t4+f1qjT
         UEBb9M1TA+vOzKlcwj5TPoMQ+s8HrHuiTpkC0sw3J/oGe8RXWbTHKqcfpoWazG8HE9pw
         vy/IT3sdANsxxtZ63nsDQnFZGapNjYjepzoJYu1lfnA0wbDTqwZO3jqW9jKTKu5IpUbb
         5czrD9Qs92YQ3ZlsD6SMqQnmcXXwTO1J/GPR/XvIKo+J+79xBjsHS26ICK9KCB+XPLEe
         3dX5BraH7jk4dkQfq3cKWf72ee5bbyGEsqekiRjfbsZ4SDcZv+3+/c8Ae2WKo2+V0azQ
         1hdA==
X-Gm-Message-State: AGRZ1gJQEwWap2JMYDNl2ik2EJKnUD6rM9KhmDQ9vDDIyXKCEIkX2Oh0
        aT68NROptV7I/WwtQdXga2IOijpVnRoaCe3hnDYjHg==
X-Google-Smtp-Source: AJdET5ct4Jz2ImvnSes6xT6/sdhtS3+MlJSzM34b6UsbqVLwwDxURFepreo7jts1H4FlA0Lagtg65/dNK5mlgRNY4BQ=
X-Received: by 2002:a62:8647:: with SMTP id x68-v6mr2497641pfd.252.1542056658275;
 Mon, 12 Nov 2018 13:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20181014170431.GK3461@darkstar.musicnaut.iki.fi>
 <CA+7wUszkduiKMVx5Et3Q2-2tz72CXUKE1_kndC6V1d45uEY2Aw@mail.gmail.com> <20181017195050.GA20347@darkstar.musicnaut.iki.fi>
In-Reply-To: <20181017195050.GA20347@darkstar.musicnaut.iki.fi>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Mon, 12 Nov 2018 18:04:06 -0300
Message-ID: <CAAEAJfBUEj+4RnHmK9RvOv7cghQNr0xNqr5GdVTG+V88+Kzi8Q@mail.gmail.com>
Subject: Re: Bug report: MIPS CI20/jz4740-mmc DMA and PREEMPT_NONE
To:     aaro.koskinen@iki.fi
Cc:     Mathieu Malaterre <malat@debian.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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

On Wed, 17 Oct 2018 at 16:50, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> Hi,
>
> On Wed, Oct 17, 2018 at 03:38:07PM +0200, Mathieu Malaterre wrote:
> > Since CONFIG_PREEMPT has been 'y' since at least commit 0752f92934292
> > could you confirm that the original mmc driver (kernel from imgtech
> > people) did work ok with PREEMPT_NONE (sorry I did not do my homework)
> > ?
>
> Sorry, cannot confirm or test that. I have only used the mainline kernel
> on this board, since v4.5 or so with my own custom config which has
> been PREEMPT_NONE until now.
>

Aaro,

I spent some time today investigating this issue. I think this driver
has a broken pre-request/post-request implementation.

Will post some patches soon.

Thanks for the report,
-- 
Ezequiel García, VanguardiaSur
www.vanguardiasur.com.ar
