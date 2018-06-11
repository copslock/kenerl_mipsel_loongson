Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2018 11:10:12 +0200 (CEST)
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38469 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990422AbeFKJKEpHxxb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jun 2018 11:10:04 +0200
Received: by mail-ua0-f193.google.com with SMTP id 59-v6so13046157uas.5;
        Mon, 11 Jun 2018 02:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUwOeTLsw6vLCJAdkNMLBMN5py7rxS7EW1wp2CAtkHU=;
        b=GN0qoI7s2GwC/oXXd2dFKUoMq5Wx54VK+CyeK1e3vs0l/w7n7GICouY8lMGqQb9Zwr
         GK5TL7aAQ6ZLROeO1/GxSvtJgJdJUN56JikDqLvQMIIrfEXiQDvhCLHCXyFlcwhoBYMV
         Wl+dR7DZhoSpwtmfF2tQuRJF3hEngJBFAy5VZDPH3zMU5t3kg7Two85Hotu4xvtqIWaU
         XK+D64mrzONbGUUa4DTZlypQfx8UNxSpM1UCt8SyuUkI4jJ10l7VZKOGB7NEaI085aQg
         e7AmqM4F2vgcpAgpCtGoClNIt5u9IcAEs8ek/6HK1+IFNFSuuOh1XjsZXT3GPCOyg6y6
         vsCQ==
X-Gm-Message-State: APt69E3Po7FT4kLvv9bVzsv3imbIhfQq5ePYRotbriKNqNV4viIjBTDo
        /+X9qQjbVhE+LjTvsXb12ftbLtcT5p35Aqg3tVQ=
X-Google-Smtp-Source: ADUXVKLAQ0vWoPew7P3UiCQzTLb2p0B3mTbXsWn5HTrxG4zgtvjXQ9JM76mCF4rp5gHW3sIIH0PqLRarGVjP9ODQ7Zw=
X-Received: by 2002:ab0:96:: with SMTP id 22-v6mr10647389uaj.4.1528708197541;
 Mon, 11 Jun 2018 02:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org> <CAK8P3a0CJmpf0L-OXDmqP=kRLGCokR=v6jUPaCSpnFuCwHa7WA@mail.gmail.com>
In-Reply-To: <CAK8P3a0CJmpf0L-OXDmqP=kRLGCokR=v6jUPaCSpnFuCwHa7WA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Jun 2018 11:09:46 +0200
Message-ID: <CAMuHMdWozfKt87Gmy0yuZ+tUOv2ohTybkrb88evgWoyG8xfdgg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Legacy clock drivers: Normalize clk API
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Hi Arnd,

On Mon, Jun 11, 2018 at 11:02 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jun 11, 2018 at 10:44 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > When seeing commit bde4975310eb1982 ("net: stmmac: fix build failure due
> > to missing COMMON_CLK dependency"), I wondered why this dependency is
> > needed, as all implementations of the clock API should implement all
> > required functionality, or provide dummies.
> >
> > It turns out there were still two implementations that lacked the
> > clk_set_rate() function: Coldfire and AR7.
> >
> > This series contains three patches:
> >   - The first two patches add dummies for clk_set_rate(),
> >     clk_set_rate(), clk_set_parent(), and clk_get_parent() to the
> >     Coldfire and AR7, like Arnd has done for other legacy clock
> >     implementations a while ago.
> >   - The second patch removes the COMMON_CLK dependency from the stmmac
> >     network drivers again, as it is no longer needed.
> >     Obviously this patch has a hard dependency on the first two patches.
>
> Yes, good idea.
>
> Acked-by: Arnd Bergmann <arnd@arnd.de>

Thanks!

> One question: what happens on machines that don't support any CLK
> interface, i.e.
> that don't have any of COMMON_CLK/HAVE_CLK/CLKDEV_LOOKUP?
>
> I guess those are already hopelessly broken for many drivers, right?

Nope, they (e.g. m68k allmodconfig) build fine, as they don't define
CONFIG_HAVE_CLK.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
