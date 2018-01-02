Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 11:38:21 +0100 (CET)
Received: from mail-qk0-x241.google.com ([IPv6:2607:f8b0:400d:c09::241]:41229
        "EHLO mail-qk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992396AbeABKiN5JT07 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 11:38:13 +0100
Received: by mail-qk0-x241.google.com with SMTP id a8so23508515qkb.8
        for <linux-mips@linux-mips.org>; Tue, 02 Jan 2018 02:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kcGZjOVrx3+3i0d5dYGMeXcfaaIL5yWUZlCAVfcHtXE=;
        b=dkN2XbgQn4hX5pk+3HUsHdW00eaBCWsrGcI7TrxsNt9F0rHsVhaRSDRGN/wRBZk5uH
         n9P1yJOpIVe2/p2VIFBjNJyCfFde1vHjxibo8HPjQXMsThEkhjzWsL97PuFtt4xFKph6
         LuijXeqNnPc0R8AFVODousI9s78N4WYft568nXBRphXQ2yzZ5PTgn06h1yTPoFgBESxW
         HVuyzEQsF2xxMBQfsj57jBlItI3pSJRUeK4dJzx3YoRM7xkHaL70Hbacu9b5BBVnNWO6
         SkKUv9l4TgDgzqEunGxjAj8TGPzoPWtQ9+FwUvPjSvz93FlGrNY6au/1BROEtKN5Ar0O
         YFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kcGZjOVrx3+3i0d5dYGMeXcfaaIL5yWUZlCAVfcHtXE=;
        b=aPs0xErt0mnPSj1Wt1I7m45IOg++DDsGz5vGqgwSCo0VS18buA4EQBfrAPZhjhNWck
         e7g2zlCHdOF9seb7gcxUMjtcdC+vVCQTn9WMNUWffgyhwropRs6toUCOw75xtFUZcQ1j
         8Os/wu3biRiZLRjDUCbM0vzVBBon3VQKzDjYlN+ExQv/RpnXR9VD2CxVwXIyRiYsTw0g
         v8kf5MxdQAZKqQ/SC0NtqqzCZiAb5ZrOsFqvlxJ6jPmku/W46hd0dwsARKvs1zj4NUS1
         c+Ds6EhXOv2f/xwaMK5KSiO8pEWYabu1ZonvIRv7WGlF3oFn/5NPtB61vGpf5ekijSci
         jJPw==
X-Gm-Message-State: AKGB3mJNcFyX+LTGsbZMkWuWijCi6A8X5+yyafmWZ1vekN08K35pAsPa
        EQAKglOQkxFi5BqUuzUicUvSootr+NcXHvsv+qk=
X-Google-Smtp-Source: ACJfBotGXEAylIb/SpW83cXdigUZ+uPsPbaukenqpu4795leLAl08l3OE6LMVfFZifPMA+o03M2/vb0oslgjMaoYdcA=
X-Received: by 10.55.75.19 with SMTP id y19mr45656139qka.45.1514889487994;
 Tue, 02 Jan 2018 02:38:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.44.66 with HTTP; Tue, 2 Jan 2018 02:38:07 -0800 (PST)
In-Reply-To: <20171229081911.2802-23-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-23-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Jan 2018 11:38:07 +0100
X-Google-Sender-Auth: qasid63ZD4Vbm8WOVDE5bXViywk
Message-ID: <CAMuHMdX6+E0tN-qxybQ27DoygpUsWngi8J+Fz6K2WZ=FCCuO_A@mail.gmail.com>
Subject: Re: [PATCH 22/67] dma-mapping: clear harmful GFP_* flags in common code
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        alpha <linux-alpha@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, Cris <linux-cris-kernel@axis.com>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61820
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

On Fri, Dec 29, 2017 at 9:18 AM, Christoph Hellwig <hch@lst.de> wrote:
> Life the code from x86 so that we behave consistently.  In the future we
> should probably warn if any of these is set.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
