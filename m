Return-Path: <SRS0=T/5f=XY=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7B6C4360C
	for <linux-mips@archiver.kernel.org>; Sun, 29 Sep 2019 17:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654772086A
	for <linux-mips@archiver.kernel.org>; Sun, 29 Sep 2019 17:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569779002;
	bh=6U12gjLd5+hWTbCP6kB3SDmu7dkXEuPqe6BNUcEyDwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pYqLHEu2E4AJ4XFUe1G5G0C2l2Hmuko1FcDmx0mGmOwF4/wBjS+pOemTa3KywMQQy
	 knM+LZQm+sHgyKT+UgV5ycPnseNIPMZhpdGsDyib6KwBSLb/91g7ZCvyGMARMrLUeh
	 LfnX44F5AmcZ/gd08EXr/sojnr3wvZzvICgo+rh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfI2Rbl (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 29 Sep 2019 13:31:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbfI2Rbk (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 29 Sep 2019 13:31:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0CA921924;
        Sun, 29 Sep 2019 17:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569778299;
        bh=6U12gjLd5+hWTbCP6kB3SDmu7dkXEuPqe6BNUcEyDwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCfJGgmwcimX2Z9hICl4zWNdOXdLoU41l0brXB5+jx4yMdmjRP86/fhDw/NWb/ybm
         mwerE5uInU1MrycVHP4pB5hvdPVe1cWo0tnFjn7a9tmm37rcRYG82Huik2XwFXL5Or
         opvy9KsYVKgokjVPBpRCy5U1/2kpltWtO2CNhB8A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        joe@perches.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 20/49] firmware: bcm47xx_nvram: Correct size_t printf format
Date:   Sun, 29 Sep 2019 13:30:20 -0400
Message-Id: <20190929173053.8400-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190929173053.8400-1-sashal@kernel.org>
References: <20190929173053.8400-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit feb4eb060c3aecc3c5076bebe699cd09f1133c41 ]

When building on a 64-bit host, we will get warnings like those:

drivers/firmware/broadcom/bcm47xx_nvram.c:103:3: note: in expansion of macro 'pr_err'
   pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
   ^~~~~~
drivers/firmware/broadcom/bcm47xx_nvram.c:103:28: note: format string is defined here
   pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
                           ~^
                           %li

Use %zu instead for that purpose.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@linux-mips.org
Cc: joe@perches.com
Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/broadcom/bcm47xx_nvram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/broadcom/bcm47xx_nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
index 77eb74666ecbc..6d2820f6aca13 100644
--- a/drivers/firmware/broadcom/bcm47xx_nvram.c
+++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
@@ -96,7 +96,7 @@ static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
 		nvram_len = size;
 	}
 	if (nvram_len >= NVRAM_SPACE) {
-		pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
+		pr_err("nvram on flash (%zu bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
 		       nvram_len, NVRAM_SPACE - 1);
 		nvram_len = NVRAM_SPACE - 1;
 	}
@@ -148,7 +148,7 @@ static int nvram_init(void)
 	    header.len > sizeof(header)) {
 		nvram_len = header.len;
 		if (nvram_len >= NVRAM_SPACE) {
-			pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
+			pr_err("nvram on flash (%zu bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
 				header.len, NVRAM_SPACE);
 			nvram_len = NVRAM_SPACE - 1;
 		}
-- 
2.20.1

