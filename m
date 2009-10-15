Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2009 19:32:09 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.147]:25031 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492896AbZJORcD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Oct 2009 19:32:03 +0200
Received: by ey-out-1920.google.com with SMTP id 13so233208eye.52
        for <multiple recipients>; Thu, 15 Oct 2009 10:32:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ndOjtaX8AV3kBc+bfvXDgILLKuqb4aVK2IvVKDYV0+g=;
        b=KpTgg67GL0XD1kQ8AZHTcG+32Vcpfnx/csG4zoZerhCt3J59svt0y3h2bAXdwgV7Gs
         N655ZS6zifMUX0nqP7OA/YpGnjDL908S/NaHaL6GEwcCIbHHnxpHdUaSV9IszJA3akHk
         SwcDSo74Cub2J27YcZ+3al6sTj0qBJp7MWuGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=YS4cSbHpooIHP8e2Ki4VIHHW8TVMC/g1mHN80cSyF0zSP4UKCjefpdf08WkBflvCtX
         3j3tJhLOvNTTO9vBfgWkC7254i4xlP7eqktHeP+lyKllgoKFWvh6BlmprtQy9JzxBcNq
         tFyROwtNx12Ko/eLKRYCYEqpa0ZMub5Fx87nQ=
Received: by 10.216.88.140 with SMTP id a12mr88828wef.157.1255627921253;
        Thu, 15 Oct 2009 10:32:01 -0700 (PDT)
Received: from localhost.localdomain (p5496E392.dip.t-dialin.net [84.150.227.146])
        by mx.google.com with ESMTPS id i35sm633495gve.28.2009.10.15.10.31.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 10:32:00 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: remove unused SYS area structure
Date:	Thu, 15 Oct 2009 19:32:01 +0200
Message-Id: <1255627921-15944-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Nothing in-tree uses it, so get rid of it.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
made against lmo-queue + previous 2 patches.

 arch/mips/include/asm/mach-au1x00/au1000.h |   49 ----------------------------
 1 files changed, 0 insertions(+), 49 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index ee65236..e4100da 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -1688,53 +1688,4 @@ enum soc_au1200_ints {
 #define PCMCIA_MEM_PSEUDO_PHYS	(PCMCIA_MEM_PHYS_ADDR >> 4)
 #define PCMCIA_PSEUDO_END	(0xffffffff)
 
-#ifndef _LANGUAGE_ASSEMBLY
-typedef volatile struct {
-	/* 0x0000 */ u32 toytrim;
-	/* 0x0004 */ u32 toywrite;
-	/* 0x0008 */ u32 toymatch0;
-	/* 0x000C */ u32 toymatch1;
-	/* 0x0010 */ u32 toymatch2;
-	/* 0x0014 */ u32 cntrctrl;
-	/* 0x0018 */ u32 scratch0;
-	/* 0x001C */ u32 scratch1;
-	/* 0x0020 */ u32 freqctrl0;
-	/* 0x0024 */ u32 freqctrl1;
-	/* 0x0028 */ u32 clksrc;
-	/* 0x002C */ u32 pinfunc;
-	/* 0x0030 */ u32 reserved0;
-	/* 0x0034 */ u32 wakemsk;
-	/* 0x0038 */ u32 endian;
-	/* 0x003C */ u32 powerctrl;
-	/* 0x0040 */ u32 toyread;
-	/* 0x0044 */ u32 rtctrim;
-	/* 0x0048 */ u32 rtcwrite;
-	/* 0x004C */ u32 rtcmatch0;
-	/* 0x0050 */ u32 rtcmatch1;
-	/* 0x0054 */ u32 rtcmatch2;
-	/* 0x0058 */ u32 rtcread;
-	/* 0x005C */ u32 wakesrc;
-	/* 0x0060 */ u32 cpupll;
-	/* 0x0064 */ u32 auxpll;
-	/* 0x0068 */ u32 reserved1;
-	/* 0x006C */ u32 reserved2;
-	/* 0x0070 */ u32 reserved3;
-	/* 0x0074 */ u32 reserved4;
-	/* 0x0078 */ u32 slppwr;
-	/* 0x007C */ u32 sleep;
-	/* 0x0080 */ u32 reserved5[32];
-	/* 0x0100 */ u32 trioutrd;
-#define trioutclr trioutrd
-	/* 0x0104 */ u32 reserved6;
-	/* 0x0108 */ u32 outputrd;
-#define outputset outputrd
-	/* 0x010C */ u32 outputclr;
-	/* 0x0110 */ u32 pinstaterd;
-#define pininputen pinstaterd
-} AU1X00_SYS;
-
-static AU1X00_SYS * const sys = (AU1X00_SYS *)SYS_BASE;
-
-#endif
-
 #endif
-- 
1.6.5.rc2
