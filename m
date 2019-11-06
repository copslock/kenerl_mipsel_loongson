Return-Path: <SRS0=1wql=Y6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A34C5DF65
	for <linux-mips@archiver.kernel.org>; Wed,  6 Nov 2019 18:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0EB21929
	for <linux-mips@archiver.kernel.org>; Wed,  6 Nov 2019 18:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbfKFS3C (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:29:02 -0500
Received: from verein.lst.de ([213.95.11.211]:52707 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbfKFS3C (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 6 Nov 2019 13:29:02 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B095A68AFE; Wed,  6 Nov 2019 19:28:57 +0100 (CET)
Date:   Wed, 6 Nov 2019 19:28:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Vincent Chen <deanbo422@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Greentime Hu <green.hu@gmail.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-mips@vger.kernel.org, alpha <linux-alpha@vger.kernel.org>,
        nios2-dev@lists.rocketboards.org
Subject: Re: [PATCH 11/21] asm-generic: don't provide ioremap for CONFIG_MMU
Message-ID: <20191106182857.GA21062@lst.de>
References: <20191029064834.23438-12-hch@lst.de> <mhng-33ea9141-2440-4a2d-8133-62094486fc48@palmer-si-x1c4> <CAMuHMdVuDp_8UDeWv8tdPAH5JS84=-yfwZjOk-YQcoYKM9za+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVuDp_8UDeWv8tdPAH5JS84=-yfwZjOk-YQcoYKM9za+w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Wed, Nov 06, 2019 at 07:16:38PM +0100, Geert Uytterhoeven wrote:
> > shouldn't they all just be that first one?  In other words, wouldn't it be
> > better to always provide the generic ioremap prototype and unify the ports
> > instead?
> 
> Agreed. But I'd go for the second one.

Eventually we should unify it and only have a single prototype.
But we have lots of implementations including inline functions, so
this will take a few more steps.
