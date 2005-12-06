Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2005 18:02:51 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:17719 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133676AbVLFSCd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Dec 2005 18:02:33 +0000
Received: from [192.168.12.17] ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id jB6I2Et18499;
	Tue, 6 Dec 2005 22:02:14 +0400
Message-ID: <4395D226.9070807@ru.mvista.com>
Date:	Tue, 06 Dec 2005 21:02:14 +0300
From:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	ralf@linux-mips.org
CC:	linux-mips@linux-mips.org, ppopov@embeddedalley.com
Subject: [PATCH] Philips PNX8550 command line patch
Content-Type: multipart/mixed;
 boundary="------------050303010409080505070605"
Return-Path: <vbarinov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbarinov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050303010409080505070605
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hello Ralf,

This patch makes passing command line from bootloader for Philips 
PNX8550 platform.
Does it makes sense to commit this patch?

Vladimir

--------------050303010409080505070605
Content-Type: text/plain;
 name="cmdline.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cmdline.patch"

--- linux-2.6.15/arch/mips/philips/pnx8550/jbs/init.c	2005-12-02 16:37:59.000000000 +0300
+++ linux-2.6.15/arch/mips/philips/pnx8550/jbs/init.c	2005-12-06 13:12:22.000000000 +0300
@@ -47,6 +47,11 @@ void __init prom_init(void)
 {
 
 	unsigned long memsize;
+	prom_argc = (int) fw_arg0;
+	prom_argv = (char **) fw_arg1;
+	prom_envp = (char **) fw_arg2;
+
+	prom_init_cmdline();
 
 	mips_machgroup = MACH_GROUP_PHILIPS;
 	mips_machtype = MACH_PHILIPS_JBS;
--- linux-2.6.15/arch/mips/philips/pnx8550/common/prom.c	2005-12-02 16:37:59.000000000 +0300
+++ linux-2.6.15/arch/mips/philips/pnx8550/common/prom.c	2005-12-06 13:48:10.000000000 +0300
@@ -35,23 +35,15 @@ char * prom_getcmdline(void)
 	return &(arcs_cmdline[0]);
 }
 
-void  prom_init_cmdline(void)
+void __init prom_init_cmdline(void)
 {
-	char *cp;
-	int actr;
-
-	actr = 1; /* Always ignore argv[0] */
+	int i;
 
-	cp = &(arcs_cmdline[0]);
-	while(actr < prom_argc) {
-	        strcpy(cp, prom_argv[actr]);
-		cp += strlen(prom_argv[actr]);
-		*cp++ = ' ';
-		actr++;
+	arcs_cmdline[0] = '\0';
+	for (i = 0; i < prom_argc; i++) {
+		strcat(arcs_cmdline, prom_argv[i]);
+		strcat(arcs_cmdline, " ");
 	}
-	if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
-		--cp;
-	*cp = '\0';
 }
 
 char *prom_getenv(char *envname)

--------------050303010409080505070605--
