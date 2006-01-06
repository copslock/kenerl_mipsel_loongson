Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2006 16:33:23 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:46768 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133585AbWAFQdF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jan 2006 16:33:05 +0000
Received: (qmail 5346 invoked from network); 6 Jan 2006 16:35:42 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 6 Jan 2006 16:35:42 -0000
Message-ID: <43BE9CED.3080207@ru.mvista.com>
Date:	Fri, 06 Jan 2006 19:38:05 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS <linux-mips@linux-mips.org>
CC:	Manish Lachwani <mlachwani@mvista.com>, ralf@linux-mips.org
Subject: [PATCH] Make KGDB compile again
Content-Type: multipart/mixed;
 boundary="------------030207070504090609040403"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------030207070504090609040403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

     The last commit to arch/mips/kernel/gdb-stub.c introduced a stupid typo
into the spinlock initializer, here's the fix...

WBR, Sergei


--------------030207070504090609040403
Content-Type: text/plain;
 name="KGDB-fix-spinlock-init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="KGDB-fix-spinlock-init.patch"

diff --git a/arch/mips/kernel/gdb-stub.c b/arch/mips/kernel/gdb-stub.c
index 96d18c4..0b2c44f 100644
--- a/arch/mips/kernel/gdb-stub.c
+++ b/arch/mips/kernel/gdb-stub.c
@@ -178,7 +178,7 @@ int kgdb_enabled;
  */
 static DEFINE_SPINLOCK(kgdb_lock);
 static raw_spinlock_t kgdb_cpulock[NR_CPUS] = {
-	[0 ... NR_CPUS-1] = __RAW_SPIN_LOCK_UNLOCKED;
+	[0 ... NR_CPUS-1] = __RAW_SPIN_LOCK_UNLOCKED
 };
 
 /*




--------------030207070504090609040403--
