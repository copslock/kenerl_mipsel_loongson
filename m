Return-Path: <SRS0=eOpe=YY=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE60CA9ECB
	for <linux-mips@archiver.kernel.org>; Thu, 31 Oct 2019 19:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4572080F
	for <linux-mips@archiver.kernel.org>; Thu, 31 Oct 2019 19:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfJaTPr (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 31 Oct 2019 15:15:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59606 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbfJaTPr (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 31 Oct 2019 15:15:47 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 856AA14F9AF54;
        Thu, 31 Oct 2019 12:15:46 -0700 (PDT)
Date:   Thu, 31 Oct 2019 12:15:46 -0700 (PDT)
Message-Id: <20191031.121546.1075325111948179622.davem@davemloft.net>
To:     tbogendoerfer@suse.de
Cc:     hch@lst.de, linux-mips@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] net: sgi: ioc3-eth: don't abuse dma_direct_* calls
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191031161817.b24181a2e7af3df994eec6c5@suse.de>
References: <20191031095430.148daca03517c00f3e2b32ff@suse.de>
        <20191031131501.GA4361@lst.de>
        <20191031161817.b24181a2e7af3df994eec6c5@suse.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 31 Oct 2019 12:15:46 -0700 (PDT)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Date: Thu, 31 Oct 2019 16:18:17 +0100

> On Thu, 31 Oct 2019 14:15:01 +0100
> Christoph Hellwig <hch@lst.de> wrote:
> 
>> On Thu, Oct 31, 2019 at 09:54:30AM +0100, Thomas Bogendoerfer wrote:
>> > I didn't want to argue about that. What I'm interested in is a way how 
>> > to allocate dma memory, which is 16kB aligned, via the DMA API ?
>> 
>> You can't.
> 
> So then __get_free_pages() and dma_map_page() is the only way ?
> 
> BTW I've successful tested your patches on an 8 CPU Origin 2k.

Nope, it is not the only way.

Allocate a (SIZE*2)-1 sized piece of DMA memory and align the
resulting CPU pointer and DMA address as needed.
