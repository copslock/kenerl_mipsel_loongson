Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2018 11:13:55 +0200 (CEST)
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34013 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990406AbeFKJNrlmhnb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jun 2018 11:13:47 +0200
Received: by mail-vk0-f66.google.com with SMTP id q135-v6so11857109vkh.1;
        Mon, 11 Jun 2018 02:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAG1HlFNZLry04O83k28CkbuTEXx4nWXBwWX6+/dvaU=;
        b=g1qc+F1dzaksKN+jhbuRLNGP2oUvATx9b5M1/96eaCixyoXIIrU8BmhM2BxLE8hKHm
         y1rtjssdJiAJzzUhdW65ZvyB71vtQM2bRwi+d7yg6Kz4D0VhsKGAHZ/TQRZafpLMHIAX
         gdDvANhv8bCbbp0hzXA6jpC3M6FKuoRDrC8Spo2Uw8hZCFgfluIICcKpQVfqdn5ilpiN
         V1hVwB2Ozt/5LnyCo66dScBNdcUU+uvaXXUd846dh6UtNKAWRyCYZj6FRSjClTn7qXre
         bD9eGVlen19jXbPGJPCbd7kQpnkoTXtQGMCy7OU4+uPMwSwSQed9bbvVwnCH98HWDSoE
         ISqA==
X-Gm-Message-State: APt69E2jOD6scELA28wkGY+bm6J5uRH8Wpztk1eCfMmyfWSt09mgQIIv
        FsAVXkrMDCAdWEBHrFwbwP59QTdS2yAaewNGbIQ=
X-Google-Smtp-Source: ADUXVKIRcj3u8XYQFZt4KkKSi+mvq8ZA5h5GlH6xNyRraN+xpG9NGnF0TY/N3mUilBwITKVp5CkCy6blRrOMUIS01YI=
X-Received: by 2002:a1f:9e8c:: with SMTP id h134-v6mr9505301vke.125.1528708421922;
 Mon, 11 Jun 2018 02:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
 <1528706663-20670-4-git-send-email-geert@linux-m68k.org> <CAK8P3a1mhVJYuQGZM+ypQ1mKbB=+5gA6L=_D7-jjPmShLarwUQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1mhVJYuQGZM+ypQ1mKbB=+5gA6L=_D7-jjPmShLarwUQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Jun 2018 11:13:30 +0200
Message-ID: <CAMuHMdWQ_wm29Y7-qELcd4OdSc8bxEWUqcF_rfTX8JuQFDH16w@mail.gmail.com>
Subject: Re: [PATCH 3/3 RFC] Revert "net: stmmac: fix build failure due to
 missing COMMON_CLK dependency"
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
X-archive-position: 64226
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

On Mon, Jun 11, 2018 at 10:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jun 11, 2018 at 10:44 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > This reverts commit bde4975310eb1982bd0bbff673989052d92fd481.
> >
> > All legacy clock implementations now implement clk_set_rate() (Some
> > implementations may be dummies, though).
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > Marked "RFC", as this depends on "m68k: coldfire: Normalize clk API" and
> > "MIPS: AR7: Normalize clk API".
>
> This seems reasonable. It's possible that it will cause regressions because the
> COMMON_CLK dependency hides another dependency on something else
> that not everything implements, but we should fix that properly if that happens.

Compile-testing was enabled 2 years ago, in commit 2e280c188f06b190
("stmmac: make platform drivers depend on their associated SoC"), but the
dependency on COMMON_CLK was added only recently.
That's what triggered me: the drivers were suddenly disabled in m68k
allmodconfig,
while they built fine for years before.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
