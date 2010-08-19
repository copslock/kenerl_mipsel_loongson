Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Aug 2010 13:37:26 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:49833 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490955Ab0HSLhS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Aug 2010 13:37:18 +0200
Received: by bwz13 with SMTP id 13so1726490bwz.36
        for <linux-mips@linux-mips.org>; Thu, 19 Aug 2010 04:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=HAscM9toEXSPG89OQZJl79Ic1/P2tWJKYEhoPjt2ExI=;
        b=d1WaUVmmgc/gtozp8P20R84zGzKEmAyj+q31VxNs6HiZZW60nxWJL+VoemyAK29nED
         VEDybbg4/kfPR0gIIpUbUMwiqRIdwBpRGuy+PBcf0/lZmUcRCSvNv/0Ep7WopZPIhRQI
         +6m90xiCuoCXb/R31ZZe3uEWBXzrNx2M2JTvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=orRkRAMl+iuDE0v/+ybgADLUvwh6JZp75IrnDualtUaBlj4sZ1GxpQw4WosJFLA/2J
         w5saE9HZq1EKZZTIAEgA/JNqhbvUeVoJT9EzkT4tvHw3b+Nf4Ey2klb7GCeCmfcx+XQm
         QAyGRXv5dIQ9vCJOgvEOre5fILdd2mSXkjkSo=
Received: by 10.204.39.203 with SMTP id h11mr6471484bke.8.1282217838354;
        Thu, 19 Aug 2010 04:37:18 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id g12sm1028577bkb.2.2010.08.19.04.37.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 04:37:16 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] MIPS: Alchemy: resolve prom section mismatches
Date:   Thu, 19 Aug 2010 13:37:13 +0200
Message-Id: <1282217833-27119-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

The function prom_init_cmdline() references
the variable __initdata arcs_cmdline.

The function prom_get_ethernet_addr() references
the variable __initdata arcs_cmdline.

Annotate prom_init_cmdline() as __init, unexport and annotate
prom_get_ethernet_addr() since it's no longer called from
within driver code.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/prom.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/alchemy/common/prom.c b/arch/mips/alchemy/common/prom.c
index c29511b..5340210 100644
--- a/arch/mips/alchemy/common/prom.c
+++ b/arch/mips/alchemy/common/prom.c
@@ -43,7 +43,7 @@ int prom_argc;
 char **prom_argv;
 char **prom_envp;
 
-void prom_init_cmdline(void)
+void __init prom_init_cmdline(void)
 {
 	int i;
 
@@ -104,7 +104,7 @@ static inline void str2eaddr(unsigned char *ea, unsigned char *str)
 	}
 }
 
-int prom_get_ethernet_addr(char *ethernet_addr)
+int __init prom_get_ethernet_addr(char *ethernet_addr)
 {
 	char *ethaddr_str;
 
@@ -123,7 +123,6 @@ int prom_get_ethernet_addr(char *ethernet_addr)
 
 	return 0;
 }
-EXPORT_SYMBOL(prom_get_ethernet_addr);
 
 void __init prom_free_prom_memory(void)
 {
-- 
1.7.2
