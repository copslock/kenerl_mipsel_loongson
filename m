Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 21:28:10 +0200 (CEST)
Received: from mail-fx0-f225.google.com ([209.85.220.225]:39233 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492826AbZJPT2D (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2009 21:28:03 +0200
Received: by fxm25 with SMTP id 25so2938029fxm.0
        for <multiple recipients>; Fri, 16 Oct 2009 12:27:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=JQ3FWg9ZRRw2YIBzmGUBeTteSy9uuPrrDkV/XIVr+eg=;
        b=L4JTi85SmA7BSPOZKHfYCQruWCRugjoGxinqIKaF8mA1jirMCzyOYRrwZo6cSaBUgw
         gB7QIoRs2EP19T2ozu3zBI1FD3Klu2gSMCZVq9oRqvwiGo2a35zQ4FBfaXj1TLaj0Kxm
         byk+DsBPL480kyv71bp3/pgC32y3mcrK/h30o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xrnQZhdg8Kl4PLwiL14U4THVmIWB/3fIdrpIwzxbUc14nZyawNZeZiBKPDirgQOedN
         p2DbzNqosVKoq5R7gwEq4O31ddjKrQeMeM8WEvNMM2xnfQCd4ZDsmcswctS4BxIcoLAr
         UmaPBg4tYxIM2+SSEKHvEq7BBYaaRh6XeZepU=
Received: by 10.204.25.196 with SMTP id a4mr1639353bkc.133.1255721276451;
        Fri, 16 Oct 2009 12:27:56 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 13sm253292bwz.10.2009.10.16.12.27.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Oct 2009 12:27:54 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: fix dma.c compiled bug
Date:	Fri, 16 Oct 2009 21:27:56 +0200
Message-Id: <1255721276-27561-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Patch "MIPS: Alchemy: get rid of superfluous UART definitions" breaks
dma.c.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---

 arch/mips/include/asm/mach-au1x00/au1000.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index ee65236..c6235c5 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -915,6 +915,7 @@ enum soc_au1200_ints {
 #ifdef CONFIG_SOC_AU1000
 
 #define UART0_ADDR		0xB1100000
+#define UART3_ADDR		0xB1400000
 
 #define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
 #define USB_HOST_CONFIG 	0xB017FFFC
@@ -931,6 +932,7 @@ enum soc_au1200_ints {
 #ifdef CONFIG_SOC_AU1500
 
 #define UART0_ADDR		0xB1100000
+#define UART3_ADDR		0xB1400000
 
 #define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
 #define USB_HOST_CONFIG 	0xB017fffc
@@ -947,6 +949,7 @@ enum soc_au1200_ints {
 #ifdef CONFIG_SOC_AU1100
 
 #define UART0_ADDR		0xB1100000
+#define UART3_ADDR		0xB1400000
 
 #define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
 #define USB_HOST_CONFIG 	0xB017FFFC
-- 
1.6.5
