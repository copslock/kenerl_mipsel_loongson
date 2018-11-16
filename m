Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Nov 2018 10:10:52 +0100 (CET)
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39032 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990397AbeKPJKNSII5h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Nov 2018 10:10:13 +0100
Received: by mail-vs1-f67.google.com with SMTP id h78so13345667vsi.6
        for <linux-mips@linux-mips.org>; Fri, 16 Nov 2018 01:10:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qIfpn7h25apnxv19ipNRo2saSk++fXxcgVKZddxbd8=;
        b=N8iy/dLBxu2hP9yFJ3M6eeWhftYTOSTlVJuvIYwf3HtNICkHBW2rBsxChcRjHWfeZW
         LtB/Zp+3LBCJi4D8DT9NiE7BzNea+ohwH4HJphd4Ru2hsQ+AkGClUJUS1y5BHt74dUYV
         JaVdqsjfIujN6YMTcJOT5L9gW/CcfgaAuh7Jq7rQbqGAFFiCDq4BKTVIs2G6Tz1Bvt8t
         NJ8SXjVEntYIkfHOsIBVDaAgTrBmgXDsDoESRzUYkGfoJ/o6gH+VnwFYxL090GmK58CB
         n6CoPlRa6LZpZvw0G3tLT9wsA5xweW690gFZKZi33EkKivguDR4kb4i0HgtqN2H1So5X
         0eaw==
X-Gm-Message-State: AGRZ1gJNNCMltIHipRR5eouLuBKMoBslpIi/WMG537BTRQLDqkJ9tTYp
        Nv/HW8978BmaWs/ldxgNEH9Q2XF/Mi8HrZpQCO8=
X-Google-Smtp-Source: AJdET5dlfGYqms4VL8TAsTO4xbguV5f6uh/c85Xjvb5Y+HsSloqPxkMAmjYYAmv6yQBQjwLoHd4Z5CWuXeMdl6pHxzk=
X-Received: by 2002:a67:3885:: with SMTP id n5mr3694101vsi.96.1542359412431;
 Fri, 16 Nov 2018 01:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de> <20181115190538.17016-5-hch@lst.de>
In-Reply-To: <20181115190538.17016-5-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 16 Nov 2018 10:10:00 +0100
Message-ID: <CAMuHMdUSr6uxXUv8HtWZihFVj9zR8SJoFByLJ=J+_Lj-Mmgagg@mail.gmail.com>
Subject: Re: [PATCH 4/9] PCI: consolidate PCI config entry in drivers/pci
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alex Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67327
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

On Thu, Nov 15, 2018 at 8:06 PM Christoph Hellwig <hch@lst.de> wrote:
> There is no good reason to duplicate the PCI menu in every architecture.
> Instead provide a selectable HAVE_PCI symbol that indicates availability
> of PCI support, and a FORCE_PCI symbol to for PCI on and the handle the
> rest in drivers/pci.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
