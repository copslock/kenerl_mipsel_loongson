Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2005 21:04:38 +0000 (GMT)
Received: from [85.21.88.2] ([85.21.88.2]:38845 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8133749AbVJaVEU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2005 21:04:20 +0000
Received: (qmail 18455 invoked from network); 31 Oct 2005 21:04:48 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 31 Oct 2005 21:04:48 -0000
Message-ID: <4366875B.7050400@ru.mvista.com>
Date:	Tue, 01 Nov 2005 00:06:35 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS Development <linux-mips@linux-mips.org>
CC:	Manish Lachwani <mlachwani@mvista.com>,
	Pete Popov <ppopov@embeddedalley.com>
Subject: [PATCH] Set proper machine type for DB1xx0 boards
References: <4357F774.9010208@ru.mvista.com> <435A9FB2.3070303@ru.mvista.com>
In-Reply-To: <435A9FB2.3070303@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------010901040200060807020102"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010901040200060807020102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello, I wrote:

>>     Here's a couple of DBAu1550 fixes: the first one fixes BCSR 
>> accesses in
>> the board setup/reset code (the registers are actually 16-bit, and their
>> addresses are different between DBAu1550 and other DBAu1xx0 boards), the

>    Here's an updated BCSR patch. Stupid typo. :-/

>> second one just selects the proper machine type for DBAu1550.

>   It was somewhat incomplete, more #ifdef's are needed to set the proper 
> machine types for DB1100/DB1500...

      So, here's an update...

WBR, Sergei


--------------010901040200060807020102
Content-Type: text/plain;
 name="DBAu1xx0-platform.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DBAu1xx0-platform.patch"

Index: arch/mips/au1000/db1x00/init.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/db1x00/init.c,v
retrieving revision 1.6
diff -a -u -p -r1.6 init.c
--- arch/mips/au1000/db1x00/init.c	11 Jul 2005 10:03:24 -0000	1.6
+++ arch/mips/au1000/db1x00/init.c	31 Oct 2005 21:01:26 -0000
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
 



--------------010901040200060807020102--
