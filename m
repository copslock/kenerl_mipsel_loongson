Return-Path: <SRS0=YN1v=YL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4614CA9EA0
	for <linux-mips@archiver.kernel.org>; Fri, 18 Oct 2019 22:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE85222D4
	for <linux-mips@archiver.kernel.org>; Fri, 18 Oct 2019 22:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437541;
	bh=aegePsCGy2VO/H5hhQQ8jO5KqxsWMEzetylC96FYYSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hhi7Wi3561eTLMxhnd/7FJDHyrxFnjL+mvNAcRDqLAslCrPKQsZv5g8eXAadO7M8b
	 35aASzroH54ireaWrZ9rsG03W6KZ6e2fx2sNlMLH7QmMrqmbyZ9PWJCEsBwRs+lbYj
	 NJ5s7pm9ITkrbSlGMgtO2uajTHxJvESx+n0Jsxn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfJRWEd (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbfJRWEd (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 18 Oct 2019 18:04:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D80B222C6;
        Fri, 18 Oct 2019 22:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436272;
        bh=aegePsCGy2VO/H5hhQQ8jO5KqxsWMEzetylC96FYYSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kCV92dt+PWwTaQ1LW2JVAmVug0qJ3I7xhWReUFIV08buFa2TouvaodaWY4Qze0RMY
         JwbgQyb2vnzR8hOhWsKNxztrx9MhlEmU8zlAcXXyY+7wXJu/VVWakemsm5xI869Rwd
         jWYZsGjLrwbhbUXwXe7pfjanYAopA1/jNufKJoug=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH AUTOSEL 5.3 51/89] MIPS: include: Mark __cmpxchg as __always_inline
Date:   Fri, 18 Oct 2019 18:02:46 -0400
Message-Id: <20191018220324.8165-51-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220324.8165-1-sashal@kernel.org>
References: <20191018220324.8165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>

[ Upstream commit 88356d09904bc606182c625575237269aeece22e ]

Commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
forcibly") allows compiler to uninline functions marked as 'inline'.
In cace of cmpxchg this would cause to reference function
__cmpxchg_called_with_bad_pointer, which is a error case
for catching bugs and will not happen for correct code, if
__cmpxchg is inlined.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
[paul.burton@mips.com: s/__cmpxchd/__cmpxchg in subject]
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/cmpxchg.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index c8a47d18f6288..319522fa3a45e 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -153,8 +153,9 @@ static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
 extern unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
 				     unsigned long new, unsigned int size);
 
-static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
-				      unsigned long new, unsigned int size)
+static __always_inline
+unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
+			unsigned long new, unsigned int size)
 {
 	switch (size) {
 	case 1:
-- 
2.20.1

