Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Nov 2010 09:25:40 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:63758 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491116Ab0KHIZg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Nov 2010 09:25:36 +0100
Received: by iwn8 with SMTP id 8so5817293iwn.36
        for <multiple recipients>; Mon, 08 Nov 2010 00:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=fjR3ry0Pz6SfGtIR2+Ym1jkbtoCQl0WtKI0R95cWhCk=;
        b=a+L4an5C3DSIXKEgckvmCxZYOQ6DdTfV2OSpzUNCA+Nujf09XCcWx8oNwH9gRtR1ly
         9wT9RED1mSKpijG74Iv+9Bm32tiNiVqbZedweK193VaMwDAxeYJ6gZNjPs3eKVCbeIaJ
         N4izTtYGYkzTtRk1w3ea4MDSuDnExm6ZWYZ1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=CMKzQxhvDpF89IqUKq1q96HBYmQcJApcO3hBM8KjeRtrzc1Y8K6i5Qe1dPECBNH3yH
         jyZQJSPHOyuTtbWRtDDr9KuYUvRTkUnWpkYzGrpEbwN9tNnW4vCsPXODJ9+lyGF9+ki1
         YmjA+FRN4sfySBaU80R8+lI6BQzywGaji5jVw=
Received: by 10.42.193.135 with SMTP id du7mr3240613icb.321.1289204734255;
        Mon, 08 Nov 2010 00:25:34 -0800 (PST)
Received: from stratos (sannin29007.nirai.ne.jp [203.160.29.7])
        by mx.google.com with ESMTPS id 34sm5712900ibi.8.2010.11.08.00.25.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 00:25:33 -0800 (PST)
Date:   Mon, 8 Nov 2010 17:23:52 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: MIPS: alchemy: add return value check for strict_strtoul()
Message-Id: <20101108172352.db48962c.yuasa@linux-mips.org>
X-Mailer: Sylpheed 3.0.3 (GTK+ 2.16.6; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yyuasa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

arch/mips/alchemy/devboards/prom.c: In function 'prom_init':
arch/mips/alchemy/devboards/prom.c:60: error: ignoring return value of
'strict_strtoul', declared with attribute warn_unused_result

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/alchemy/devboards/prom.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/alchemy/devboards/prom.c b/arch/mips/alchemy/devboards/prom.c
index b30df5c..baeb213 100644
--- a/arch/mips/alchemy/devboards/prom.c
+++ b/arch/mips/alchemy/devboards/prom.c
@@ -54,10 +54,9 @@ void __init prom_init(void)
 
 	prom_init_cmdline();
 	memsize_str = prom_getenv("memsize");
-	if (!memsize_str)
+	if (!memsize_str || strict_strtoul(memsize_str, 0, &memsize))
 		memsize = ALCHEMY_BOARD_DEFAULT_MEMSIZE;
-	else
-		strict_strtoul(memsize_str, 0, &memsize);
+
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
 
-- 
1.7.3.2
