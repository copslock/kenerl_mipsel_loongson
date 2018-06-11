Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2018 10:59:26 +0200 (CEST)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:35076
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990406AbeFKI7SttYvb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jun 2018 10:59:18 +0200
Received: by mail-lf0-x244.google.com with SMTP id i15-v6so19046265lfc.2;
        Mon, 11 Jun 2018 01:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cmHOackrM7toBNxodTtQKxAuxRZbvGgu0kQ/oXiC7HA=;
        b=HcTfstZ0QzMYkABaR5IYWQtcK17fKZMVCVMCU+hSzEsZDa2bbTDSvbVxmkVQ/4BP3u
         qySTxiPJJXQCJtnbLcBbduRIwRNPJOz8vjpTUUH56lY6W7xcwVMDvRVjj4SlvTLTP/bd
         ULHKMkus7ZLYLB+TPdU/kVljJEuo+WDVKXVjjDNfy+6z29HURjdC8AvUghmKsltWlwGX
         F7tIjUXIfgE24kNhLPWSOS3L+owNX3boO5fK0Re3k9ll52qcRiJSP83AZBlxRhyJQVGs
         9OUt0Qx+TZbw0V6J7ubAJXGH8iHw0ni5MzGBCmx93NRiDLxAXNQEmM4c5fmHKM67BlZi
         7lSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cmHOackrM7toBNxodTtQKxAuxRZbvGgu0kQ/oXiC7HA=;
        b=aPC/1wcZUIpRGsRg3+5LM/iCje9oKfDhHXpIIZkdCmd4W+5ehQaUaqaNqqBrcuTcWb
         cR1O4tcpG2r6LlOH9hKaCxIq79tdb6Pe+J7PrTBjM4XFa30N1aTaKp6/qoVOmVD/Q0V+
         zGPgbeA1DZvwPTMEMrl3jbV7v7LKbygVSihtY9YOSnbox7S9aewI8uyq3uF6KGpYNTOw
         hu2M+fI1x/XSP27Q0uyYDAYVIM0GQA6/iRDcnagVaPxCGM/Ticf3olIutA1YTPJbvXTv
         Xz0WLil9EguqmW7S7kZV6jksmk4ntU2zkVfp8yW5l+dzQFAKVpWnDmbVQDjDPH4HM3Qc
         7HbQ==
X-Gm-Message-State: APt69E2H62blkvZAPV/QiESG2VxkWPINh/sx1edLAS5oHOYC8AsRaEyN
        fosD2tCvwE1kglaoffpqyp3B6YCH8EF06QIGq30=
X-Google-Smtp-Source: ADUXVKJ070nYlgsetMLgCQk9en45kpPhF58MvywStrrgxcutJ/36ZN8glV8ZS2xkywOtuZpmE3LzidZyWCStaLGY43g=
X-Received: by 2002:a19:c203:: with SMTP id l3-v6mr10330051lfc.55.1528707553231;
 Mon, 11 Jun 2018 01:59:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 01:59:12
 -0700 (PDT)
In-Reply-To: <1528706663-20670-4-git-send-email-geert@linux-m68k.org>
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org> <1528706663-20670-4-git-send-email-geert@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Jun 2018 10:59:12 +0200
X-Google-Sender-Auth: JgdAQOxMhwOi7TXc4PgGGtPeZBE
Message-ID: <CAK8P3a1mhVJYuQGZM+ypQ1mKbB=+5gA6L=_D7-jjPmShLarwUQ@mail.gmail.com>
Subject: Re: [PATCH 3/3 RFC] Revert "net: stmmac: fix build failure due to
 missing COMMON_CLK dependency"
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
X-archive-position: 64222
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
> This reverts commit bde4975310eb1982bd0bbff673989052d92fd481.
>
> All legacy clock implementations now implement clk_set_rate() (Some
> implementations may be dummies, though).
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Marked "RFC", as this depends on "m68k: coldfire: Normalize clk API" and
> "MIPS: AR7: Normalize clk API".

This seems reasonable. It's possible that it will cause regressions because the
COMMON_CLK dependency hides another dependency on something else
that not everything implements, but we should fix that properly if that happens.

       Arnd
