Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 19:06:48 +0100 (BST)
Received: from mail-fx0-f175.google.com ([209.85.220.175]:10949 "EHLO
	mail-fx0-f175.google.com") by ftp.linux-mips.org with ESMTP
	id S20024407AbZCaSGX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Mar 2009 19:06:23 +0100
Received: by fxm23 with SMTP id 23so2707642fxm.0
        for <linux-mips@linux-mips.org>; Tue, 31 Mar 2009 11:06:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=FSAVD1iRQIjn1w+vJAtIrydczmVaNr44VvVe5tUxeJI=;
        b=tVyyrwWGVUF/CzbhrIdDykRxqY4mriiqZOCtfauxkOgz/A8BKFi5IaL0XqewVuST93
         6jjR6spakypxsB83KV8gSlGlDt9bWynJSzUZ2dhLJdkbz5KgbIsSDqgnCh4wXGJvCkIj
         MGeIrxNqkQj1kFI6AIaNBGW/yqfr1+JbdC2uk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=a7bWW4YHFOb4UWMIm/Vx4H/xXi3Bt79LEsX3rDX4R4pN2Wgr3OQbN2zchMCyo/WJuh
         bx5fiRtcsgUISwCBnUph+Wbgj/EbhjEPa0in5XtOdk5CNORDlXHoGDT1/sE0eribzw1W
         GO4xw5HxN8QItOwU5fXQbKvCnJw7YIl2f+UWI=
Received: by 10.103.238.4 with SMTP id p4mr2395618mur.68.1238522776780;
        Tue, 31 Mar 2009 11:06:16 -0700 (PDT)
Received: from localhost.localdomain (p5496E20F.dip.t-dialin.net [84.150.226.15])
        by mx.google.com with ESMTPS id u9sm12288569muf.55.2009.03.31.11.06.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 11:06:16 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 1/2] Alchemy: Fix AU1100 interrupt numbers off-by-one
Date:	Tue, 31 Mar 2009 20:06:16 +0200
Message-Id: <1238522777-20811-1-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips


Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/include/asm/mach-au1x00/au1000.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 62f91f5..87a1659 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -715,7 +715,7 @@ enum soc_au1500_ints {
 #ifdef CONFIG_SOC_AU1100
 enum soc_au1100_ints {
 	AU1100_FIRST_INT	= MIPS_CPU_IRQ_BASE + 8,
-	AU1100_UART0_INT,
+	AU1100_UART0_INT	= AU1100_FIRST_INT,
 	AU1100_UART1_INT,
 	AU1100_SD_INT,
 	AU1100_UART3_INT,
-- 
1.6.2
