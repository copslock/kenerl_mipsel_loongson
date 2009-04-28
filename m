Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 06:52:38 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.245]:24093 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023855AbZD1Fwb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2009 06:52:31 +0100
Received: by rv-out-0708.google.com with SMTP id k29so239269rvb.24
        for <multiple recipients>; Mon, 27 Apr 2009 22:52:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject:cc
         :message-id:from:date;
        bh=z9Y9ULWu1rwg10w1BWuzAbyRbMIf3bXTL0gLKiD4dV0=;
        b=fY5jaWzZxzB9X2AH2OiCoaICfFzmb7Ab/Abvzc/9OPu/ByJkVRazPy0tHlOpb+V90f
         8i4HD/zzg6xEXvaITbT4AV64htXekkkM2am0avJJk2NcLxuEJmuOA3fRVP1k6NDYcYlG
         JF/ZNk+7RzP2iesiZY8NAhu9MQD3UPbkygE5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:cc:message-id:from:date;
        b=HPEjWSivUKm5dRItX1J2qssftvWtn8epuUZX3jBD3sc+PP9pRQI8ieq19sL9c9b0qp
         Fs1JEh22jwcF3QDNR4Y1TV98G650CFcCI542Maa2a14Mf5ZZUh0tlBvLR84wHXHVKw+s
         lOSyca2TAbZDK6Bv94yJjvkMMYeXHPnczCxdc=
Received: by 10.141.36.17 with SMTP id o17mr1838236rvj.254.1240897949128;
        Mon, 27 Apr 2009 22:52:29 -0700 (PDT)
Received: from localhost (207-47-250-185.sktn.hsdb.sasknet.sk.ca [207.47.250.185])
        by mx.google.com with ESMTPS id g14sm10196032rvb.52.2009.04.27.22.52.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Apr 2009 22:52:28 -0700 (PDT)
Received: from shane by localhost with local (Exim 4.63)
	(envelope-from <shane@localhost>)
	id 1LygEz-00068K-17; Mon, 27 Apr 2009 23:52:25 -0600
To:	linux-mips@linux-mips.org
Subject: [MIPS] Resolve use of non-existent GPIO routines in msp71xx reset
Cc:	ralf@linux-mips.org
Message-Id: <E1LygEz-00068K-17@localhost>
From:	Shane McDonald <mcdonald.shane@gmail.com>
Date:	Mon, 27 Apr 2009 23:52:25 -0600
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

There have been a number of compile problems with the msp71xx
configuration ever since it was included in the linux-mips.org
repository.  This patch resolves compilation problems with attempting
to reset the board using non-existent GPIO routines.

This patch has been compile-tested against the current HEAD.

Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
---
 arch/mips/pmc-sierra/msp71xx/msp_setup.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/mips/pmc-sierra/msp71xx/msp_setup.c b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
index c936756..a54e85b 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_setup.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
@@ -21,7 +21,6 @@
 
 #if defined(CONFIG_PMC_MSP7120_GW)
 #include <msp_regops.h>
-#include <msp_gpio.h>
 #define MSP_BOARD_RESET_GPIO	9
 #endif
 
@@ -88,11 +87,8 @@ void msp7120_reset(void)
 	 * as GPIO char driver may not be enabled and it would look up
 	 * data inRAM!
 	 */
-	set_value_reg32(GPIO_CFG3_REG,
-			basic_mode_mask(MSP_BOARD_RESET_GPIO),
-			basic_mode(MSP_GPIO_OUTPUT, MSP_BOARD_RESET_GPIO));
-	set_reg32(GPIO_DATA3_REG,
-			basic_data_mask(MSP_BOARD_RESET_GPIO));
+	set_value_reg32(GPIO_CFG3_REG, 0xf000, 0x8000);
+	set_reg32(GPIO_DATA3_REG, 8);
 
 	/*
 	 * In case GPIO9 doesn't reset the board (jumper configurable!)
-- 
1.5.6.5
