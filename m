Return-Path: <SRS0=Alo4=OT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55B1C04EB8
	for <linux-mips@archiver.kernel.org>; Mon, 10 Dec 2018 18:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E61D20672
	for <linux-mips@archiver.kernel.org>; Mon, 10 Dec 2018 18:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E61D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeLJSKl (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:10:41 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41356 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbeLJSKl (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 10 Dec 2018 13:10:41 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1441914732B3E;
        Mon, 10 Dec 2018 10:10:40 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:10:39 -0800 (PST)
Message-Id: <20181210.101039.1882227517259366533.davem@davemloft.net>
To:     hch@lst.de
Cc:     iommu@lists.linux-foundation.org, robin.murphy@arm.com,
        vgupta@synopsys.com, matwey@sai.msu.ru,
        laurent.pinchart@ideasonboard.com,
        linux-snps-arc@lists.infradead.org, ezequiel@collabora.com,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, sparclinux@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 6/6] sparc: merge 32-bit and 64-bit version of pci.h
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181210163256.GA27331@lst.de>
References: <20181208174115.16237-7-hch@lst.de>
        <20181208.205806.42785512174962944.davem@davemloft.net>
        <20181210163256.GA27331@lst.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 10 Dec 2018 10:10:40 -0800 (PST)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 10 Dec 2018 17:32:56 +0100

> Dave, can you pick the series up through the sparc tree?  I could also
> merge it through the dma-mapping tree, but given that there is no
> dependency on it the sparc tree seem like the better fit.

I thought that some of this is a prerequisite for the DMA mapping
work and overall consolidation you are doing.  So I kinda assumed
you wanted to merge it via your tree.

I anticipate no conflicts at all, even until the next merge window,
so it could very easily go through your tree.

Let me know if you still want me to merge this.

Thanks.
