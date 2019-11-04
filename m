Return-Path: <SRS0=n3Oa=Y4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D73C47E49
	for <linux-mips@archiver.kernel.org>; Mon,  4 Nov 2019 00:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EC2222CF
	for <linux-mips@archiver.kernel.org>; Mon,  4 Nov 2019 00:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfKDAez (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 3 Nov 2019 19:34:55 -0500
Received: from verein.lst.de ([213.95.11.211]:36126 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbfKDAez (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 3 Nov 2019 19:34:55 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9838568BFE; Mon,  4 Nov 2019 01:34:52 +0100 (CET)
Date:   Mon, 4 Nov 2019 01:34:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [net v2 1/4] net: sgi: ioc3-eth: don't abuse dma_direct_* calls
Message-ID: <20191104003452.GA2585@lst.de>
References: <20191103103433.26826-1-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103103433.26826-1-tbogendoerfer@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Sun, Nov 03, 2019 at 11:34:30AM +0100, Thomas Bogendoerfer wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> dma_direct_ is a low-level API that must never be used by drivers
> directly.  Switch to use the proper DMA API instead.
> 
> Change in v2:
> - ensure that tx ring is 16kB aligned

FYI, I think this should be a separate patch.  The lack of explicitly
alignment was just as broken before this patch as it is now.
