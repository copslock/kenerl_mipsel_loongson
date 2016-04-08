Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2016 16:30:49 +0200 (CEST)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36679 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026277AbcDHOarHKOoR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Apr 2016 16:30:47 +0200
Received: by mail-wm0-f65.google.com with SMTP id l6so4777340wml.3;
        Fri, 08 Apr 2016 07:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HO+UPBxLz5p+eQisHPkR+l3JdGOux4gSOtR/BKuqtpo=;
        b=VUmbI1lPeIeuzDPra3K5qnyT1gPqXyxxfNtx3bGNWlKAcc4UlrawQRPoWT80TAJU2i
         hxfDtI4lzTytkCsKx2BZ6UT+MgImkQR7+aj1g6k06RI2FS0Fy3vpsFDvFxS+zqC/qE6c
         ndd7HQf1oneGg77CEfF3SxFNPxRuHXrSRvbKXQlKl6w478pceWwlRpLv3UxYDi4/3DD1
         NcTwD0nP0JkJDJ/zRtKPVmg1i53T+Qq189UEYIxzYW7CV4CrsBOnCtElXCJkdLapW9/6
         ikCVGdihyndY4ZNFrKB2QN4YCawjU/d2LjoF5OLO5DaLnh+d00LZ13YcYJe2ZNudXzYY
         kAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HO+UPBxLz5p+eQisHPkR+l3JdGOux4gSOtR/BKuqtpo=;
        b=ZqrN9EblZhw82TmdVskWi0e06z0mrkfBJ4UePmOUgAntDmat/UVqdIBdcrsWvso0xn
         DbcVX7DfhJWXAdYy8s/QYdbGli2Lj7AWrQEzNxwWUqPT5Fi3Cs7xUDPd9gcpnUduzhMt
         ChW8PYLAuEf01ISVkb2aSl4GBqOs680KljI9Gwf0RFZXR5ibS+nlmlQ6htJE6Nj3W3p9
         H8sp/AFivUOUDC4bzKZD5CjK7NxBhsbzSGiL9R/VPhc4VHss4EbEe5ck0rEjgQW8n2Nv
         Nre9cMYYq3PkLhg0u0VzylGxXG3rVFYdt6kUOQnQOVn6A2bOw/sYta5sio8+jSOLCwdb
         YSkw==
X-Gm-Message-State: AD7BkJLyES6W41lN0AM+c653xCqqDUGXJZWSXQ/A2mEY4JRHpU1FEAVIfvJS6Fzr56YORtt11HqXUbc0yj8Jcw==
X-Received: by 10.194.71.226 with SMTP id y2mr9885248wju.127.1460125840909;
 Fri, 08 Apr 2016 07:30:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.246.66 with HTTP; Fri, 8 Apr 2016 07:30:21 -0700 (PDT)
In-Reply-To: <57079B87.9030209@nod.at>
References: <1460115779-13141-1-git-send-email-keguang.zhang@gmail.com>
 <1460115779-13141-4-git-send-email-keguang.zhang@gmail.com> <57079B87.9030209@nod.at>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Fri, 8 Apr 2016 22:30:21 +0800
Message-ID: <CAJhJPsXaidmMUX7CcTHshaYGZ-iqbaAExMh6eoOFDEAuzp4t7A@mail.gmail.com>
Subject: Re: [PATCH V2 4/7] mtd: nand: add Loongson1 NAND driver
To:     Richard Weinberger <richard@nod.at>, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

On 04/08/2016 07:52 PM, Richard Weinberger wrote:
> Am 08.04.2016 um 13:42 schrieb Keguang Zhang:
>> + chip->options = NAND_NO_SUBPAGE_WRITE;
>> + chip->ecc.mode = NAND_ECC_SOFT;
> Is the lack of HW ECC and subpage write a hardware limitation?

Yes, that's the hardware limitation of Loongson1B NAND controller.

> Thanks,
> //richard

Best regards,

Keguang Zhang
