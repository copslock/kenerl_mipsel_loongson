Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 23:31:00 +0200 (CEST)
Received: from mail-ua0-x243.google.com ([IPv6:2607:f8b0:400c:c08::243]:45090
        "EHLO mail-ua0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993024AbeGQVa4gQnB8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jul 2018 23:30:56 +0200
Received: by mail-ua0-x243.google.com with SMTP id k8-v6so1614498uaq.12
        for <linux-mips@linux-mips.org>; Tue, 17 Jul 2018 14:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IB+S9R6am3lT0ggeX1v9NqkNR06cnM9Rr0oHlTw/k30=;
        b=MAnd2XhYBy0/0nibXURTmxE5xZV/1Iib+32Mnc1ccRHu9kWBIFKp7TYZ7o9+Dbc9Ns
         E43lF0vvSz5uwi/NSu2v8wcCeBR5krJD5IvFe5Kc2xKtVhl8yuWx+F2OeQiYYsdHvK6l
         vXtXwJY2l7fVZvOOYixfBUz82yOHsYbhmQda9DJMstDsuk2S6nv2Vzjw+MfQNU4CxJQL
         mmFiLBQh6FW1D9fsITVYkWeS4r47JVv/ORTNAXNDhVBfkOl5iaWo8alrwwavYjnTOVZ0
         bb9RNtOf07+Syy9to65RZeBYo6J+8hqxuzb1+LFvUBNas9LUWBfghNt5gCwysh3QTXgr
         BApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IB+S9R6am3lT0ggeX1v9NqkNR06cnM9Rr0oHlTw/k30=;
        b=auUZIHnfOlefFLQUZGAYguLWXbFJNemAlzAdLvQAxwAN3AUhww+U8w7w5Btdu46egx
         4s9Usq8yYDKvA0BzFsl5796LPXS4GZrHe3LSdHh5rIoJXK08I8a5AdCJ7A1uRPRMhtnM
         v3yVSzMBWMYbF4D1yFW1S4MsDrmyHdoU87Rs+Wq14Wdc7MuENusI50WjGzFLnEn7yFIF
         ff++WsiFJ4dvrjkNrQ4pIEx6XeO7B9N411FHi1/LDNvKmJI7M8G8zvWxf26Kq51+2tAN
         Ofkm/Ky0pCqBFvPj0QU4ka5CktHQz5p3+f+q1XYPQ9g1NUXI2t+cYocDA10EaBEtlSaQ
         9N2w==
X-Gm-Message-State: AOUpUlF/WDGM1xOnbyrp5Kc5mHudMM8+5hjvqun1nstap8zGjH3VPgSt
        IMpcRZKdqrJ6QfMvBsHxo9bxEz2h/FOLGGNkMSI=
X-Google-Smtp-Source: AAOMgpeGBNBwsB8dHZMI2xYlox+0Pk6algpITuWJGqr2lkr9CeLtupIwJqcxt0EBB1vOKTFF/zXAkNrWiV04UvTcP9I=
X-Received: by 2002:a9f:2187:: with SMTP id 7-v6mr2344195uac.49.1531863050590;
 Tue, 17 Jul 2018 14:30:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 14:30:49
 -0700 (PDT)
In-Reply-To: <CAHp75Vc4SrMXznc6PSrO2Lfrc3gspu_g1QYjuFDWT9-J=C+bjw@mail.gmail.com>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
 <20180717142314.32337-2-alexandre.belloni@bootlin.com> <CAHp75Vc4SrMXznc6PSrO2Lfrc3gspu_g1QYjuFDWT9-J=C+bjw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Jul 2018 00:30:49 +0300
Message-ID: <CAHp75VfRS_gSv6x22M1TiTariUftF04sLyd84dQpxudOmT0s7w@mail.gmail.com>
Subject: Re: [PATCH 1/5] spi: dw: fix possible race condition
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
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

On Wed, Jul 18, 2018 at 12:30 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jul 17, 2018 at 5:23 PM, Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Shouldn't it have a Fixes tag?

-- 
With Best Regards,
Andy Shevchenko
