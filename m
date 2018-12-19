Return-Path: <SRS0=x683=O4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F5FC43612
	for <linux-mips@archiver.kernel.org>; Wed, 19 Dec 2018 07:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635B421852
	for <linux-mips@archiver.kernel.org>; Wed, 19 Dec 2018 07:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCpeU/a4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeLSHIJ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:08:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46428 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeLSHII (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 19 Dec 2018 02:08:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so18278534wrt.13
        for <linux-mips@vger.kernel.org>; Tue, 18 Dec 2018 23:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZ7uNN0k2yuA/9SO4H7LdBx/F2uaTpjMn1JCveqGhDQ=;
        b=YCpeU/a4SPcjJONZBxgahSGo6+/0jCnaELdltjBY2VCacwRHeXvQmXp2x08WpRJ9r5
         PC2tDOldMhJjwYcTi0rIerXDI4rkCsi+IzIm9eokeY1VFtlmlv008zG4Pythm3/v5Lbe
         jfAEDzhachfxmKwFqZRSp3+q4PbeC6acm6KSg6T6gYeU5YVtwKaIKegm5VDKu61uQBR4
         wJTpxJjhrqDeGwX5q7nnGk6UFjzCp8bnqw3EdNTqZkeq8DfTK1t41ycpfzY4CSEbHdWl
         /i+f7gVSzO8DG/y+fDkUt7SgJICPGzfUpNxbFuqq2stLQ+2ByohvHUXFrFCabZho04hh
         r72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZ7uNN0k2yuA/9SO4H7LdBx/F2uaTpjMn1JCveqGhDQ=;
        b=N9ZNfUHm9Ny2b+yPALqq07KEVcExY909ew0b3sIyvXdxiXFd2WE5IC5ehDDFoKIdAt
         f+5i+Ui7ePZhDD8Tizs0QVhVqQ9RH6i/391Ry/M0OD0K9iGpG4DFy9qvH8NJu3zVzr+p
         vrKk6yedoZgGjwSSNWSzTEGRbOAWDGbmeVXWrDCazutNZ2QjmosNVP4UmDbILQGGGyn+
         ymFi40bpO3WCBcqYDF01RJI7sTfj/dFvvUz1z5spEKK/Ojy+KUiJFz0KAo2OF/+7JXTD
         7Re8N5pyLj24/6JF8exQSYwlwmr6XHiwIYl2BA131cKsQ+hWC19VT2fKVp7/rOejWk2V
         0kxg==
X-Gm-Message-State: AA+aEWYFkAyIfQW3KpB6oFaHcK2ucWCS+sfKiGdQvGjQQ+asv5eEYaJX
        Fz4xCcSCfPT/aX4lkoGy+Az1/Fbw
X-Google-Smtp-Source: AFSGD/VzZp/xE9KqRdkrI9ZR89fkrrefwd/iuomNyxHkYRnBKL2eiWQ65obHp2Ld1bpEsDgtysmF6w==
X-Received: by 2002:adf:b592:: with SMTP id c18mr17165152wre.89.1545203286729;
        Tue, 18 Dec 2018 23:08:06 -0800 (PST)
Received: from flagship2.speedport.ip (p200300C20BD333581B9ECEB655B1C7D2.dip0.t-ipconnect.de. [2003:c2:bd3:3358:1b9e:ceb6:55b1:c7d2])
        by smtp.gmail.com with ESMTPSA id s16sm3245724wrt.77.2018.12.18.23.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 23:08:06 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@vger.kernel.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 1/5] MIPS: alchemy: cpu_all_mask is forbidden for clock event devices
Date:   Wed, 19 Dec 2018 08:07:59 +0100
Message-Id: <20181219070803.449981-2-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181219070803.449981-1-manuel.lauss@gmail.com>
References: <20181219070803.449981-1-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

change alchemy clock event device cpu_all_mask to cpu_possible_mask.
Gets rid of a warning, which then does the same substitution:
WARNING: CPU: 0 PID: 0 at kernel/time/clockevents.c:468 clockevents_register_device+0x130/0x140
rtcmatch2 cpumask == cpu_all_mask, using cpu_possible_mask instead

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index ff4dbe3dee34..b0f949c907dd 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -82,7 +82,7 @@ static struct clock_event_device au1x_rtcmatch2_clockdev = {
 	.features	= CLOCK_EVT_FEAT_ONESHOT,
 	.rating		= 1500,
 	.set_next_event = au1x_rtcmatch2_set_next_event,
-	.cpumask	= cpu_all_mask,
+	.cpumask	= cpu_possible_mask,
 };
 
 static struct irqaction au1x_rtcmatch2_irqaction = {
-- 
2.20.0

