Return-Path: <SRS0=xtk4=UC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31618C04AB6
	for <linux-mips@archiver.kernel.org>; Mon,  3 Jun 2019 06:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24F9250D6
	for <linux-mips@archiver.kernel.org>; Mon,  3 Jun 2019 06:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GZoDqhYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfFCGx3 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:53:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51614 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfFCGx3 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 3 Jun 2019 02:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k1Y72xAeyNQVGy9ylmCGgXDESvm5qgLMBgCfXm7Ynkg=; b=GZoDqhYFhv5g1uAHC5JnRv239
        ZMRLSrun0b20rFY7TlkmLMxFsdjGFYRdViecZ9Sy7z6SP5t9sZOtcJ+TdXPBq7Mk28fdFGc4W4MSH
        UXbnE1fatuw6apfWRA1cwrJYv00rj0fUeY9Mo3zsE/VTkojoSlyz+8BpO64knBfnUpE5sRdicLhFb
        erP4rZZNQZx382ZEUQh7flR5dchAQgl5mLJktiyB/TzJd6Bn4b+AkQhhyceeSZU7iZY20Vz9PzwD7
        SA78IjF4Wu3S4jfDGGqx7ufSAZBDPsoJ04gHaZBls1Zdoy3lz6q55jp9EF431FTjS4+KIKu/Hh19i
        X3oIM3WtQ==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hXgqV-00064i-D9; Mon, 03 Jun 2019 06:53:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ley Foon Tan <lftan@altera.com>, Michal Simek <monstr@monstr.eu>
Cc:     linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: switch nios2 and microblaze to use the generic uncached segement support
Date:   Mon,  3 Jun 2019 08:53:22 +0200
Message-Id: <20190603065324.9724-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi all,

can you take a look at this series?  It switches niops2 and microblaze to
use the generic dma layer support for uncached segements.

The dma mapping for-next git tree that includes the support is available
here:

    git://git.infradead.org/users/hch/dma-mapping.git for-next

Gitweb:

    http://git.infradead.org/users/hch/dma-mapping.git/shortlog/refs/heads/for-next
