Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2009 19:31:16 +0100 (BST)
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:37324 "EHLO
	rtp-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024689AbZE2Sar (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 May 2009 19:30:47 +0100
X-IronPort-AV: E=Sophos;i="4.41,272,1241395200"; 
   d="scan'208";a="45565959"
Received: from rtp-dkim-1.cisco.com ([64.102.121.158])
  by rtp-iport-2.cisco.com with ESMTP; 29 May 2009 18:30:40 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by rtp-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id n4TIUeVV026951;
	Fri, 29 May 2009 14:30:40 -0400
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id n4TIUeDj016487;
	Fri, 29 May 2009 18:30:40 GMT
Date:	Fri, 29 May 2009 11:30:40 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2/3] mips:powertv: Make kernel command line size
	configurable (resend)
Message-ID: <20090529183040.GA12481@cuplxvomd02.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1381; t=1243621840; x=1244485840;
	c=relaxed/simple; s=rtpdkim1001;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20[PATCH=202/3]=20mips=3Apowertv=3A=20Make=20kern
	el=20command=20line=20size=0A=09configurable=20(resend)
	|Sender:=20
	|To:=20linux-mips@linux-mips.org;
	bh=QChCafKFKQZR0MXfTBpj7rhqJBTpk+ar6Cou0Tf900A=;
	b=PzzS8DFkBM7zpNV5ZfzZVz46KBlwnR0In7FZDrXVWTA2lRAsdvf4EllgFO
	xDTj0Tj8oNZqMg0xl05JPFSXE3st4IreOPbOKDpbpLZO8ZRAC8qWsxq970+b
	Xi1RrT6lP+;
Authentication-Results:	rtp-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/rtpdkim1001 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23067
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
