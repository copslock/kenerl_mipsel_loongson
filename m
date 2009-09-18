Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Sep 2009 09:15:14 +0200 (CEST)
Received: from mail-pz0-f196.google.com ([209.85.222.196]:61600 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492105AbZIRHOx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Sep 2009 09:14:53 +0200
Received: by pzk34 with SMTP id 34so638853pzk.22
        for <multiple recipients>; Fri, 18 Sep 2009 00:14:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=7CASoQPLtrbnru5R75N86gelNWTMk7iyGBtGwvx3k6E=;
        b=c9DTb8jpQDxdYgLQaKDPJVsv5JyOuidLdhMUogRs/objHgjP4in7RPx5o1avFiZUa6
         lqde6YkTLSkZcZetzQW26zMyCMsODnuLr4n9jGfY3Obrwg69iKEHfPTUqTzeNT0nfQJw
         qz5GJape1vD9GuElJTm0kalAgcdZ9fTAK0MVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=S7jrZxADX0DRFnwNlkEcAA23YfLR/GDdciFvvItqz13oTak9g0OfhAtWZGczJ1cOb0
         lvmrfB0C99sFa1+XXtmwFcKXhzSWiSNh7NQWVFswNflT48JIgMIDoduDCvX78OuMVovT
         muhUnmII58VKdfaAFj32Zm53MzMFFpBTwGCzE=
Received: by 10.115.45.5 with SMTP id x5mr1867320waj.182.1253258084877;
        Fri, 18 Sep 2009 00:14:44 -0700 (PDT)
Received: from localhost.localdomain ([58.212.86.177])
        by mx.google.com with ESMTPS id 20sm765979pxi.8.2009.09.18.00.14.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Sep 2009 00:14:43 -0700 (PDT)
From:	Huang Weiyi <weiyi.huang@gmail.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 2/2] MIPS: remove duplicated #include
Date:	Fri, 18 Sep 2009 15:14:35 +0800
Message-Id: <1253258075-3088-1-git-send-email-weiyi.huang@gmail.com>
X-Mailer: git-send-email 1.6.1.2
Return-Path: <weiyi.huang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24044
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
index 64668a9..119a95e 100644
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
