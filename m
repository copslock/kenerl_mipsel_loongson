Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Apr 2010 07:46:39 +0200 (CEST)
Received: from mail-gx0-f228.google.com ([209.85.217.228]:52371 "EHLO
        mail-gx0-f228.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491192Ab0D0FqL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Apr 2010 07:46:11 +0200
Received: by mail-gx0-f228.google.com with SMTP id 28so7819954gxk.7
        for <multiple recipients>; Mon, 26 Apr 2010 22:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ICTLGVzI7eslsRMqcC3oJOexzS0ayJ4kaaH8zvTT4Cs=;
        b=YK+rVZyS4lbvBxS11uletaQxR9IQa5iZnvC4eQBT6qBxJu70ucbKWY/v1SrZ+cBhil
         Q2xe9Wdj30TAG4Xy2PbhzQcmjDCvavHpeMwlOhBh7kSTD95TnAAM8duQl5G7dWIXrNA+
         ROFMfyvlSpif3UYN9q04+LzISsQ5ZJiBqFTgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nJl4a63SqYpqShQCB6v4o0waqLGt0P29bRRy9ChQKkGCWkaeheaUoogRqTh/zn4Fr6
         HAfCM6wqOnc8UnvYmL6bjcKTXhlUbeOJmlIaN7lNd5XhbMMzcScD7+d88XVrBmSvyLUN
         B5pBQPnnCVrFk/gPabj4vPpcfElsncjr1tqDg=
Received: by 10.101.137.35 with SMTP id p35mr778617ann.204.1272347171274;
        Mon, 26 Apr 2010 22:46:11 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 16sm1784921gxk.9.2010.04.26.22.46.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 22:46:10 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>, post@pfrst.de,
        linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 2/2] MIPS: Cleanup of set_uncached_handler()
Date:   Tue, 27 Apr 2010 13:45:47 +0800
Message-Id: <1272347147-15071-2-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1272347147-15071-1-git-send-email-wuzhangjin@gmail.com>
References: <1272347147-15071-1-git-send-email-wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

The commit "MIPS: Fixup and cleanup of TO_PHYS(), TO_CAC(), TO_UNCAC()"
has provided a TO_UNCAC() for 32bit kernel, so, we can share the same
code between 32bit and 64bit kernel in set_uncached_handler().

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/traps.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 1a4dd65..fb8cd40 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1557,12 +1557,7 @@ static char panic_null_cerr[] __cpuinitdata =
 void __cpuinit set_uncached_handler(unsigned long offset, void *addr,
 	unsigned long size)
 {
-#ifdef CONFIG_32BIT
-	unsigned long uncached_ebase = KSEG1ADDR(ebase);
-#endif
-#ifdef CONFIG_64BIT
 	unsigned long uncached_ebase = TO_UNCAC(ebase);
-#endif
 
 	if (!addr)
 		panic(panic_null_cerr);
-- 
1.7.0
