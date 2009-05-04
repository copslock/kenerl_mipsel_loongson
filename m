Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 May 2009 23:57:35 +0100 (BST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:2633 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023529AbZEDW53 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 4 May 2009 23:57:29 +0100
X-IronPort-AV: E=Sophos;i="4.40,293,1238976000"; 
   d="scan'208";a="180713250"
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-1.cisco.com with ESMTP; 04 May 2009 22:57:19 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id n44MvImh009583;
	Mon, 4 May 2009 15:57:18 -0700
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id n44MvIFv000039;
	Mon, 4 May 2009 22:57:18 GMT
Date:	Mon, 4 May 2009 15:57:19 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2/3] mips:powertv: Make kernel command line size
	configurable (resend)
Message-ID: <20090504225719.GA22417@cuplxvomd02.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1381; t=1241477839; x=1242341839;
	c=relaxed/simple; s=sjdkim1004;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20[PATCH=202/3]=20mips=3Apowertv=3A=20Make=20kern
	el=20command=20line=20size=0A=09configurable=20(resend)
	|Sender:=20;
	bh=QChCafKFKQZR0MXfTBpj7rhqJBTpk+ar6Cou0Tf900A=;
	b=JE3748NyVpfuSNTDJOKAq7oHAEWGsJ7cbkgfNxaqEPzE5Dc2SuP28hrPrj
	ucAWDFKrP9zuz0ETXKHACsTv90e4TgLeCf03bEQpPf2lMtZvB0L+25C0QrFB
	FBgwPhv88YpSK5AibtegJ1rc1W3qVCXr22IxQ7k3zKMRVZlXjmLWA=;
Authentication-Results:	sj-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1004 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Most platforms can get by perfectly well with the default command line size,
but some platforms need more. This patch allows the command line size to
be configured for those platforms that need it. The default remains 256
characters.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/mips/Kconfig             |    7 +++++++
 arch/mips/include/asm/setup.h |    2 +-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 998e5db..99f7b6d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -780,6 +780,13 @@ config EARLY_PRINTK
 config SYS_HAS_EARLY_PRINTK
 	bool
 
+config COMMAND_LINE_SIZE
+	int "Maximum size of command line passed to kernel from bootloader"
+	default 256
+	help
+	  Most systems work well with the default value, but some bootloaders pass more
+	  information on the command line than others. A smaller value is good here.
+
 config HOTPLUG_CPU
 	bool
 	default n
diff --git a/arch/mips/include/asm/setup.h b/arch/mips/include/asm/setup.h
index e600ced..132e397 100644
--- a/arch/mips/include/asm/setup.h
+++ b/arch/mips/include/asm/setup.h
@@ -1,7 +1,7 @@
 #ifndef _MIPS_SETUP_H
 #define _MIPS_SETUP_H
 
-#define COMMAND_LINE_SIZE	256
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
 
 #ifdef  __KERNEL__
 extern void setup_early_printk(void);
