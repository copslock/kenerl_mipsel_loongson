Return-Path: <SRS0=NRRR=QZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C23C43381
	for <linux-mips@archiver.kernel.org>; Mon, 18 Feb 2019 12:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44ED521479
	for <linux-mips@archiver.kernel.org>; Mon, 18 Feb 2019 12:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hx1wjV+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfBRMaU (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:30:20 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39674 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbfBRMaU (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 18 Feb 2019 07:30:20 -0500
Received: by mail-yb1-f196.google.com with SMTP id s5so6680277ybp.6
        for <linux-mips@vger.kernel.org>; Mon, 18 Feb 2019 04:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ateX3s8gpfmkf/nVro5ijlmm4WUX31nTOLg9tsTAyHo=;
        b=Hx1wjV+im/r8g4D1bp3S1D5jpGoQGj7HvHwpejDBhO/CkXGx+488gncYSBSpGNSARm
         iyTtVcc3KgVZaLfunUua9UODmwMPXQnFIRm8hl9EVyEh8QHXmQBzsdp1Z/CBoOPeaoSV
         ikin1xwyzeDLAkn4CXt3ISvrrC9oQ4MFt5ZqQvfTYSTYah6G8iIsRMK35MQQN9CKqqtP
         ekeKHjxRHUN/JwIAHKBcbEldy8+1U9naKLok9pywoHknJNboUZAjo1VQUTYjxYxuA2K/
         o6L+DI/PyfOHSh1Zd1/haa40AGy3gMtSNoSNf89t33VGN6ZH+Kbn1/slGAk0GH0hxm+W
         LHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ateX3s8gpfmkf/nVro5ijlmm4WUX31nTOLg9tsTAyHo=;
        b=VdC1xE75AxXKUNiYUzqRjtD7IYcOD7wVC2pwTof5SkXcPRoQTFtS9uC7f82sr+9RhQ
         u4XTlUMZWMozZmJvtMLi2Ae/OE6ECFLmF3h2/I85HtOtRb1KmsSIvKbptoo8rifQqj3n
         A3hdzvZ8TP32lpFt3SkoAtiYFh9LQSFxyAVbKHyD/iIaXw+vVbijnBWsodRuQqk/WF0u
         encwrKBIG9nUX82rgqBmm1tJ8dIF5KxvXSaVPiHgAjhxhWjKftVApOV6ZF3fNAEmUCay
         9Pv8OARKfiz1tZ9VaUr8EAiU8WJP8YS8pOFdceeQ1VdFwRaNoAy5VyqNMJJdk4oXZU3g
         /Fyg==
X-Gm-Message-State: AHQUAub17YYtgyqn0vM6WPW0IueolmVbhdDOOvRTv6WlGhohnZJVyo9B
        U9Euf7dytsa+G+dsFiiWIXjloQ==
X-Google-Smtp-Source: AHgI3IZ0ikGflQzpigdpSjHwCFVf8oIyLZ31XectcfYiTm+tuEa6KV4uTlhpgVb9eX96Xd31K9dlAg==
X-Received: by 2002:a25:be85:: with SMTP id i5mr18703799ybk.134.1550493019787;
        Mon, 18 Feb 2019 04:30:19 -0800 (PST)
Received: from localhost.localdomain ([106.51.22.126])
        by smtp.gmail.com with ESMTPSA id z77sm1663695ywz.91.2019.02.18.04.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Feb 2019 04:30:19 -0800 (PST)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Stable <stable@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH for-3.18.y+] MIPS: BCM63XX: fix switch core reset on BCM6368
Date:   Mon, 18 Feb 2019 18:00:10 +0530
Message-Id: <1550493012-5959-1-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Jonas Gorski <jonas.gorski@gmail.com>

commit 8a38dacf87180738d42b058334c951eba15d2d47 upstream.

The Ethernet Switch core mask was set to 0, causing the switch core to
be not reset on BCM6368 on boot. Provide the proper mask so the switch
core gets reset to a known good state.

Fixes: 799faa626c71 ("MIPS: BCM63XX: add core reset helper")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
Cherry-picked from lede tree https://git.lede-project.org/?p=source.git
and build tested for LTS trees up to v4.19.y for ARCH=mips bcm63xx_defconfig.

 arch/mips/bcm63xx/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/bcm63xx/reset.c b/arch/mips/bcm63xx/reset.c
index a2af38cf28a7..64574e74cb23 100644
--- a/arch/mips/bcm63xx/reset.c
+++ b/arch/mips/bcm63xx/reset.c
@@ -120,7 +120,7 @@
 #define BCM6368_RESET_DSL	0
 #define BCM6368_RESET_SAR	SOFTRESET_6368_SAR_MASK
 #define BCM6368_RESET_EPHY	SOFTRESET_6368_EPHY_MASK
-#define BCM6368_RESET_ENETSW	0
+#define BCM6368_RESET_ENETSW	SOFTRESET_6368_ENETSW_MASK
 #define BCM6368_RESET_PCM	SOFTRESET_6368_PCM_MASK
 #define BCM6368_RESET_MPI	SOFTRESET_6368_MPI_MASK
 #define BCM6368_RESET_PCIE	0
-- 
2.7.4

