Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 21:52:56 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.154]:49186 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491914Ab0EWTwV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 21:52:21 +0200
Received: by fg-out-1718.google.com with SMTP id 16so812537fgg.6
        for <multiple recipients>; Sun, 23 May 2010 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=dj5+YXtrBiH8GEFTFmO4wMu9uBk0HNDdClcoDKr475o=;
        b=h4grmibem6BTZk8QBH8he3mR1lscgNjMVcPylxsvuqfpPuhT2HN5HybHWkOikhKPSq
         l4Z9ggBIeDGSRbjEYyWWrm3L8pnL1Lr0dhkvDiZF944SRYAuQuPH3tnSPl38jDkcNcUA
         DoXM2ShGngZ96rtHSvnhOtnS3q9W+FNPJTnMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=spCKvJZX3/MbG3MjBtyMDYVqDDBLjVfFcSEadhxdwT8cHKGKnWsOFkJdvv2KQkNegs
         nflrcrn02ppHjhsGxxCD5jVw+uBhSYH6oNlAgvLaoLmBZdKt8BpKqwGQSdBX5JXf9OCC
         /dPNi976DoYK1/U+pUVL94AydfmbDF8LdUYjw=
Received: by 10.87.40.32 with SMTP id s32mr7231592fgj.21.1274644339191;
        Sun, 23 May 2010 12:52:19 -0700 (PDT)
Received: from localhost.localdomain (net-93-145-200-9.t2.dsl.vodafone.it [93.145.200.9])
        by mx.google.com with ESMTPS id d6sm6081796fga.3.2010.05.23.12.52.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 12:52:18 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 163/199] arch/mips/dec/promcon.c: Checkpatch cleanup
Date:   Sun, 23 May 2010 21:52:04 +0200
Message-Id: <1274644332-23964-3-git-send-email-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 1.7.1.251.gf80a2
In-Reply-To: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
Precedence: bulk
X-list: linux-mips

arch/mips/dec/promcon.c:37: ERROR: that open brace { should be on the previous line

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/dec/promcon.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/mips/dec/promcon.c b/arch/mips/dec/promcon.c
index 9f0972f..c239c25 100644
--- a/arch/mips/dec/promcon.c
+++ b/arch/mips/dec/promcon.c
@@ -33,8 +33,7 @@ static int __init prom_console_setup(struct console *co, char *options)
 	return 0;
 }
 
-static struct console sercons =
-{
+static struct console sercons = {
 	.name	= "ttyS",
 	.write	= prom_console_write,
 	.setup	= prom_console_setup,
-- 
1.7.1.251.gf80a2
