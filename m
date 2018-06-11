Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2018 11:03:12 +0200 (CEST)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:34203
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990422AbeFKJC6W49Yb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jun 2018 11:02:58 +0200
Received: by mail-lf0-x243.google.com with SMTP id o9-v6so29363604lfk.1;
        Mon, 11 Jun 2018 02:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EAidKCBZ+2a3EqXWgXbW+ePZySVlGnhaMBmN/EdlonQ=;
        b=C4oY64LdYBxusgaqA7r4Xl5ZdbT8FlhX1/1fLNDbeVA5QmMChkDU53Wkr72Q8hccCz
         A8a2X+r1fViqanHXM1zI4o9jj65C1b8048N7iFLse22k75kTUTlIPa6yLQUqiTlsDq/q
         a5r4pJbCdoKqyOcfLG76OOHW5+outAMR6R8l7RriOLoZhu722DYM4S3Cs8CUwWJ7wwDA
         GOLkHggPsogstvgvFwDt5M6WlEA7mSZbe53mY4sWkrXfwTjNcE8DR8JP5ywvURLrRmpR
         dtYrJr08iwPyRqy9ZJbOiJcTYZuxXKsM4iCHIz6Q9+8eZ/6UMYB/RBP6UAqOgDN6zL1j
         6VkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=EAidKCBZ+2a3EqXWgXbW+ePZySVlGnhaMBmN/EdlonQ=;
        b=qj/zbZD5uXl59+VB2tYsigLFnSoRGgmAWrg4pFtO+7OF4JLwNQg2x7IxwrlU1DvuAu
         otgWeg5bWAmdyawh6zx5YGR9TIFkwfNQHmSeTsYXg3tMQr7Bd/Nn13p8WhRzkDVclE+H
         IcUj9suHMI9woYNdsvbrwwW56zt7jyx2qJWasZ3CW//Eaoi4boxWat5s3+mqnE3/VTe6
         g3/dMVTTpAmHcSXP9ApX8ERBU3qUVHL6OlZubNUUSigP/GG9ArVbjwg7cTkppFAk53Pj
         oWE2wY3nZZx+tsF2T+nzXoHtYTCNgxAB+6DbDx1fZTt2rOysYVvhCeP8jBNYDuMWN0aK
         L/xg==
X-Gm-Message-State: APt69E3seGWXisL5fdvL/tSqULYioB341XYbSTYpO4bIrIkYXcUk3yrz
        WxkK7JRs1qTt2/J8054TI9jZWQ5v4P7/d0BbiT4=
X-Google-Smtp-Source: ADUXVKIMIRkWNXt4W8iYgYKgIiuWHTTgU6VWAqXixtOF3o9jT0Do6gbMZP13Qp2n75uLDqEA8FTSqg8PPFfvoX5uUEY=
X-Received: by 2002:a19:1460:: with SMTP id k93-v6mr10353795lfi.23.1528707772836;
 Mon, 11 Jun 2018 02:02:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 02:02:52
 -0700 (PDT)
In-Reply-To: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Jun 2018 11:02:52 +0200
X-Google-Sender-Auth: Mxh_Sf2EJaB4_0zemth4sa32SM4
Message-ID: <CAK8P3a0CJmpf0L-OXDmqP=kRLGCokR=v6jUPaCSpnFuCwHa7WA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Legacy clock drivers: Normalize clk API
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Mon, Jun 11, 2018 at 10:44 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>         Hi all,
>
> When seeing commit bde4975310eb1982 ("net: stmmac: fix build failure due
> to missing COMMON_CLK dependency"), I wondered why this dependency is
> needed, as all implementations of the clock API should implement all
> required functionality, or provide dummies.
>
> It turns out there were still two implementations that lacked the
> clk_set_rate() function: Coldfire and AR7.
>
> This series contains three patches:
>   - The first two patches add dummies for clk_set_rate(),
>     clk_set_rate(), clk_set_parent(), and clk_get_parent() to the
>     Coldfire and AR7, like Arnd has done for other legacy clock
>     implementations a while ago.
>   - The second patch removes the COMMON_CLK dependency from the stmmac
>     network drivers again, as it is no longer needed.
>     Obviously this patch has a hard dependency on the first two patches.

Yes, good idea.

Acked-by: Arnd Bergmann <arnd@arnd.de>

One question: what happens on machines that don't support any CLK
interface, i.e.
that don't have any of COMMON_CLK/HAVE_CLK/CLKDEV_LOOKUP?

I guess those are already hopelessly broken for many drivers, right?

         Arnd
