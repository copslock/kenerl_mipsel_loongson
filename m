Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Oct 2015 08:55:18 +0200 (CEST)
Received: from mail-ob0-f171.google.com ([209.85.214.171]:36645 "EHLO
        mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008199AbbJSGzPOqSsL convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Oct 2015 08:55:15 +0200
Received: by obcqt19 with SMTP id qt19so53344885obc.3
        for <linux-mips@linux-mips.org>; Sun, 18 Oct 2015 23:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0/aR8s+u6upaevND+ll7jf+HFybzu/FwiyPmbh9Kc/Y=;
        b=H9TkeIiAHC1wp2hnAdW3uWLL9gzXQHFaMUq/L7xV2CS7f4a1r01bBw9C++8ThIc20f
         a+zmr7XOsnxGOLtI92AUZx5+ai/5vWYFYx8zXPA2Ux4uPrzqe7E5/JjAeuSt3SVctWWh
         6UJyYCEOlZzepqPofJCQDWoABRYbsaP8F4UEPeTM24PQGYPlzOAk3QBbTrHUTdatQ9qD
         JKTWDuuFTMulmC7suheFoVZ/ILU1QwbwkNYYfPWI5iGN3W2wGHHSzXn0CxBJd1EFBIF2
         VUhHjLjp73uXjLgMhNsKrNlG00N6fS0247F99sqm4D5AGgGn7J0Yynj261UKu8aczq+t
         LYkA==
X-Gm-Message-State: ALoCoQmHLJJyuJItkyScPsAxok1MKOtkQx0U26Qnl6atyMmo4jKWhZrkoETej77IrntIozux6BI4
MIME-Version: 1.0
X-Received: by 10.60.40.133 with SMTP id x5mr1605762oek.34.1445237709600; Sun,
 18 Oct 2015 23:55:09 -0700 (PDT)
Received: by 10.182.214.104 with HTTP; Sun, 18 Oct 2015 23:55:09 -0700 (PDT)
In-Reply-To: <561E7B65.3090704@metafoo.de>
References: <1444827117-10939-1-git-send-email-Zubair.Kakakhel@imgtec.com>
        <1444827117-10939-3-git-send-email-Zubair.Kakakhel@imgtec.com>
        <20151014151813.GL15287@xsjsorenbubuntu>
        <561E7B65.3090704@metafoo.de>
Date:   Mon, 19 Oct 2015 08:55:09 +0200
Message-ID: <CACRpkdb0joX35HdcSJ=afchMCNVo7i=an3HE4BnK0xA_Gb5YpA@mail.gmail.com>
Subject: Re: [PATCH 2/5] gpio/xilinx: enable for MIPS
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49593
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

On Wed, Oct 14, 2015 at 5:57 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 10/14/2015 05:18 PM, Sören Brinkmann wrote:
>> On Wed, 2015-10-14 at 01:51PM +0100, Zubair Lutfullah Kakakhel wrote:

>> Hmm, in general, this driver is hopefully generic enough that it doesn't
>> have any real architecture dependencies. And I suspect, we want to
>> enable this driver for ARM64 for ZynqMP soon too. Should we probably
>> drop these arch dependencies completely? It seems to become quite a long list.
>
> I've been thinking about this a while ago. This is certainly not the only
> driver affected by this problem. But the thing is people always complain if
> new symbols become visable in Kconfig that don't apply to their platform.

I don't think it's that important. If people go do down in the GPIO submenu
they are looking at real weird stuff anyways. Please send a patch enabling
this for all rather than coming up with strange config symbols IMO.

Yours,
Linus Walleij
