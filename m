Return-Path: <SRS0=Alo4=OT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDF0C04EB8
	for <linux-mips@archiver.kernel.org>; Mon, 10 Dec 2018 11:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0461A20880
	for <linux-mips@archiver.kernel.org>; Mon, 10 Dec 2018 11:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvFWRLjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0461A20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeLJLks (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:40:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40168 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLJLks (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 10 Dec 2018 06:40:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so10818008wmf.5
        for <linux-mips@vger.kernel.org>; Mon, 10 Dec 2018 03:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qmD7jyNre6NQL6PXpsr01qnnabW2A5X7RF5/JoSk2zo=;
        b=JvFWRLjvYaDVCas34T2jG1+blEbOUwZHQaOZlPV63096E85XBVNtaW54mPYqO0fi1f
         Auam36VSszcRO7Z3EK/3kKFkaLt44mQi7kYO7X/z5WCyYkfc5wlstWfiGKlTR62R7gi1
         6N8B5zZSL45sLZ8vbEdqRvIb11DLmNT8hwa/xdPyJzeo+bnTScAv3uXc47ri44ksCT/v
         ApjW7auYP0xRcs0DFI2ciBkSyoJTrfS0Lzc0GHu5GdYEoDgp2mPbo1gNKR0HVOVvwE71
         ZgHYOymUXP1KwsZRrEAnqL2eDD4BXqdjLv5FCse10rX4Ic4+tnYQKcHNxUmlujqVMnT2
         nmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qmD7jyNre6NQL6PXpsr01qnnabW2A5X7RF5/JoSk2zo=;
        b=l7uF3CWgWGH6cLET/0W8iZQEe/L/lD8L2LGDfjq1ma4PRCaXcDbUtJl3EOmbfytGJz
         BuGQDutgbXPXX+nq4xTJnR92q2Z3G1kvSJMWpwJkRJgwbev6r2GtDdCWk9mdPV72tOXV
         1KuLY4GuzsCPxfP7ntI07WbaKGy9wjErNFeP4m73BrVXbBFcOlLmHH5XzEdkkA2mN+qA
         iljJQwqRh/X9+shNSS1s5DaaGdebP39ySj9ub3Ge/011WevPNg6BTO7Y0JM4Ff2bDj19
         T3fPvRvzOuZ1Tpg3daEak4ht/WQIoI/CvQWisHS39a1kT8dH8bxcS/qkfJT6y8XDPhQ/
         JdQw==
X-Gm-Message-State: AA+aEWYTTmN20u3pDnZ7WAo0D8EjOR70j1MetEfJju1DrLZBtfwUvEYa
        ejwUbGQdYaIV7vLsKw0MhgPJ0bhNEeg=
X-Google-Smtp-Source: AFSGD/WjDdQ/YRx9sF54MQeiAybikhVY/dmgDkLXITF8fAfefsZsaLqrSDeJW1F8TpPMRZwDCIxJWg==
X-Received: by 2002:a7b:c04e:: with SMTP id u14mr9380967wmc.133.1544442046526;
        Mon, 10 Dec 2018 03:40:46 -0800 (PST)
Received: from localhost.localdomain ([2001:470:9e39:0:a00:27ff:fe6d:8ad3])
        by smtp.gmail.com with ESMTPSA id k128sm16876150wmd.37.2018.12.10.03.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 03:40:45 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MIPS: BCM63XX: fix switch core reset on BCM6368
Date:   Mon, 10 Dec 2018 12:40:38 +0100
Message-Id: <20181210114038.24162-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The Ethernet Switch core mask was set to 0, causing the switch core to
be not reset on BCM6368 on boot. Provide the proper mask so the switch
core gets reset to a known good state.

Fixes: 799faa626c71 ("MIPS: BCM63XX: add core reset helper")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
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
2.13.2

