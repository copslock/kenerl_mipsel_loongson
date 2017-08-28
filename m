Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Aug 2017 08:26:43 +0200 (CEST)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:33338
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991131AbdH1G0frEVVj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Aug 2017 08:26:35 +0200
Received: by mail-pg0-x241.google.com with SMTP id q16so5687045pgc.0
        for <linux-mips@linux-mips.org>; Sun, 27 Aug 2017 23:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=o2r6ww6wqepZOlWmszucYXGNqxFZr/kx5uznVpnhaGQ=;
        b=A171deNIKDvRUAaL1JypLCfaLRMqstue+NWDLu/1SOgq/iwaRFTJjqRS949YENDntW
         tKw2vIILbxRfvlKjLooMSdLJUB7qFNmhxrsIfusruT8jZ0XIKxDv2kJuABS9Ban11am2
         skFuubaBkWY3/PJ5OFAxPiuv9inYdUJ46Yr1YJl6ASlzI/lxTeBIkQLTPLkZxtOMGeYU
         FRKOmbwNjbHmx2QrV1MDY3yQ/69evi0tpF2Qu9t9VUsSpW1+3mq+ZigHicWMiUeI3M4n
         T2BjRit/xmnKQO1Jsw43oSHuKjaXwnrtR1M39DQQX4FszFAVbXxxikg+4eFZ3EI7KUyB
         /qkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=o2r6ww6wqepZOlWmszucYXGNqxFZr/kx5uznVpnhaGQ=;
        b=n8BH/AnX8V/LEG9dmot51YnaqqTO7PacmTKtRx1vzmb4OjVojmBTMEhobt+v2PsJRc
         uAslOZgiJpYajEhosMNqrTEW0sAp9XG2G7lSgoF3Y0bayK4XaUrV6Fi64x+hpi/RcfSa
         uNGemn3EpYSpJVvg+y/oYEx9DEXjIPwCzeYqfHovLuCdOxZsFwWz1XXJoZqroNgv7+XO
         ChCe+u6ObU5li84fc5ZJH0M3iErXJ3bB0cXaYjXOpEdiFCNSWXyEyggZhvsCOOkboHM7
         TscHjZXPqsSQnea38Qc89/5YomFYK3jQMlEuoOZX1h3gcaxAoOtWRqruF7Or2N3sJ8WT
         ZQNQ==
X-Gm-Message-State: AHYfb5gD7Mm/EzQhXCzycMVTpi2Idkf5S2bdvMkKI+UT64UpxxGg7w2l
        jg9uNlIq27faZruPZzQiywgcbY46Og==
X-Received: by 10.101.73.198 with SMTP id t6mr6594554pgs.340.1503901589854;
 Sun, 27 Aug 2017 23:26:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.139 with HTTP; Sun, 27 Aug 2017 23:26:29 -0700 (PDT)
In-Reply-To: <20170827161032.22772-13-hch@lst.de>
References: <20170827161032.22772-1-hch@lst.de> <20170827161032.22772-13-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Aug 2017 08:26:29 +0200
X-Google-Sender-Auth: RoLkdPQg1hiOK5xHOURWc5WjUms
Message-ID: <CAMuHMdVwHx2aATKqYS7xXTjnCigoZzVFFfcZOmvNj3KcFFJehg@mail.gmail.com>
Subject: Re: [PATCH 12/12] dma-mapping: turn dma_cache_sync into a dma_map_ops method
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        David Howells <dhowells@redhat.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59829
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

Hi Christoph,

On Sun, Aug 27, 2017 at 6:10 PM, Christoph Hellwig <hch@lst.de> wrote:
> After we removed all the dead wood it turns out only two architectures
> actually implement dma_cache_sync as a no-op: mips and parisc.  Add

s/no-op/real op/

> a cache_sync method to struct dma_map_ops and implement it for the
> mips defualt DMA ops, and the parisc pa11 ops.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
