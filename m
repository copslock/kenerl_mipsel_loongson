Return-Path: <SRS0=TBB5=WX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89923C3A5A3
	for <linux-mips@archiver.kernel.org>; Tue, 27 Aug 2019 07:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C643217F5
	for <linux-mips@archiver.kernel.org>; Tue, 27 Aug 2019 07:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892308;
	bh=cLlmmAGCVwDgnENcAsbB4Ldr9YL25YNv2N8nZLv1Zok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pCTK94gx14lZRVFh0L9cRDRLZM+dvKZaxUtP9PW+HdjUMCs6bm9lNddGT55u+jkg8
	 RYibn8WirkBXH+JIi8d2KEtk7pOGnwBiUPjqN31e51YnMHbMGuUfgD69jdiBDhEr2+
	 NQbajtQDRIMsf43OxtliMIcQWk1aKb2+ESLQaBEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfH0Hvo (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfH0Hvo (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 27 Aug 2019 03:51:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C55522173E;
        Tue, 27 Aug 2019 07:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892303;
        bh=cLlmmAGCVwDgnENcAsbB4Ldr9YL25YNv2N8nZLv1Zok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BfDcKYQ7fHluCqq4r7dvR4+jC7cpQ9HOEAuHPzQbEjS5rXRrL83u1DPjz2NuOXvP5
         z0OPUSWYIWL6xu00vVHveyie5Hz4HOL09rzFIK4x7zTn5MUw/L7l0jf7g28VdMLCOb
         yihp5TRFflhWF3oBd+ExjFECb1VH6JMMKDaR9X7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 02/62] MIPS: kernel: only use i8253 clocksource with periodic clockevent
Date:   Tue, 27 Aug 2019 09:50:07 +0200
Message-Id: <20190827072700.174800517@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072659.803647352@linuxfoundation.org>
References: <20190827072659.803647352@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

[ Upstream commit a07e3324538a989b7cdbf2c679be6a7f9df2544f ]

i8253 clocksource needs a free running timer. This could only
be used, if i8253 clockevent is set up as periodic.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/i8253.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/i8253.c b/arch/mips/kernel/i8253.c
index 5f209f111e59e..df7ddd246eaac 100644
--- a/arch/mips/kernel/i8253.c
+++ b/arch/mips/kernel/i8253.c
@@ -32,7 +32,8 @@ void __init setup_pit_timer(void)
 
 static int __init init_pit_clocksource(void)
 {
-	if (num_possible_cpus() > 1) /* PIT does not scale! */
+	if (num_possible_cpus() > 1 || /* PIT does not scale! */
+	    !clockevent_state_periodic(&i8253_clockevent))
 		return 0;
 
 	return clocksource_i8253_init();
-- 
2.20.1



