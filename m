Return-Path: <SRS0=7Wy+=Y5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C789CCA9ED4
	for <linux-mips@archiver.kernel.org>; Tue,  5 Nov 2019 01:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F09217F5
	for <linux-mips@archiver.kernel.org>; Tue,  5 Nov 2019 01:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfKEB0X (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 4 Nov 2019 20:26:23 -0500
Received: from verein.lst.de ([213.95.11.211]:42414 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbfKEB0X (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 4 Nov 2019 20:26:23 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 33FE268BE1; Tue,  5 Nov 2019 02:26:18 +0100 (CET)
Date:   Tue, 5 Nov 2019 02:26:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 20/21] csky: remove ioremap_cache
Message-ID: <20191105012617.GA31847@lst.de>
References: <20191017174554.29840-1-hch@lst.de> <20191017174554.29840-21-hch@lst.de> <CAJF2gTQ_VeBfi1uaafgtp+uA2skq-w2px12ig=5QD1O9J+PgbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQ_VeBfi1uaafgtp+uA2skq-w2px12ig=5QD1O9J+PgbA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon, Oct 21, 2019 at 03:58:28PM +0800, Guo Ren wrote:
> Acked-by: Guo Ren <guoren@kernel.org>

Can you also take a look at the next patch and give me a review?
