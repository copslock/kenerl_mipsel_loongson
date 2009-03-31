Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 17:51:38 +0100 (BST)
Received: from mail-fx0-f175.google.com ([209.85.220.175]:2714 "EHLO
	mail-fx0-f175.google.com") by ftp.linux-mips.org with ESMTP
	id S20024820AbZCaQvb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Mar 2009 17:51:31 +0100
Received: by fxm23 with SMTP id 23so2672829fxm.0
        for <linux-mips@linux-mips.org>; Tue, 31 Mar 2009 09:51:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=AeOAX1vWQZJZb/IA2AW1BpgLQNE0RwwUz8dfM7VFz0U=;
        b=o52W7/DpZ/7lwH3yZhEa6dlf+rnB3SOBuEQ44/P1SnEluonn4YBV0vIe6BBV5Qylzy
         xssIdUP75oM1G7T9+PHm+MQhokXQnUWyALpaed3WBsr5wO3JKxHlk5mS5Ox11Fr6viCV
         YHDKQR8GesWQ3KA1YTw8HWJwHZ7ODB1ARqPvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=QzZR/1hebwf+TAp1koVPO/DAtSgfOOm8KCHNWB3u3RGKOQuRjSfQ0Jjzt+4WUYctil
         UDgK5oO34iv+up9i5RnS/BTNGSvZ3r3oX6htWnjnWOUxxQ5kIN16gdC1YjzUHFaMe6YF
         Ac8IFIibEKrjD2rcfr1a87pQypC6pj73KFGjo=
Received: by 10.103.8.17 with SMTP id l17mr2361800mui.125.1238518285691;
        Tue, 31 Mar 2009 09:51:25 -0700 (PDT)
Received: from localhost.localdomain (p5496E20F.dip.t-dialin.net [84.150.226.15])
        by mx.google.com with ESMTPS id j6sm2195257mue.4.2009.03.31.09.51.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 09:51:25 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 1/2] Alchemy: Fix AU1100 interrupt numbers off-by-one
Date:	Tue, 31 Mar 2009 18:51:27 +0200
Message-Id: <1238518288-5162-1-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

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
