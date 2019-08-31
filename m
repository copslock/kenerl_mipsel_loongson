Return-Path: <SRS0=Nkoz=W3=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0D6C3A5A6
	for <linux-mips@archiver.kernel.org>; Sat, 31 Aug 2019 16:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001C922DA9
	for <linux-mips@archiver.kernel.org>; Sat, 31 Aug 2019 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567268991;
	bh=oCFqDXfnxrqpiBFRCwyD8nHXvoMvSjbxCsJhrxHTYqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1kaPfabB35snmMl0w12UNCiIkpBEGMal+Zv0edTHpZWMq5NXkxJWxA8fwbGcijkQ4
	 1KdDIJyGUIYaqINxsBb5r7dvegN+BCXGHR8/VwPzMx7q3mp0wdUEffwveEiA/ouBlY
	 7DM7BoYKeskFkVaPXPEImAjvWV9BA6GCHH+P1aQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfHaQ3r (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 31 Aug 2019 12:29:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbfHaQ3q (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sat, 31 Aug 2019 12:29:46 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2253522D37;
        Sat, 31 Aug 2019 16:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567268985;
        bh=oCFqDXfnxrqpiBFRCwyD8nHXvoMvSjbxCsJhrxHTYqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vX6b95IdsVrDjTXh55KZNhoPNMKUITWlit4Ldb9kHZhxWpNoqZwiOB5EF5DJcLfuZ
         wmt8nfF1pggofVEAUJWY4K2cI3w83kg0ds8vBO0zGI/+b8iJT5NQEI4dH3G3L57NyD
         AwNlHxXQFvARoZXdkRSB9gHwMtmjWPnHQrjl8Gx4=
Date:   Sat, 31 Aug 2019 17:29:38 +0100
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
Message-ID: <20190831162937.5ybulvaa4eq7mybs@willie-the-truck>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-20-hch@lst.de>
 <20190819073601.4yxjvmyjtpi7tk56@willie-the-truck>
 <20190830160515.GC26887@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830160515.GC26887@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Christoph,

On Fri, Aug 30, 2019 at 06:05:15PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 19, 2019 at 08:36:02AM +0100, Will Deacon wrote:
> > On Sat, Aug 17, 2019 at 09:32:46AM +0200, Christoph Hellwig wrote:
> > > No need to indirect iounmap for arm64.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  arch/arm64/include/asm/io.h | 3 +--
> > >  arch/arm64/mm/ioremap.c     | 4 ++--
> > >  2 files changed, 3 insertions(+), 4 deletions(-)
> > 
> > Not sure why we did it like this...
> > 
> > Acked-by: Will Deacon <will@kernel.org>
> 
> Can you just pick this one up through the arm64 tree for 5.4?

Unfortunately, it doesn't apply because the tree you've based it on has
removed ioremap_wt(). If you send a version based on mainline, I can
queue it.

Cheers,

Will
