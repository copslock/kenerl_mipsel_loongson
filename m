Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2012 05:26:56 +0200 (CEST)
Received: from mail-vb0-f49.google.com ([209.85.212.49]:52478 "EHLO
        mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901164Ab2FND0u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jun 2012 05:26:50 +0200
Received: by vbbfo1 with SMTP id fo1so931984vbb.36
        for <multiple recipients>; Wed, 13 Jun 2012 20:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:message-id:to:subject:cc:from;
        bh=5h5aAGJiGZeqoxqcT2qF+nILWIlJRttpttLS+0PaNxg=;
        b=vj4wUETnQdz4UKAiuwBBXQQ+CdlCG9hE6eIxqFMpdlRX6mckPie8ox2cCJPFm5bnTw
         wcCZ3meVB08zZaUKlUM8Os+VNT/25l4ddPUcLeMfr752mhudSKiX210B+8b7CD/gmqWF
         YCSEtRTifsqgWhyrPBiodOC4RqBlzKNJqUUoq4mEcp9cPNBR88g9MkYttF2zvwav9lZm
         2JnIslGy6113D9suBXJ7fBIO5Ul4u3GtglUgKIEj2lFKoAWGU147wCvGz3bPb7yn8ajI
         MSzWcu1MoxKdbrYUWR/O5C8u9rr2SArv5OfHwQh4qAMfwW+OUmMscSNkRmSWQ7MQ2KXr
         u1bQ==
Received: by 10.221.0.209 with SMTP id nn17mr59913vcb.33.1339644403657;
        Wed, 13 Jun 2012 20:26:43 -0700 (PDT)
Received: from localhost ([207.47.250.72])
        by mx.google.com with ESMTPS id l12sm4340396vdh.8.2012.06.13.20.26.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jun 2012 20:26:43 -0700 (PDT)
Received: from shane by localhost with local (Exim 4.72)
        (envelope-from <shane@localhost>)
        id 1Sf0hk-0000ZG-Jp; Wed, 13 Jun 2012 21:26:40 -0600
Date:   Wed, 13 Jun 2012 21:26:40 -0600
Message-Id: <E1Sf0hk-0000ZG-Jp@localhost>
To:     linux-mips@linux-mips.org
Subject: MIPS: Move processing of coherency kernel parameters earlier
Cc:     david.daney@cavium.com, ralf@linux-mips.org
From:   Shane McDonald <mcdonald.shane@gmail.com>
X-archive-position: 33635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Commit 97ce2c88f9ad42e3c60a9beb9fca87abf3639faa (jump-label: initialize
jump-label subsystem much earlier) caused MIPS to break, so this was
resolved with commit 6650df3c380e0db558dbfec63ed860402c6afb2a (MIPS:
Move cache setup to setup_arch().).  Unfortunately, after this commit,
the coherency kernel parameters, cca and coherentio, are no longer
processed before their values are used.

This patch fixes this problem by marking them as early_param, which
results in them being processed before they are needed.

Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
Acked-by: David Daney <david.daney@cavium.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/mm/c-r4k.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index ce0dbee..e10c3ac 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1316,10 +1316,10 @@ static int __init cca_setup(char *str)
 {
 	get_option(&str, &cca);
 
-	return 1;
+	return 0;
 }
 
-__setup("cca=", cca_setup);
+early_param("cca", cca_setup);
 
 static void __cpuinit coherency_setup(void)
 {
@@ -1369,10 +1369,10 @@ static int __init setcoherentio(char *str)
 {
 	coherentio = 1;
 
-	return 1;
+	return 0;
 }
 
-__setup("coherentio", setcoherentio);
+early_param("coherentio", setcoherentio);
 #endif
 
 static void __cpuinit r4k_cache_error_setup(void)
-- 
1.7.2.5
