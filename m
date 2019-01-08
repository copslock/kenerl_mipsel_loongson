Return-Path: <SRS0=z0u9=PQ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B454C43387
	for <linux-mips@archiver.kernel.org>; Tue,  8 Jan 2019 06:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87D82087F
	for <linux-mips@archiver.kernel.org>; Tue,  8 Jan 2019 06:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgAsoHpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfAHGUj (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:20:39 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:39755 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfAHGUj (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 8 Jan 2019 01:20:39 -0500
Received: by mail-pf1-f176.google.com with SMTP id r136so1403138pfc.6
        for <linux-mips@vger.kernel.org>; Mon, 07 Jan 2019 22:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J7B2Qdz9iEgB/ZAsEdF0Za3jlx9E0l6x/LKLQIiY9y8=;
        b=YgAsoHpLhOpd5c3keQqXgGldhBKOF2Q5gOs8PvohZTq8P2//yq8mtNbmxlz9b7rC9P
         7KHDfEJEO5mLrs9ZveakUfM9aZf9N4Y2G0na/Zzd/rx+VFkbVxVz5W7tbRQxHBGhVpD2
         JXy+6ct9o+9vqULF39UR8Sn5OKf9q+d2Qlnu6+ubthUBC6me0db46f9WjF95MvAFfdzz
         9ANcCiqN5QXmyY0D8novBpLwIN70zV40hXiaSz1m8tvDSKusYyoAVFsisTEGY1cM429L
         ARuc3XrWZxSNGeSaQNxIZCsShzv+uNbTmv4kbX0mw6hb6st5SWtSNcMtFj9vuJA/sa13
         EQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=J7B2Qdz9iEgB/ZAsEdF0Za3jlx9E0l6x/LKLQIiY9y8=;
        b=g+Qeq401KYLGwro7gj/k65FqdEp4JxP3ZRHJ4XJiFGXZxpbDoy1xRFP6xXlv7koTY5
         qJQiHKAKf8dGdOCXIJQtQzIL/wU1Y22EScxAfNJqgrZ3JR6XeBChppP5n8y9mDSkPJQ1
         ZsPIdLcVh9KXyNvcEckNrY3xFVOCsBnqAv08aBWAyPe8dqU7mQiGmbf7vHM0nT+0jpkA
         hu/R4r3bipW6cQGZfBqlCOm/+pKzZQvJ3PI+e7jg5QYAYiSzqWLxh+utMQ4xsZtzPAkK
         BUXT4yIiasPDbOv+c0sr132aE/ghvYdkTf/ck6fmk4s91m+M+D1AhzlJKkNuyQb4e1Zz
         WGbw==
X-Gm-Message-State: AJcUukfCUrmq5sbLpZ3bW73lXSjUeg8bKUqO46tP+LnCXze8Z1lkPMSr
        O7FV1+kQosWZ7+dVzzbclqo=
X-Google-Smtp-Source: ALg8bN6KDJKJM5Wm1lPwWbyYYCZDtt4JXnYCJ6fQWrSfKgd+0xIjxKWjQWhOv5ts9SxEed2Oc0W08Q==
X-Received: by 2002:a63:e655:: with SMTP id p21mr455385pgj.70.1546928438383;
        Mon, 07 Jan 2019 22:20:38 -0800 (PST)
Received: from loongson.vpn2.bfsu.edu.cn ([47.74.12.188])
        by smtp.gmail.com with ESMTPSA id d18sm104058580pfj.47.2019.01.07.22.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 22:20:37 -0800 (PST)
From:   YunQiang Su <syq@debian.org>
To:     steven.hill@cavium.com, linux-mips@vger.kernel.org,
        aaro.koskinen@iki.fi
Cc:     YunQiang Su <syq@debian.org>
Subject: [BUG, non-patch] Octeon kexec ftbfs and unusable
Date:   Tue,  8 Jan 2019 14:19:40 +0800
Message-Id: <20190108061938.8106-1-syq@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The kernel for Octeon fails to build with kexec enabled, and
the bellow patch makes it buildable.

While in fact the kexec for octeon is not usable at all.
It will hang after:
   Checking for the daddiu bug... no.

I tried to delete the bellow line or replace it with
   kexec_nonboot_cpu_jump();

The 4.19, and even 4.9 without ftbfs also hangs at the same place.
---
 arch/mips/cavium-octeon/setup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 2c79ab529..876f2f27e 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -98,7 +98,6 @@ static void octeon_kexec_smp_down(void *ignored)
 	"	sync						\n"
 	"	synci	($0)					\n");
 
-	relocated_kexec_smp_wait(NULL);
 }
 #endif
 
-- 
2.20.1

