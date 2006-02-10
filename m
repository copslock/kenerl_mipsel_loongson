Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2006 16:30:47 +0000 (GMT)
Received: from mail.baslerweb.com ([145.253.187.130]:10541 "EHLO
	mail.baslerweb.com") by ftp.linux-mips.org with ESMTP
	id S3467599AbWBJQaf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Feb 2006 16:30:35 +0000
Received: (from mail@localhost)
	by mail.baslerweb.com (8.12.10/8.12.10) id k1AGZ2cn019249
	for <linux-mips@linux-mips.org>; Fri, 10 Feb 2006 17:35:02 +0100
Received: from unknown by gateway id /processing/kwHJ5xVG; Fri Feb 10 17:34:51 2006
Received: from vclinux-1.basler.corp (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 1TF84RSD; Fri, 10 Feb 2006 17:36:23 +0100
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To:	linux-mips@linux-mips.org
Date:	Fri, 10 Feb 2006 17:36:27 +0100
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Message-Id: <200602101736.27563.thomas.koeller@baslerweb.com>
Subject: [PATCH] RM9000 icache problem
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

The code to work around the RM9000 icache problems is wrong and
ineffective. The patch below fixes that.

Signed-off-by: Thomas Koeller  <thomas.koeller@baslerweb.com>

--- linux.git/arch/mips/kernel/signal-common.h	2005-11-02 13:21:29.000000000 +0100
+++ linux-2.6.14-5/arch/mips/kernel/signal-common.h	2006-02-10 12:48:50.000000000 +0100
@@ -176,7 +176,7 @@
 	if ((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags (sp) == 0))
 		sp = current->sas_ss_sp + current->sas_ss_size;
 
-	return (void *)((sp - frame_size) & (ICACHE_REFILLS_WORKAROUND_WAR ? 32 : ALMASK));
+	return (void *)((sp - frame_size) & (ICACHE_REFILLS_WORKAROUND_WAR ? ~(cpu_icache_line_size()-1) : ALMASK));
 }
 
 static inline int install_sigtramp(unsigned int __user *tramp,



-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
