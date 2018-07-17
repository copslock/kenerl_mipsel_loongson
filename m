Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 23:54:32 +0200 (CEST)
Received: from mail-vk0-x242.google.com ([IPv6:2607:f8b0:400c:c05::242]:44585
        "EHLO mail-vk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992482AbeGQVy22vx28 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jul 2018 23:54:28 +0200
Received: by mail-vk0-x242.google.com with SMTP id 125-v6so1413843vke.11
        for <linux-mips@linux-mips.org>; Tue, 17 Jul 2018 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U/dnaiGtJuYHtI7VDkkqVBq5rgXXs7fzI/Uh6IC24OU=;
        b=QZtuZRdPs8VFR4+yglZZIFU3/pvLS3IWAm+ZVa7j69l72QtI/DgHr1TfKdWNtZFgeE
         yzBL54Hb3xRMgEUYit0/YRXaXC7f0KmQTXrwk2cSQXTbwmDVEpcRPFi1tAnhJf0pdGSP
         FYbtGj9GTMOjnpLlPM6lUxlHBjQK7pJkpOk3Lxg3At3tzTTqy9FG6/JW4E5O5cPdB7SQ
         8SKnQBeFnSCrlFI4V6FVtEhVac7a+6gzwIKZOFf9ScHvu0SNFkuQVpf+lOMz/TEI8iUL
         87Pbx3qaluNYFh7TaL3C3Fcm9ArefNd+kenYPJBfJ0oW+ZiEe94f0+o7WRjFRuzgtvcS
         kAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U/dnaiGtJuYHtI7VDkkqVBq5rgXXs7fzI/Uh6IC24OU=;
        b=mHeaOVFYgrWEeN0cP7r3tFaXn85uPdmQEOnMwD3lzsp2cb3pHumaTFwZMOkBg27gBo
         Xgx25JwlUPzD7WwMHIyrG/NKmsqmz0d861R7ACJ52LtCSJB4OZbnjcjqkVASh/DRbn3z
         Az6knM3tSeKcg3epO3OnvldQjQKTs+vLLzWLq7FqPGwj08qu37oDH3t2xa7g/vN8jXbO
         H9JfP60xKEoQ8ncoN6U38HyjJKMzEVN7Wqkg8XjFLKd+aSiYW3o2EOdL0K7BWIfpTxJJ
         lsifWiYsTgyqqC7ywaDlIThYGZnvRuYOYkwg1ClFJq+7h2CBP8YeiSgrQjBVmksPO5/e
         7PYg==
X-Gm-Message-State: AOUpUlFdl1gxA+I22UGZQBggqaY+hM0hDf/32D+Miemya8xDOuEzPbQY
        7xF7YyWKH9Iv209mzTCISnZHOeztO/xVxdA9Ll5Sd/Sj
X-Google-Smtp-Source: AAOMgpdWowQcVNvtWO/wfPgPZYdBf4FiUWOSGxGiqz0K+Fk8LMUWPVw6dMa4YUwX8H2W+NIX9qhsQSM85t/ccrveIcs=
X-Received: by 2002:a1f:20d4:: with SMTP id g203-v6mr1995788vkg.176.1531864462359;
 Tue, 17 Jul 2018 14:54:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 14:54:21
 -0700 (PDT)
In-Reply-To: <20180717214212.GE3211@piout.net>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
 <20180717142314.32337-2-alexandre.belloni@bootlin.com> <CAHp75Vc4SrMXznc6PSrO2Lfrc3gspu_g1QYjuFDWT9-J=C+bjw@mail.gmail.com>
 <CAHp75VfRS_gSv6x22M1TiTariUftF04sLyd84dQpxudOmT0s7w@mail.gmail.com> <20180717214212.GE3211@piout.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Jul 2018 00:54:21 +0300
Message-ID: <CAHp75VdEkQ=AC8xUBno7qp0E+cXqwq03WOtVB3sX+Z6zthDJSw@mail.gmail.com>
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
X-archive-position: 64907
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

On Wed, Jul 18, 2018 at 12:42 AM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 18/07/2018 00:30:49+0300, Andy Shevchenko wrote:
>> On Wed, Jul 18, 2018 at 12:30 AM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>> > On Tue, Jul 17, 2018 at 5:23 PM, Alexandre Belloni
>> > <alexandre.belloni@bootlin.com> wrote:
>>
>> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> >
>> >> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>
>> Shouldn't it have a Fixes tag?
>>
>
> Well, I'm not sure how far this can be backported. It also seems nobody
> ever hit that while our hardware will hit it at every boot.
>
> I'll try to find out.

No-one enabled CONFIG_DEBUG_SHIRQ?

-- 
With Best Regards,
Andy Shevchenko
