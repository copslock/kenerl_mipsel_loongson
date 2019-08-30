Return-Path: <SRS0=WyAB=W2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACE0C3A59B
	for <linux-mips@archiver.kernel.org>; Fri, 30 Aug 2019 16:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2B623429
	for <linux-mips@archiver.kernel.org>; Fri, 30 Aug 2019 16:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfH3QGZ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:06:25 -0400
Received: from verein.lst.de ([213.95.11.211]:56881 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbfH3QGZ (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 30 Aug 2019 12:06:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C8F59227A8A; Fri, 30 Aug 2019 18:06:20 +0200 (CEST)
Date:   Fri, 30 Aug 2019 18:06:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        the arch/x86 maintainers <x86@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/26] m68k: simplify ioremap_nocache
Message-ID: <20190830160620.GD26887@lst.de>
References: <20190817073253.27819-1-hch@lst.de> <20190817073253.27819-9-hch@lst.de> <CAMuHMdWyXGjokWi7tn9JHCTz9YMb_vHn6XKeE7KzH5n-54Sy0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWyXGjokWi7tn9JHCTz9YMb_vHn6XKeE7KzH5n-54Sy0A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon, Aug 19, 2019 at 10:56:02AM +0200, Geert Uytterhoeven wrote:
> Hi Christoph,
> 
> On Sat, Aug 17, 2019 at 9:48 AM Christoph Hellwig <hch@lst.de> wrote:
> > Just define ioremap_nocache to ioremap instead of duplicating the
> > inline.  Also defined ioremap_uc in terms of ioremap instead of
> > the using a double indirection.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Do you mind picking this up through the m68k tree?
