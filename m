Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Sep 2009 05:15:16 +0200 (CEST)
Received: from mail-pz0-f177.google.com ([209.85.222.177]:54353 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491886AbZI0DPI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 27 Sep 2009 05:15:08 +0200
Received: by pzk7 with SMTP id 7so1607109pzk.21
        for <multiple recipients>; Sat, 26 Sep 2009 20:14:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=rOYpzImAnvLtpltCXCumCh0LuUcMSZO6DU8Myhj1R60=;
        b=n46unOCi6vrsuAJKM8Oe7h7vUfOFWYpWW9S/E15vF5LAKj+eptu4DkSnfewwJWfGkZ
         MR9IJ72A7Ch65jE+/moXOp1EE0/9oXIYbiadNTdjF3904SPLZKunKB5wT5s7LNjRjv/I
         mQN0z4wOXh1cro/Y6hUBFpC7uzJsjpKdvCc2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rPgLtLIVXFn8ObZW4bMmK+gWIuLeZ5JpreE1+7skua9VxnOpJrrCJXVPGThawcYd5j
         UgNO8BkSUg3MG076wUDhDVS5F5WSijp8dfpZ+lzhHtMmOVPR9Ks3QxaABRbqGB2kTmM3
         sOxrzLjPnY2/h7ziELsrG3KLiRbogb6cHWwXM=
Received: by 10.115.103.23 with SMTP id f23mr2879321wam.226.1254021299331;
        Sat, 26 Sep 2009 20:14:59 -0700 (PDT)
Received: from localhost.localdomain ([58.212.85.233])
        by mx.google.com with ESMTPS id 23sm1455830pzk.12.2009.09.26.20.14.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Sep 2009 20:14:57 -0700 (PDT)
From:	Huang Weiyi <weiyi.huang@gmail.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 1/5] MIPS: remove duplicated #include
Date:	Sun, 27 Sep 2009 11:14:54 +0800
Message-Id: <1254021294-3832-1-git-send-email-weiyi.huang@gmail.com>
X-Mailer: git-send-email 1.6.1.2
Return-Path: <weiyi.huang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weiyi.huang@gmail.com
Precedence: bulk
X-list: linux-mips

Remove duplicated #include('s) in
  arch/mips/kernel/smp.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/mips/kernel/smp.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 4eb106c..09e8dcf 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -32,7 +32,6 @@
 #include <linux/cpumask.h>
 #include <linux/cpu.h>
 #include <linux/err.h>
-#include <linux/smp.h>
 
 #include <asm/atomic.h>
 #include <asm/cpu.h>
-- 
1.6.1.3
