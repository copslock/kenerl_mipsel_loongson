Return-Path: <SRS0=VLT5=ZF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A904C43331
	for <linux-mips@archiver.kernel.org>; Wed, 13 Nov 2019 07:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6040121A49
	for <linux-mips@archiver.kernel.org>; Wed, 13 Nov 2019 07:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LNJe/uLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfKMHfp (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:35:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfKMHfp (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 13 Nov 2019 02:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w81mLVUH+kMl9z6rXix29An8Vg8TBtLdHfGE4Bvr4U4=; b=LNJe/uLKQVyS9Bl6y6WwQp5oe
        rhYUV2JjoHfm8Y5vvtdVw3uuUUxyIYoGg2IWK26uCNzAqi6g57t56VPwIxwsMGQBqx8VqFL8V6Frr
        OJC0Ba7f/yBpt8Qby5mUwovEb0bUBAlw22lMChaSQX0p4DEqZaeBMnhWhxuUfjsxssoUvamG5bCHw
        zxBuhf1aIE7JzBYE0GAAnIsDD/zUyrBueFev/R3Yxf1NxsA2Dm013QJsCkmUFHCBzQrSpVxbzk7wn
        VS9uspp0SIGqdalmN6Ja4MCsTI/0ufcwEXnrE/DGsE1rzXx8wu+z5sasokmTRIT8B0A5wK955MQyr
        gQX+azQ4g==;
Received: from [2001:4bb8:180:3806:c70:4a89:bc61:5] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUnBl-0008RU-Nm; Wed, 13 Nov 2019 07:35:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: unify the dma_capable definition
Date:   Wed, 13 Nov 2019 08:35:36 +0100
Message-Id: <20191113073539.9660-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi all,

there is no good reason to have different version of dma_capable.
This series removes the arch overrides and also adds a few cleanups
in the same area.
