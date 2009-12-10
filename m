Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Dec 2009 06:01:50 +0100 (CET)
Received: from mail-gx0-f227.google.com ([209.85.217.227]:64386 "EHLO
        mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492771AbZLJFBq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Dec 2009 06:01:46 +0100
Received: by gxk27 with SMTP id 27so7299952gxk.7
        for <multiple recipients>; Wed, 09 Dec 2009 21:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=3UDF9wKEmj0mbgeWFrn+hTS7mRTKT1LUdihMFWIIiX4=;
        b=l82980qOnr6f0MXpHzfLDSc8mGYzmY48I/m489Xx/WJXydTmGMP6I0gekg89uk/e8u
         7FkuKpbYqySIrxpu0MJJypeR/9D4LGbchOPJuSnqWkMs/kcoDicD4el3OO4ksOs18VPp
         bal3UUfSqECPhWJH7j5Sp6Od82HR4DIwPvyH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Iu36ruImsYqiUqdKnFejlx1Cp90qzJz3F+JiuyAwEwcxuB9L1ZY7hISiId6fGCE/Fy
         7XF0IKT6T5+Z5eIC1yjEhBF9Bo/bqFQ2fXjrWs4EBQ/4bk17pY2mFsuFsCzaNpbiq6FT
         VLvufrlm5VxrJAHCRh2jsJwg8LTm1k+GES3YE=
Received: by 10.91.21.25 with SMTP id y25mr1511063agi.66.1260421296898;
        Wed, 09 Dec 2009 21:01:36 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 14sm255659gxk.10.2009.12.09.21.01.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Dec 2009 21:01:35 -0800 (PST)
Date:   Thu, 10 Dec 2009 14:00:39 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: vr41xx use strlcat() for the command line arguments
Message-Id: <20091210140039.207ec1c5.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/vr41xx/common/init.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/vr41xx/common/init.c b/arch/mips/vr41xx/common/init.c
index 1386e6f..2391632 100644
--- a/arch/mips/vr41xx/common/init.c
+++ b/arch/mips/vr41xx/common/init.c
@@ -1,7 +1,7 @@
 /*
  *  init.c, Common initialization routines for NEC VR4100 series.
  *
- *  Copyright (C) 2003-2008  Yoichi Yuasa <yuasa@linux-mips.org>
+ *  Copyright (C) 2003-2009  Yoichi Yuasa <yuasa@linux-mips.org>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -66,9 +66,9 @@ void __init prom_init(void)
 	argv = (char **)fw_arg1;
 
 	for (i = 1; i < argc; i++) {
-		strcat(arcs_cmdline, argv[i]);
+		strlcat(arcs_cmdline, argv[i], COMMAND_LINE_SIZE);
 		if (i < (argc - 1))
-			strcat(arcs_cmdline, " ");
+			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
 	}
 }
 
-- 
1.6.5.4
