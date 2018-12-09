Return-Path: <SRS0=ChUC=OS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618ACC65BAF
	for <linux-mips@archiver.kernel.org>; Sun,  9 Dec 2018 04:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5552081F
	for <linux-mips@archiver.kernel.org>; Sun,  9 Dec 2018 04:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5552081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbeLIE6C (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 8 Dec 2018 23:58:02 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36214 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeLIE6B (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 8 Dec 2018 23:58:01 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E886E141E1419;
        Sat,  8 Dec 2018 20:58:00 -0800 (PST)
Date:   Sat, 08 Dec 2018 20:58:00 -0800 (PST)
Message-Id: <20181208.205800.224315570468859864.davem@davemloft.net>
To:     hch@lst.de
Cc:     iommu@lists.linux-foundation.org, robin.murphy@arm.com,
        vgupta@synopsys.com, matwey@sai.msu.ru,
        laurent.pinchart@ideasonboard.com,
        linux-snps-arc@lists.infradead.org, ezequiel@collabora.com,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, sparclinux@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 5/6] sparc: move the leon PCI memory space comment to
 <asm/leon.h>
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181208174115.16237-6-hch@lst.de>
References: <20181208174115.16237-1-hch@lst.de>
        <20181208174115.16237-6-hch@lst.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 08 Dec 2018 20:58:01 -0800 (PST)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat,  8 Dec 2018 09:41:14 -0800

> It has nothing to do with the content of the pci.h header.
> 
> Suggested by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
