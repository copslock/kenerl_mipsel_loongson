Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 15:54:54 +0100 (BST)
Received: from 67-121-164-6.ded.pacbell.net ([IPv6:::ffff:67.121.164.6]:61945
	"EHLO mailserver.sunrisetelecom.com") by linux-mips.org with ESMTP
	id <S8225244AbUJNOyu>; Thu, 14 Oct 2004 15:54:50 +0100
Received: from sunrisetelecom.com ([192.168.50.222]) by mailserver.sunrisetelecom.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 14 Oct 2004 07:54:43 -0700
Message-ID: <416E92CD.4020202@sunrisetelecom.com>
Date: Thu, 14 Oct 2004 10:53:01 -0400
From: Karl Lessard <klessard@sunrisetelecom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: linux-mips <linux-mips@linux-mips.org>
Subject: Patch for prom envp
Content-Type: multipart/mixed;
 boundary="------------040303060302030709000600"
X-OriginalArrivalTime: 14 Oct 2004 14:54:43.0953 (UTC) FILETIME=[BDA16610:01C4B1FD]
Return-Path: <klessard@sunrisetelecom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: klessard@sunrisetelecom.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040303060302030709000600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this small patch fix some heavy crashes when a board bootup and tries to
use the vector argument as the environnement variable.

Thanks,
Karl




--------------040303060302030709000600
Content-Type: text/plain;
 name="prom-envp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prom-envp.patch"

diff -urp linux-mips/arch/mips/au1000/pb1100/init.c linux/arch/mips/au1000/pb1100/init.c
--- linux-mips/arch/mips/au1000/pb1100/init.c	Mon Nov 17 20:17:46 2003
+++ linux/arch/mips/au1000/pb1100/init.c	Thu Oct 14 10:11:42 2004
@@ -53,7 +53,7 @@ void __init prom_init(void)
 
 	prom_argc = fw_arg0;
 	prom_argv = (char **) fw_arg1;
-	prom_envp = (int *) fw_arg3;
+	prom_envp = (int *) fw_arg2;
 
 	mips_machgroup = MACH_GROUP_ALCHEMY;
 	mips_machtype = MACH_PB1100;
diff -urp linux-mips/arch/mips/ite-boards/ivr/init.c linux/arch/mips/ite-boards/ivr/init.c
--- linux-mips/arch/mips/ite-boards/ivr/init.c	Mon Nov 17 20:17:46 2003
+++ linux/arch/mips/ite-boards/ivr/init.c	Thu Oct 14 10:19:09 2004
@@ -60,7 +60,7 @@ void __init prom_init(void)
 
 	prom_argc = fw_arg0;
 	prom_argv = (char **) fw_arg1;
-	prom_envp = (int *) fw_arg3;
+	prom_envp = (int *) fw_arg2;
 
 	mips_machgroup = MACH_GROUP_GLOBESPAN;
 	mips_machtype = MACH_IVR;  /* Globespan's iTVC15 reference board */
diff -urp linux-mips/arch/mips/ite-boards/qed-4n-s01b/init.c linux/arch/mips/ite-boards/qed-4n-s01b/init.c
--- linux-mips/arch/mips/ite-boards/qed-4n-s01b/init.c	Mon Nov 17 20:17:46 2003
+++ linux/arch/mips/ite-boards/qed-4n-s01b/init.c	Thu Oct 14 10:19:33 2004
@@ -60,7 +60,7 @@ void __init prom_init(void)
 
 	prom_argc = fw_arg0;
 	prom_argv = (char **) fw_arg1;
-	prom_envp = (int *) fw_arg3;
+	prom_envp = (int *) fw_arg2;
 
 	mips_machgroup = MACH_GROUP_ITE;
 	mips_machtype = MACH_QED_4N_S01B;  /* ITE board name/number */


--------------040303060302030709000600--
