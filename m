Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jul 2009 16:17:31 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.148]:27224 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493279AbZGUORY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Jul 2009 16:17:24 +0200
Received: by ey-out-1920.google.com with SMTP id 13so601881eye.54
        for <multiple recipients>; Tue, 21 Jul 2009 07:17:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=xQOJVWkfi5Gfn07ikLvXvDmEzkARIuT5TDrgoVGwtm4=;
        b=smS7z/8jJjlOKuOjYySqMw4BjjAx2/inVVSKf06X2EHARxXIMyO6uym1Jcn03d0ekg
         owfp+KXAeuQ9l0O+/nvCdQQd17PnVH1W+Jfm+EHp1tWX2ha87zWmyS70GSzhH4DS3LvF
         UeyjQN/hNrko7c+GGtIcrgdi1eBAXmMepK82c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=lKFrfmXqDMyVvfPgC4Re42kNiJ9x0hqxoL8ma10JUp08tPs9xoKF9Zlp+Iw4mC6IKk
         02di5bIUshz9Ey7RWv1nn9aMVcPI16xRahbUki1PWpLnSbofNM7UnwFdO1C0ibSpElOA
         wk8pRkMU/X9C8CZLPJg1k/y9LreSzmnMJxa3k=
Received: by 10.210.92.8 with SMTP id p8mr246129ebb.6.1248185843627;
        Tue, 21 Jul 2009 07:17:23 -0700 (PDT)
Received: from zoinx.mars (d133062.upc-d.chello.nl [213.46.133.62])
        by mx.google.com with ESMTPS id 5sm88067eyh.36.2009.07.21.07.16.54
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 21 Jul 2009 07:17:19 -0700 (PDT)
Message-ID: <4A65CE5C.4090607@gmail.com>
Date:	Tue, 21 Jul 2009 16:19:08 +0200
From:	Roel Kluin <roel.kluin@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Thunderbird/3.0b2
MIME-Version: 1.0
To:	rjw@sisk.pl, Manuel Lauss <manuel.lauss@googlemail.com>,
	ralf@linux-mips.org, linux-pm@lists.linux-foundation.org,
	linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mips: decrease size of au1xxx_dbdma_pm_regs[][]
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <roel.kluin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roel.kluin@gmail.com
Precedence: bulk
X-list: linux-mips

There are 16 individual channels (NUM_DBDMA_CHANS) to save/restore
plus the global ddma block config (the +1). The last register in a
channel can be skipped since it's read-only (at offset 0x18).

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Thanks for your review and explanation, Manuel!

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 3ab6d80..19c1c82 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -175,7 +175,7 @@ static dbdev_tab_t dbdev_tab[] = {
 #define DBDEV_TAB_SIZE	ARRAY_SIZE(dbdev_tab)
 
 #ifdef CONFIG_PM
-static u32 au1xxx_dbdma_pm_regs[NUM_DBDMA_CHANS + 1][8];
+static u32 au1xxx_dbdma_pm_regs[NUM_DBDMA_CHANS + 1][6];
 #endif
 
 
@@ -993,14 +993,13 @@ void au1xxx_dbdma_suspend(void)
 	au1xxx_dbdma_pm_regs[0][3] = au_readl(addr + 0x0c);
 
 	/* save channel configurations */
-	for (i = 1, addr = DDMA_CHANNEL_BASE; i < NUM_DBDMA_CHANS; i++) {
+	for (i = 1, addr = DDMA_CHANNEL_BASE; i <= NUM_DBDMA_CHANS; i++) {
 		au1xxx_dbdma_pm_regs[i][0] = au_readl(addr + 0x00);
 		au1xxx_dbdma_pm_regs[i][1] = au_readl(addr + 0x04);
 		au1xxx_dbdma_pm_regs[i][2] = au_readl(addr + 0x08);
 		au1xxx_dbdma_pm_regs[i][3] = au_readl(addr + 0x0c);
 		au1xxx_dbdma_pm_regs[i][4] = au_readl(addr + 0x10);
 		au1xxx_dbdma_pm_regs[i][5] = au_readl(addr + 0x14);
-		au1xxx_dbdma_pm_regs[i][6] = au_readl(addr + 0x18);
 
 		/* halt channel */
 		au_writel(au1xxx_dbdma_pm_regs[i][0] & ~1, addr + 0x00);
@@ -1027,14 +1026,13 @@ void au1xxx_dbdma_resume(void)
 	au_writel(au1xxx_dbdma_pm_regs[0][3], addr + 0x0c);
 
 	/* restore channel configurations */
-	for (i = 1, addr = DDMA_CHANNEL_BASE; i < NUM_DBDMA_CHANS; i++) {
+	for (i = 1, addr = DDMA_CHANNEL_BASE; i <= NUM_DBDMA_CHANS; i++) {
 		au_writel(au1xxx_dbdma_pm_regs[i][0], addr + 0x00);
 		au_writel(au1xxx_dbdma_pm_regs[i][1], addr + 0x04);
 		au_writel(au1xxx_dbdma_pm_regs[i][2], addr + 0x08);
 		au_writel(au1xxx_dbdma_pm_regs[i][3], addr + 0x0c);
 		au_writel(au1xxx_dbdma_pm_regs[i][4], addr + 0x10);
 		au_writel(au1xxx_dbdma_pm_regs[i][5], addr + 0x14);
-		au_writel(au1xxx_dbdma_pm_regs[i][6], addr + 0x18);
 		au_sync();
 		addr += 0x100;	/* next channel base */
 	}
