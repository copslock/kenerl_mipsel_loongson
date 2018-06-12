Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2018 09:32:27 +0200 (CEST)
Received: from mail-ua0-f195.google.com ([209.85.217.195]:36707 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992496AbeFLHcQY7BtV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2018 09:32:16 +0200
Received: by mail-ua0-f195.google.com with SMTP id c23-v6so15294967uan.3;
        Tue, 12 Jun 2018 00:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZkuAVGXNysuh02rnOn+qkguRzbJWt5KzZCa1KKykFZ4=;
        b=ZGX7ZZXxbCGk4/2HOIC4oyuWblhbNKmKITvHzkEHdGYTEzNysfHUSm8Oy8fuETDfxR
         RG+IXaCOd0sOsvLIM4/9/qZ8MmDuwt0E6wo3tcmUxQDKl7DTbj+7iGN1LjGaSeD01POr
         hq9BycKIvDz7lrxfB+rDD3SJp0Ut/dlAFNKJIldNKAT25n8ZYEzl50b0Bc4PXrbn0G7m
         cEc7CB6dk9tpW0LVkeYzya8L/ezdzYuvv8ZLSXZArEQampm1HippLRpXCf8ij2gFudqJ
         fA98xwFqI+llz7+ZJfYFfLBoRCR6SKrNXO++hndXRFJP5ruqmgwQJ6kLTdJDaVXx+N5D
         tTdQ==
X-Gm-Message-State: APt69E3q24W9tIP8z7aEIuR54CoEw4UTmUEz6IRXEgy14bOogkOO/8c2
        DN9MN6Sg3Q7rCCAtPwYd6FIBW1DQuhZvSnx6I9A=
X-Google-Smtp-Source: ADUXVKLe61r6hcO+a07acV/jbzNEXLSJxcpl+WQ+pI88Yz1DhD6LVFOQ60wzjr58faeI+dcFjMEKhAQcll345BFfTR8=
X-Received: by 2002:ab0:265:: with SMTP id 92-v6mr1755640uas.26.1528788730321;
 Tue, 12 Jun 2018 00:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
 <1528706663-20670-2-git-send-email-geert@linux-m68k.org> <944b08ba-a882-e6cd-42fa-9251bce1d7b1@linux-m68k.org>
In-Reply-To: <944b08ba-a882-e6cd-42fa-9251bce1d7b1@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Jun 2018 09:31:59 +0200
Message-ID: <CAMuHMdUyD8d2yoe6v8TEinEH3hhS7Znv99pPxDCkr_uEFS0Fzg@mail.gmail.com>
Subject: Re: [PATCH 1/3] m68k: coldfire: Normalize clk API
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64236
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

Hi Greg,

On Tue, Jun 12, 2018 at 9:27 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 11/06/18 18:44, Geert Uytterhoeven wrote:
> > Coldfire still provides its own variant of the clk API rather than using
> > the generic COMMON_CLK API.  This generally works, but it causes some
> > link errors with drivers using the clk_round_rate(), clk_set_rate(),
> > clk_set_parent(), or clk_get_parent() functions when a platform lacks
> > those interfaces.
> >
> > This adds empty stub implementations for each of them, and I don't even
> > try to do something useful here but instead just print a WARN() message
> > to make it obvious what is going on if they ever end up being called.
> >
> > The drivers that call these won't be used on these platforms (otherwise
> > we'd get a link error today), so the added code is harmless bloat and
> > will warn about accidental use.
> >
> > Based on commit bd7fefe1f06ca6cc ("ARM: w90x900: normalize clk API").
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> I am fine with this for ColdFire, so
>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Thanks!

> Are you going to take this/these via your m68k git tree?

I''m fine delagating this to you.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
