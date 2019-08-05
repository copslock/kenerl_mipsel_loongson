Return-Path: <SRS0=kII9=WB=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D4BC0650F
	for <linux-mips@archiver.kernel.org>; Mon,  5 Aug 2019 13:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D9921738
	for <linux-mips@archiver.kernel.org>; Mon,  5 Aug 2019 13:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565010476;
	bh=f1WaR3tSARaSVDFRiJ7S+mftWy4gyhuDPSgOpNyxiVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YmwAfjW/HzKDdElzTGSqI7tFlGTbJ81h460NFL2GWkVp6kYITxSFDeY7qyAm9KE8Q
	 B3/efR4EECknWh2G8fgMI/sltDanzsj1r5AFqbcjV9vlVA3btvUG8dcgxlQK97vukl
	 Eofl7Nq9OvxmwqHfuHhcMqCnFeVGeY07TGviopVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfHENHz (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729406AbfHENHy (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 5 Aug 2019 09:07:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E7692173B;
        Mon,  5 Aug 2019 13:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010473;
        bh=f1WaR3tSARaSVDFRiJ7S+mftWy4gyhuDPSgOpNyxiVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=le+FelzZHl1hkT1N3Vaou330SMuARsvFI97bV7OOqsGJ+xBJ/wiBlxn5RC7FY59dx
         UuuVGouMnzpMmmAYAH92KXuP7+hyYoJaZkwSTNyXQMC12yQWCizzkkF9N5+YnmdyqC
         wrNNrcQfJFILFS401zFzvZDw2UaS2JmZIqwPex1U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Cvek <petrcvekcz@gmail.com>,
        Paul Burton <paul.burton@mips.com>, hauke@hauke-m.de,
        john@phrozen.org, linux-mips@vger.kernel.org,
        openwrt-devel@lists.openwrt.org, pakahmar@hotmail.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 07/53] MIPS: lantiq: Fix bitfield masking
Date:   Mon,  5 Aug 2019 15:02:32 +0200
Message-Id: <20190805124928.840395937@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124927.973499541@linuxfoundation.org>
References: <20190805124927.973499541@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

[ Upstream commit ba1bc0fcdeaf3bf583c1517bd2e3e29cf223c969 ]

The modification of EXIN register doesn't clean the bitfield before
the writing of a new value. After a few modifications the bitfield would
accumulate only '1's.

Signed-off-by: Petr Cvek <petrcvekcz@gmail.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: hauke@hauke-m.de
Cc: john@phrozen.org
Cc: linux-mips@vger.kernel.org
Cc: openwrt-devel@lists.openwrt.org
Cc: pakahmar@hotmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/lantiq/irq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index c4ef1c31e0c4f..37caeadb2964c 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -156,8 +156,9 @@ static int ltq_eiu_settype(struct irq_data *d, unsigned int type)
 			if (edge)
 				irq_set_handler(d->hwirq, handle_edge_irq);
 
-			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_C) |
-				(val << (i * 4)), LTQ_EIU_EXIN_C);
+			ltq_eiu_w32((ltq_eiu_r32(LTQ_EIU_EXIN_C) &
+				    (~(7 << (i * 4)))) | (val << (i * 4)),
+				    LTQ_EIU_EXIN_C);
 		}
 	}
 
-- 
2.20.1



