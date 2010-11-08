Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Nov 2010 14:25:48 +0100 (CET)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:49430 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491772Ab0KHNZp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Nov 2010 14:25:45 +0100
Received: by pzk27 with SMTP id 27so1002917pzk.36
        for <multiple recipients>; Mon, 08 Nov 2010 05:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=43siHbyWZfWjGPlOnVBwrNHsQplPu65XcR1Pc6+tl+k=;
        b=BodpivRfNIk6R/GGhjct7YCDhSq1SmyPtFhxz6kxorOfQP8Vu+T+5ApDtMOioy160g
         8caStu841rCqy7hgU5qdJbXB8Jb9wPa3RvkZzJ8pZsMWdRTcuUnvdcnvaW+N/yPPuUyB
         wpnohX0e5KYhPL+axZE9aeqGu9W4RNekc+a9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Zj5a94Sa4i+1zyFoepqIaqrCCgtULP4tDKBysN3kvNYAwndIp8h9v/oBuCjrHL3/Xl
         9hnkni24oCJC9p7DUbxnHttnQmZ47eb+2lT8uCogIoT1zr11czBiVRT0Uv1ulQ/k9z+a
         tmyrgl6IPxio5FjlVOne1R7jt8V0ZqksjAqLY=
Received: by 10.142.229.19 with SMTP id b19mr4559332wfh.217.1289222738359;
        Mon, 08 Nov 2010 05:25:38 -0800 (PST)
Received: from localhost.localdomain ([221.220.250.231])
        by mx.google.com with ESMTPS id q13sm8104622wfc.5.2010.11.08.05.25.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 05:25:37 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: Loongson: add return value check for strict_strtoul()
Date:   Mon,  8 Nov 2010 21:25:24 +0800
Message-Id: <1289222724-8237-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

cc1: warnings being treated as errors
arch/mips/loongson/common/env.c: In function 'prom_init_env':
arch/mips/loongson/common/env.c:49: error: ignoring return value of 'strict_strtol', declared with attribute warn_unused_result
arch/mips/loongson/common/env.c:50: error: ignoring return value of 'strict_strtol', declared with attribute warn_unused_result
arch/mips/loongson/common/env.c:51: error: ignoring return value of 'strict_strtol', declared with attribute warn_unused_result
arch/mips/loongson/common/env.c:52: error: ignoring return value of 'strict_strtol', declared with attribute warn_unused_result

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/env.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/loongson/common/env.c b/arch/mips/loongson/common/env.c
index ae4cff9..11b193f 100644
--- a/arch/mips/loongson/common/env.c
+++ b/arch/mips/loongson/common/env.c
@@ -29,9 +29,9 @@ unsigned long memsize, highmemsize;
 
 #define parse_even_earlier(res, option, p)				\
 do {									\
+	int ret;							\
 	if (strncmp(option, (char *)p, strlen(option)) == 0)		\
-			strict_strtol((char *)p + strlen(option"="),	\
-					10, &res);			\
+		ret = strict_strtol((char *)p + strlen(option"="), 10, &res); \
 } while (0)
 
 void __init prom_init_env(void)
-- 
1.7.1
