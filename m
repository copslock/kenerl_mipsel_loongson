Return-Path: <SRS0=n3Oa=Y4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B9DCA9ED3
	for <linux-mips@archiver.kernel.org>; Mon,  4 Nov 2019 21:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814A621929
	for <linux-mips@archiver.kernel.org>; Mon,  4 Nov 2019 21:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904563;
	bh=WEjXPYN/4z2tLd11WOkLYZH11e/S5V8qQlTCbEuf090=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wXReqbndf38WPKJKzoR/3wBiIYZHh6kCwIagDgz63PJ9GdXCtOJkL3I5hxCFM/ccK
	 lQojCBSHtGaN21KCSn3bIqIls21P3zlt50dX7f7Fu9zQThV0f71/uiTo9hmZUt2yA8
	 wtmaaUIz3ClvaICe+w9Dp5sXPjMfNdGoBxrHYmHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbfKDV4C (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:56:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:51432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388243AbfKDV4A (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 4 Nov 2019 16:56:00 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 971B72053B;
        Mon,  4 Nov 2019 21:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904559;
        bh=WEjXPYN/4z2tLd11WOkLYZH11e/S5V8qQlTCbEuf090=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=opCVYteknBXJSKCnUKH+LYL9AKMJKjH2+5VbcZg0SwP+7w4JSmLP2ErQbEDLx8Yu9
         xzNst+hu+dwYTi1Q5dsopUTw5T2ukSjqof3EpzdZoHBZQkRyjuipC5PSXy9ZWj4Y2h
         c4VoyCwNHzUMdclOndauH368zfqSdfHGZJohY3gY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 51/95] MIPS: include: Mark __xchg as __always_inline
Date:   Mon,  4 Nov 2019 22:44:49 +0100
Message-Id: <20191104212104.338498240@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212038.056365853@linuxfoundation.org>
References: <20191104212038.056365853@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>

[ Upstream commit 46f1619500d022501a4f0389f9f4c349ab46bb86 ]

Commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
forcibly") allows compiler to uninline functions marked as 'inline'.
In cace of __xchg this would cause to reference function
__xchg_called_with_bad_pointer, which is an error case
for catching bugs and will not happen for correct code, if
__xchg is inlined.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/cmpxchg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index 895f91b9e89c3..520ca166cbed5 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -73,8 +73,8 @@ extern unsigned long __xchg_called_with_bad_pointer(void)
 extern unsigned long __xchg_small(volatile void *ptr, unsigned long val,
 				  unsigned int size);
 
-static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
-				   int size)
+static __always_inline
+unsigned long __xchg(volatile void *ptr, unsigned long x, int size)
 {
 	switch (size) {
 	case 1:
-- 
2.20.1



