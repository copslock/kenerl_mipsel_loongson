Return-Path: <SRS0=Alo4=OT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A236C5CFFE
	for <linux-mips@archiver.kernel.org>; Mon, 10 Dec 2018 16:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1882082F
	for <linux-mips@archiver.kernel.org>; Mon, 10 Dec 2018 16:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1882082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeLJQc6 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:32:58 -0500
Received: from verein.lst.de ([213.95.11.211]:49769 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbeLJQc6 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 10 Dec 2018 11:32:58 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7F3376732D; Mon, 10 Dec 2018 17:32:56 +0100 (CET)
Date:   Mon, 10 Dec 2018 17:32:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Miller <davem@davemloft.net>
Cc:     hch@lst.de, iommu@lists.linux-foundation.org, robin.murphy@arm.com,
        vgupta@synopsys.com, matwey@sai.msu.ru,
        laurent.pinchart@ideasonboard.com,
        linux-snps-arc@lists.infradead.org, ezequiel@collabora.com,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, sparclinux@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 6/6] sparc: merge 32-bit and 64-bit version of pci.h
Message-ID: <20181210163256.GA27331@lst.de>
References: <20181208174115.16237-1-hch@lst.de> <20181208174115.16237-7-hch@lst.de> <20181208.205806.42785512174962944.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208.205806.42785512174962944.davem@davemloft.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Dave, can you pick the series up through the sparc tree?  I could also
merge it through the dma-mapping tree, but given that there is no
dependency on it the sparc tree seem like the better fit.
