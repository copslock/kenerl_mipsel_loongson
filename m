Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2005 22:08:09 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:48875 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8134456AbVKVWHv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Nov 2005 22:07:51 +0000
Received: from SSVLGW01.amd.com (ssvlgw01.amd.com [139.95.250.169])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id jAMM8WtS015680;
	Tue, 22 Nov 2005 14:10:28 -0800
Received: from 139.95.250.1 by SSVLGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Tue, 22 Nov 2005 14:10:14 -0800
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint.amd.com (8.12.8/8.12.8/AMD) with ESMTP id jAMMADZi025176; Tue,
 22 Nov 2005 14:10:14 -0800 (PST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 1E761201E; Tue, 22 Nov 2005
 15:10:13 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id jAMMFQnv005453; Tue, 22 Nov 2005 15:15:26
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id jAMMFQIH005452; Tue, 22 Nov 2005 15:15:26
 -0700
Date:	Tue, 22 Nov 2005 15:15:26 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Subject: [PATCH] Fix board type in db1x00
Message-ID: <20051122221526.GZ18119@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F9D48CC2VS8368369-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

Ok, one more one more from Sergei Shtylyov - add all the board types 
serviced by db1x00/init.c:

ALCHEMY:  Select correct machine type in db1x00
---

 arch/mips/au1000/db1x00/init.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/mips/au1000/db1x00/init.c b/arch/mips/au1000/db1x00/init.c
index 4b9d5e4..41e0522 100644
--- a/arch/mips/au1000/db1x00/init.c
+++ b/arch/mips/au1000/db1x00/init.c
@@ -61,7 +61,17 @@ void __init prom_init(void)
 	prom_envp = (char **) fw_arg2;
 
 	mips_machgroup = MACH_GROUP_ALCHEMY;
-	mips_machtype = MACH_DB1000;	/* set the platform # */
+
+	/* Set the platform # */
+#if	defined (CONFIG_MIPS_DB1550)
+	mips_machtype = MACH_DB1550;
+#elif	defined (CONFIG_MIPS_DB1500)
+	mips_machtype = MACH_DB1500;
+#elif	defined (CONFIG_MIPS_DB1100)
+	mips_machtype = MACH_DB1100;
+#else
+	mips_machtype = MACH_DB1000;
+#endif
 
 	prom_init_cmdline();
 
