Return-Path: <SRS0=hzgf=TZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1FCC282CE
	for <linux-mips@archiver.kernel.org>; Sat, 25 May 2019 13:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D0B20863
	for <linux-mips@archiver.kernel.org>; Sat, 25 May 2019 13:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qMmTNCLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfEYNcR (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 25 May 2019 09:32:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfEYNcR (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 25 May 2019 09:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fclx2EkLgGZXMWSnoaUIWWcWHkhmXZk15XX3q1+NpkY=; b=qMmTNCLA+cd0wrgFY7M1IdfhH
        a7UH0ogu20h1J5SiJ/CDdmDVN9+6plSUgOdLtw3s3GA2P9KXe6LQZlEXEKL0WcNscFuhnXCdw2lxO
        VuHb5eNnQXbvfmNnQUqHuEmqKzqRxazORsOaeMyDwmRz5w9p3gMNhCdrtTJ4VLUohQnwaiDFp1Qsv
        XFRTyZ3rwPRms3QA30d7IAPD/xQIcNt9mcpAZSyEVPZA+e3w2S28DBaUJrnQVYVIthXWpPO2fQy8i
        uQ1Z5oaqOxJXFLu3lOo+SJMMZQNl9Yl23YrszkAJElJUuHdqZlRJdv2gxlf3DCUZk3fInV7so85zJ
        WqCevvc0g==;
Received: from 213-225-10-46.nat.highway.a1.net ([213.225.10.46] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hUWmM-0006Xn-Vj; Sat, 25 May 2019 13:32:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-mips@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: RFC: switch the remaining architectures to use generic GUP
Date:   Sat, 25 May 2019 15:31:57 +0200
Message-Id: <20190525133203.25853-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Linus and maintainers,

below is a series to switch mips, sh and sparc64 to use the generic
GUP code so that we only have one codebase to touch for further
improvements to this code.  I don't have hardware for any of these
architectures, and generally no clue about their page table
management, so handle with care.  But it at least survives a
basic defconfig compile test..
