Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2012 22:23:55 +0200 (CEST)
Received: from relay1.mentorg.com ([192.94.38.131]:36455 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903378Ab2IMUXp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Sep 2012 22:23:45 +0200
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
        by relay1.mentorg.com with esmtp 
        id 1TCFwn-0006fK-Tp from Maciej_Rozycki@mentor.com ; Thu, 13 Sep 2012 13:23:37 -0700
Received: from SVR-IES-FEM-01.mgc.mentorg.com ([137.202.0.104]) by svr-orw-fem-01.mgc.mentorg.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 13 Sep 2012 13:23:37 -0700
Received: from [172.30.7.121] (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
 (137.202.0.104) with Microsoft SMTP Server id 14.1.289.1; Thu, 13 Sep 2012
 21:23:35 +0100
Date:   Thu, 13 Sep 2012 21:23:25 +0100
From:   "Maciej W. Rozycki" <macro@codesourcery.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Malta: Remove RTC Data Mode bootstrap breakage
Message-ID: <alpine.DEB.1.10.1209132106000.28358@tp.orcam.me.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-OriginalArrivalTime: 13 Sep 2012 20:23:37.0786 (UTC) FILETIME=[A82499A0:01CD91ED]
X-archive-position: 34494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Status: A


 YAMON requires and enforces the RTC Data Mode (Register B, DM bit) to 
binary, that is the bit is set every time the board goes through the 
firmware bootstrap sequence.  Likewise its calendar manipulation commands 
interpret or set the RTC registers unconditionally as binary, never 
actually checking what the value of the DM bit is, under the (correct) 
assumption that it has been previously set, to indicate the binary mode.

 A change to Linux a while ago however introduced a platform-specific 
tweak that clears that bit and therefore forces the data mode to BCD.  
This causes clock corruption and misinterpretation that has to be fixed up 
by user-mode tools in system startup scripts as the initial clock is often 
incorrect according to the BCD interpretation forced.

 This change removes the hack; a comment included refers to alarm code, 
but even if it was broken at one point by requiring the BCD mode, it 
should have been trivially corrected and even if not, given how rarely the 
alarm feature is used, that was not really a reasonable justification to 
break the system clock that is indeed used by virtually everything.  And 
either way the alarm code has been since fixed anyway.

Signed-off-by: Maciej W. Rozycki <macro@codesourcery.com>
---

 Please apply -- this ends a long battle trying to track down where the 
annoying clock corruption has come from.

  Maciej

linux-malta-rtc.diff
diff --git a/arch/mips/mti-malta/malta-platform.c b/arch/mips/mti-malta/malta-platform.c
index 4c35301..80562b8 100644
--- a/arch/mips/mti-malta/malta-platform.c
+++ b/arch/mips/mti-malta/malta-platform.c
@@ -138,11 +138,6 @@ static int __init malta_add_devices(void)
 	if (err)
 		return err;
 
-	/*
-	 * Set RTC to BCD mode to support current alarm code.
-	 */
-	CMOS_WRITE(CMOS_READ(RTC_CONTROL) & ~RTC_DM_BINARY, RTC_CONTROL);
-
 	return 0;
 }
 
