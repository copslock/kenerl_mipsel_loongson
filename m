Return-Path: <SRS0=YN1v=YL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBD4CA9EAB
	for <linux-mips@archiver.kernel.org>; Fri, 18 Oct 2019 22:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5BF21925
	for <linux-mips@archiver.kernel.org>; Fri, 18 Oct 2019 22:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436793;
	bh=DuplhoRQredmAuojEW6TUPC1yPAM/K2dTnu2HW9tcM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sN7gywsuBegZ7zAeN2jfKZrSGhqSK6LrYtmkYxqjSHcfSHSd5CNeQhUDS4uLy7Xo3
	 m4YHU9HaJnbeCu2rIO06uECB/5xesBsEyFls2x8cWvpiB5VseZ+ZP1r9AXh7CN2Vu2
	 fbHSZXXZCJ9xoSjXSx6sKmrVnOLfv67MTb7JU3+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfJRWNE (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389599AbfJRWKD (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 18 Oct 2019 18:10:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 987E92246D;
        Fri, 18 Oct 2019 22:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436602;
        bh=DuplhoRQredmAuojEW6TUPC1yPAM/K2dTnu2HW9tcM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=huokm79ebLYF1QOs1yrVWhFQpxe1f8T7KFVideN4/BmRzRHZxpWKfv4u0BjhvnoXW
         xZmM1VbS3+5KUZahXQMdUdWQT7gXRRxaONaKkdTj32ywjNEHnFvIC73kj2CIDHlWAh
         cFgrDGZY0q90V8pcdHdcPzYnJf33asht3nKAlhOY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH AUTOSEL 4.9 25/29] MIPS: fw: sni: Fix out of bounds init of o32 stack
Date:   Fri, 18 Oct 2019 18:09:16 -0400
Message-Id: <20191018220920.10545-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220920.10545-1-sashal@kernel.org>
References: <20191018220920.10545-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>

[ Upstream commit efcb529694c3b707dc0471b312944337ba16e4dd ]

Use ARRAY_SIZE to caluculate the top of the o32 stack.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/fw/sni/sniprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/fw/sni/sniprom.c b/arch/mips/fw/sni/sniprom.c
index 6aa264b9856ac..7c6151d412bd7 100644
--- a/arch/mips/fw/sni/sniprom.c
+++ b/arch/mips/fw/sni/sniprom.c
@@ -42,7 +42,7 @@
 
 /* O32 stack has to be 8-byte aligned. */
 static u64 o32_stk[4096];
-#define O32_STK	  &o32_stk[sizeof(o32_stk)]
+#define O32_STK	  (&o32_stk[ARRAY_SIZE(o32_stk)])
 
 #define __PROM_O32(fun, arg) fun arg __asm__(#fun); \
 				     __asm__(#fun " = call_o32")
-- 
2.20.1

