Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jul 2015 14:44:17 +0200 (CEST)
Received: from mail-oi0-f46.google.com ([209.85.218.46]:32805 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010450AbbGPMoPh2L4G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Jul 2015 14:44:15 +0200
Received: by oige126 with SMTP id e126so49328810oig.0
        for <linux-mips@linux-mips.org>; Thu, 16 Jul 2015 05:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=cVYNOYn4+fT8AgWQEd+PYzTfmvNjdUM+Nx4SZ1RuPs0=;
        b=RPDcbEimGxg3e1WHbyxY19ZQjrcQiT2bytDYulwtkDc39exjXaYtKisdAUSavBa4jl
         FJnjImFKN+0W8rCa8UqHH01XCbGzoNQZrzyfQRBUZeBMzugToUCputlqe9l8PF3JS8QV
         N+gY1p+iUyPwIRybcTO0eA7aCrcx7G0NsCtJT5dSsjrnp6BznleZeRRu7pQQLgnVaiAN
         WcFpxB3zvxrGSSSb4swrj1Xw25EQZ6eBFyiWXi71salGJTpex2DIoYkigJ4Wra/0Prb2
         1zvG3psYOE2mgRYTdtj6YbBaCkijI9z7hOfJaXbYgSY1rcbvA4VG5PE5TyUF7RU2t5I+
         yk6A==
X-Gm-Message-State: ALoCoQln/PorvyVEPS/I+5jdBZj9OQjJwWmRSXqJEeX5PCb2s0PEo97lsH6ea+8bNbDtjzTXUNTt
MIME-Version: 1.0
X-Received: by 10.202.213.21 with SMTP id m21mr8199791oig.26.1437050649997;
 Thu, 16 Jul 2015 05:44:09 -0700 (PDT)
Received: by 10.182.204.41 with HTTP; Thu, 16 Jul 2015 05:44:09 -0700 (PDT)
In-Reply-To: <CAHNKnsSgyzQu5uxZHu80X9MRQ5sJ+WEBatv9599QYxBsty66pg@mail.gmail.com>
References: <1435914709-15092-1-git-send-email-albeu@free.fr>
        <1435914709-15092-2-git-send-email-albeu@free.fr>
        <CAHNKnsSgyzQu5uxZHu80X9MRQ5sJ+WEBatv9599QYxBsty66pg@mail.gmail.com>
Date:   Thu, 16 Jul 2015 14:44:09 +0200
Message-ID: <CACRpkdYgavq09dshgLZdo75KyuFwc4Cg0MosVgQN2KxW6VJt2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: ath79: Remove the unused GPIO function API
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Alban Bedel <albeu@free.fr>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48327
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

On Sat, Jul 4, 2015 at 6:58 PM, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
> 2015-07-03 12:11 GMT+03:00 Alban Bedel <albeu@free.fr>:
>> To prepare moving the GPIO driver to drivers/gpio remove the
>> platform specific pinmux API. As it is not used by any board,
>> and such functionality should better be implemented using the
>> pinmux subsystem just removing it seems to be the best option.
>>
> For reference: OpenWRT uses this functions to activate UART.

OpenWRT is wholeheartedly and warmly welcome to work upstream,
I will help whenever I can.

I have seen their patch stack and it makes me sad :(

Yours,
Linus Walleij
