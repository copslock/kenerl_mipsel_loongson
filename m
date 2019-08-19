Return-Path: <SRS0=C2k9=WP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EE9C3A59D
	for <linux-mips@archiver.kernel.org>; Mon, 19 Aug 2019 07:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B92F21852
	for <linux-mips@archiver.kernel.org>; Mon, 19 Aug 2019 07:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566200174;
	bh=kEBAsv6X4r+CES0f8/n93x03kus6b78gzWZGhEXZpw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZtWyAZI3XbYnbm6zTHd5mXQ/e2C6jlXOlikzGcVlJcmzKlQt17fZQIQPyNb0vi7vc
	 DzrTtzH8skpvsNUZpT5HBtv4jaaoCE3z02QyMbt5+q+n6FqhS2g9XegRz1lalWGQxO
	 trQbNwRUPBruLivFAiVWeP3APQs2kWA1yrk9DMFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfHSHgK (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:36:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHSHgK (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 19 Aug 2019 03:36:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2608C2086C;
        Mon, 19 Aug 2019 07:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566200169;
        bh=kEBAsv6X4r+CES0f8/n93x03kus6b78gzWZGhEXZpw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZN3P1/69MIOg2B81SBINNz+rGfKhZFusbOaGyLqQb9Blsv2mSti1MWTsa90w0MESp
         jadhaU0lZuPw9eWpwjH+XOFMUB/Sje+alD+6KyK2Fb4eskV8ocTyIHvbtygC57mPxu
         nNYqk608qsL0SWijHJgztgoabuo0beTwpG+bcwSU=
Date:   Mon, 19 Aug 2019 08:36:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
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
        linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/26] arm64: remove __iounmap
Message-ID: <20190819073601.4yxjvmyjtpi7tk56@willie-the-truck>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-20-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817073253.27819-20-hch@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Sat, Aug 17, 2019 at 09:32:46AM +0200, Christoph Hellwig wrote:
> No need to indirect iounmap for arm64.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/include/asm/io.h | 3 +--
>  arch/arm64/mm/ioremap.c     | 4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)

Not sure why we did it like this...

Acked-by: Will Deacon <will@kernel.org>

Will
