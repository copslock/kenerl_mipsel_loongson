Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jul 2009 18:56:11 +0200 (CEST)
Received: from rv-out-0708.google.com ([209.85.198.245]:62552 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492232AbZGLQ4F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 12 Jul 2009 18:56:05 +0200
Received: by rv-out-0708.google.com with SMTP id l33so457614rvb.24
        for <multiple recipients>; Sun, 12 Jul 2009 09:56:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject
         :message-id:from:date;
        bh=m249hhVPRsJt92PvgElsGKyz+JDQDVGAqJ2GIoL+DbY=;
        b=D6pyaifDs0dkj4Q//dMHi40ZVkG5Yr2K1wipJMKNr139CtbA1+neV2m3wnrrOopbCR
         0yL0BO1DE20XBNf+aE5FMnUwg499oi48AuZCa9I1hVaRHSldcfR19p55jWzM5/o5m9hd
         YG1xNOQUC7e4nXuYQr/BKY9csIU8FybUK0P1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:message-id:from:date;
        b=AoT4Mf5UCdCIIITuCoi2q4LZT7CjAudamiZFbJ60T3hgU4/tELohN9hZFw5phFLKEX
         6nkXZxQMtuOBAK2GYl46lknFhfiFVzhmAKOdjHkr5iLt5br3FTZ09s+8FmuGUPMrm/iV
         YMQ10wn828ixRqL5B/kgilyWBPbKPpyv0w69E=
Received: by 10.141.1.19 with SMTP id d19mr2321108rvi.44.1247417763261;
        Sun, 12 Jul 2009 09:56:03 -0700 (PDT)
Received: from localhost (71-17-214-13.sktn.hsdb.sasknet.sk.ca [71.17.214.13])
        by mx.google.com with ESMTPS id g31sm18388670rvb.10.2009.07.12.09.56.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Jul 2009 09:56:02 -0700 (PDT)
Received: from shane by localhost with local (Exim 4.63)
	(envelope-from <shane@localhost>)
	id 1MQ2LI-00069m-AX; Sun, 12 Jul 2009 10:56:00 -0600
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH] Define MIPS34K_MISSED_ITLB_WAR for non-MSP7120 boards
Message-Id: <E1MQ2LI-00069m-AX@localhost>
From:	Shane McDonald <mcdonald.shane@gmail.com>
Date:	Sun, 12 Jul 2009 10:56:00 -0600
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

The msp71xx/war.h file defines the value of MIPS34K_MISSED_ITLB_WAR
for the various MSP7120 boards, but doesn't specify a value for other
board types.  Set it to 0 for other boards.

This fixes a compile error when building for the MSP4200 boards.

Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
---
 arch/mips/include/asm/pmc-sierra/msp71xx/war.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/war.h b/arch/mips/include/asm/pmc-sierra/msp71xx/war.h
index 0bf48fc..713c960 100644
--- a/arch/mips/include/asm/pmc-sierra/msp71xx/war.h
+++ b/arch/mips/include/asm/pmc-sierra/msp71xx/war.h
@@ -23,6 +23,8 @@
 #if defined(CONFIG_PMC_MSP7120_EVAL) || defined(CONFIG_PMC_MSP7120_GW) || \
 	defined(CONFIG_PMC_MSP7120_FPGA)
 #define MIPS34K_MISSED_ITLB_WAR         1
+#else
+#define MIPS34K_MISSED_ITLB_WAR		0
 #endif
 
 #endif /* __ASM_MIPS_PMC_SIERRA_WAR_H */
-- 
1.6.2.4
