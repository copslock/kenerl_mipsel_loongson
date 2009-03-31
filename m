Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 19:06:24 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.188]:36014 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20023824AbZCaSGS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Mar 2009 19:06:18 +0100
Received: by fk-out-0910.google.com with SMTP id f40so1078336fka.0
        for <linux-mips@linux-mips.org>; Tue, 31 Mar 2009 11:06:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=HXVHE6s6demmtbFWpEpksNqbt1wYa33eHTexCnDUkWY=;
        b=JecLM1pykVgxRK+I79/09ZdHxrKqbBuIRwncxzMZNLSA8U/rF+ytoxAWBugo5PxmYP
         bIK67mCF6vD8ErqXnfmYngEjjQNGqrNa8MGLc9Kfqwv2gfGADDrV/Ur8kMsSS8hAEBr7
         rw8XHOykk6pOW05L+egGZnptG583R1cg+0nFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=JCrv7lcVHuz0T5n/ozhPErj3fY/9K9blyEeZWduEg6Ptfs/xwDGYhPaoJ+oK/sEJC2
         I5qD7TkMrkMjdqBuPfmUmU9SD0v3lIn+tnS/5/D055zpxpGBWvjCE0GAxj4PPHQya+Nd
         isu//DusJiPW39fENGs4SPBmGKm83XC/iv+Tk=
Received: by 10.103.11.5 with SMTP id o5mr2395139mui.75.1238522777495;
        Tue, 31 Mar 2009 11:06:17 -0700 (PDT)
Received: from localhost.localdomain (p5496E20F.dip.t-dialin.net [84.150.226.15])
        by mx.google.com with ESMTPS id u9sm12288569muf.55.2009.03.31.11.06.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 11:06:17 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 2/2] Alchemy: add missing Au1200 GPIO203 interrupt
Date:	Tue, 31 Mar 2009 20:06:17 +0200
Message-Id: <1238522777-20811-2-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1238522777-20811-1-git-send-email-mano@roarinelk.homelinux.net>
References: <1238522777-20811-1-git-send-email-mano@roarinelk.homelinux.net>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips


Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/include/asm/mach-au1x00/au1000.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 87a1659..854e95f 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -902,8 +902,8 @@ enum soc_au1200_ints {
 	AU1000_RTC_MATCH0_INT,
 	AU1000_RTC_MATCH1_INT,
 	AU1000_RTC_MATCH2_INT,
-
-	AU1200_NAND_INT		= AU1200_FIRST_INT + 23,
+	AU1200_GPIO_203,
+	AU1200_NAND_INT,
 	AU1200_GPIO_204,
 	AU1200_GPIO_205,
 	AU1200_GPIO_206,
-- 
1.6.2
