Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2009 16:53:03 +0000 (GMT)
Received: from mail-fx0-f175.google.com ([209.85.220.175]:9453 "EHLO
	mail-fx0-f175.google.com") by ftp.linux-mips.org with ESMTP
	id S28574981AbZCYQtl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Mar 2009 16:49:41 +0000
Received: by fxm23 with SMTP id 23so148346fxm.0
        for <linux-mips@linux-mips.org>; Wed, 25 Mar 2009 09:49:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=UAm75xdoSY/V9IywfiVkE35NZtIgCh1HNTODBcklz7c=;
        b=Veid4M/VTSQb9i2lFKJidJp4POCgNo4SmBC89XMWjVLZ2JcD2dw/Wr5o2tGW+4+vCG
         MbEui0z9g2K7DglHJUSj0rUEQuM5+ty/QaFNqJHXm91wj+dUEhr5JCOE+hXVIwJhmF1g
         SiyUyGTkKrGY6KUy0ZMj7mY3po/ltl4LwqpQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=Piv7XSwFDMk4Zn1586MYZSNrjnf95vC+Uzd6ELGAn4UdfQAAnXzMCBGk9aCFXupAmD
         w869Gb1jduK/Fl1BqQ2EpTgwB9SEZHKgBoP9+9jJjHKo8/mYXqmaxd3akFePx2RrXWA3
         F26GRw09tyyap7DHQ4qdWs6yjbKbz4P2Mv1/E=
Received: by 10.103.173.5 with SMTP id a5mr4282888mup.57.1237999775676;
        Wed, 25 Mar 2009 09:49:35 -0700 (PDT)
Received: from localhost.localdomain (p5496CCD7.dip.t-dialin.net [84.150.204.215])
        by mx.google.com with ESMTPS id e10sm14966093muf.41.2009.03.25.09.49.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 09:49:35 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 3/6] Alchemy: MIPS hazard workarounds are not required.
Date:	Wed, 25 Mar 2009 17:49:30 +0100
Message-Id: <1237999773-5174-4-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1237999773-5174-3-git-send-email-mano@roarinelk.homelinux.net>
References: <1237999773-5174-1-git-send-email-mano@roarinelk.homelinux.net>
 <1237999773-5174-2-git-send-email-mano@roarinelk.homelinux.net>
 <1237999773-5174-3-git-send-email-mano@roarinelk.homelinux.net>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

The Alchemy manuals state:

"All pipeline hazards and dependencies are enforced by hardware interlocks
 so that any sequence of instructions is guaranteed to execute correctly.
 Therefore, it is not necessary to pad legacy MIPS hazards (such as
 load delay slots and coprocessor accesses) with NOPs."

Run-tested on Au12x0, without any ill effects.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/include/asm/hazards.h |    4 ++--
 arch/mips/mm/tlbex.c            |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index 134e1fc..a12d971 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -87,7 +87,7 @@ do {									\
 	: "=r" (tmp));							\
 } while (0)
 
-#elif defined(CONFIG_CPU_MIPSR1)
+#elif defined(CONFIG_CPU_MIPSR1) && !defined(CONFIG_MACH_ALCHEMY)
 
 /*
  * These are slightly complicated by the fact that we guarantee R1 kernels to
@@ -139,7 +139,7 @@ do {									\
 } while (0)
 
 #elif defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_CAVIUM_OCTEON) || \
-      defined(CONFIG_CPU_R5500)
+      defined(CONFIG_CPU_R5500) || defined(CONFIG_MACH_ALCHEMY)
 
 /*
  * R10000 rocks - all hazards handled in hardware, so this becomes a nobrainer.
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 122c9c1..0615b62 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -292,7 +292,6 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_R4300:
 	case CPU_5KC:
 	case CPU_TX49XX:
-	case CPU_ALCHEMY:
 	case CPU_PR4450:
 		uasm_i_nop(p);
 		tlbw(p);
@@ -315,6 +314,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_R5500:
 		if (m4kc_tlbp_war())
 			uasm_i_nop(p);
+	case CPU_ALCHEMY:
 		tlbw(p);
 		break;
 
-- 
1.6.2
