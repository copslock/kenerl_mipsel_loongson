Return-Path: <SRS0=+ky4=QI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4376CC282D8
	for <linux-mips@archiver.kernel.org>; Fri,  1 Feb 2019 08:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C195218A6
	for <linux-mips@archiver.kernel.org>; Fri,  1 Feb 2019 08:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pKNpt8ch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfBAIsi (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:48:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48488 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfBAIsi (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 1 Feb 2019 03:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ryF7wEYM+8TnYcdpcL53ItqAkETjJcf7kzT/imJeFkI=; b=pKNpt8ch3VuAp/lHtycoPyxJtu
        Z76Am5nGRDzsghgCY8qRnw/8FlWusijSVpRzgz8SsWfG4t0HNxftHi5jmIUfoYWaYgKhvGvGvgta5
        CfTaDW/UGcdVqryCW2k81UZzHdNt/t6owf5kCDBe7ov2Ud6QSQ3imBRY/r8iPNw5bGkzW7lxLXiyN
        2B/C70ZeNkV2GmApvZG2TgWl5kLFadNKz84zxy90MQ186LnxdLEl65DzXJkZu3U2gaezeoV1Vr5hr
        aYZyMeWg0We0NLbTPje+6wFhleGUPKxWi5Fb2qt7xYdyT0hw0LgObmmH9Cxd/MgjdmFMQMaWU9ZMS
        3+5treHw==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpUV0-0001Sc-GO; Fri, 01 Feb 2019 08:48:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     iommu@lists.linux-foundation.org
Subject: [PATCH 12/18] fotg210-udc: remove a bogus dma_sync_single_for_device call
Date:   Fri,  1 Feb 2019 09:47:55 +0100
Message-Id: <20190201084801.10983-13-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201084801.10983-1-hch@lst.de>
References: <20190201084801.10983-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

dma_map_single already transfers ownership to the device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/gadget/udc/fotg210-udc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/fotg210-udc.c b/drivers/usb/gadget/udc/fotg210-udc.c
index bc6abaea907d..fe9cf415f2f1 100644
--- a/drivers/usb/gadget/udc/fotg210-udc.c
+++ b/drivers/usb/gadget/udc/fotg210-udc.c
@@ -356,10 +356,6 @@ static void fotg210_start_dma(struct fotg210_ep *ep,
 		return;
 	}
 
-	dma_sync_single_for_device(NULL, d, length,
-				   ep->dir_in ? DMA_TO_DEVICE :
-					DMA_FROM_DEVICE);
-
 	fotg210_enable_dma(ep, d, length);
 
 	/* check if dma is done */
-- 
2.20.1

