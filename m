Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2014 11:04:43 +0200 (CEST)
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37010 "EHLO
        mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008535AbaI2JElhDH0H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Sep 2014 11:04:41 +0200
Received: by mail-ig0-f176.google.com with SMTP id hn18so286425igb.3
        for <linux-mips@linux-mips.org>; Mon, 29 Sep 2014 02:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0WChOfB6pstj8r+38gq6gN6Yb/BKdxXOH22aKo8zyNc=;
        b=BzgmFnraDKUNUrawTj4sFptQ0Uzy020GTZm+jdYd4Kq0iDSrBtgaIawhLoLhUII43n
         bvj/6bYEpXfjeh2f9D3CltxOfS2ZszxmLjc0RjZ7vOleYS9b5mYKbhw7FFdIvCc+pbi8
         bBRDSbf9Gx+/lQQyqRVgaDugb0Fa54nZIv+49jdJNf7+HKIdhYNsHKjC2H6bFNCU6JOs
         6Yg8TBJ8LypXXub8Aq11qjV960S1cC97DyNYWEpB8w+XL/mIYU14TrzAZMmLY4BcavVh
         /Ijj3P0gYCkNau2OsHF+rh3x/voLgy8xufFGvtMZ3eLZ1xvbNaptEZX9liwVgVhkP4vp
         wElA==
X-Gm-Message-State: ALoCoQnzH4pklpzAirFHrBqhaIaqZTEcN/t7DkTNJigsCF2m9GayejPRHJ8oOKccvovLNZtigORq
MIME-Version: 1.0
X-Received: by 10.42.86.145 with SMTP id u17mr45818569icl.20.1411981475901;
 Mon, 29 Sep 2014 02:04:35 -0700 (PDT)
Received: by 10.43.102.201 with HTTP; Mon, 29 Sep 2014 02:04:35 -0700 (PDT)
In-Reply-To: <CACRpkda2nNqb9iARw+ze=vsdmXVePGu+Fb5PMGo75FSCGJ+tDA@mail.gmail.com>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
        <1410723213-22440-9-git-send-email-ryazanov.s.a@gmail.com>
        <CACRpkda2nNqb9iARw+ze=vsdmXVePGu+Fb5PMGo75FSCGJ+tDA@mail.gmail.com>
Date:   Mon, 29 Sep 2014 11:04:35 +0200
Message-ID: <CACRpkdZTrE6q==SqtH91iYYSce9pzLkb=0_UY7a=jJSo8Zg7Bw@mail.gmail.com>
Subject: Re: [RFC 08/18] gpio: add driver for Atheros AR5312 SoC GPIO controller
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42876
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

On Mon, Sep 29, 2014 at 11:03 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> This driver seems surplus, it's just MMIO. Use
> drivers/gpio/gpio-generic.c instead.

Bah, I'm talking crap. It does IRQs so it needs to be a custom
driver for sure. I'll take a second look.

Yours,
Linus Walleij
