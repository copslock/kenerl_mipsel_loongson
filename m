Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2005 07:32:09 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:27934 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8133452AbVKXHbu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 Nov 2005 07:31:50 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 24 Nov 2005 07:35:48 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 35FC4200B0;
	Thu, 24 Nov 2005 16:35:44 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 215F41FFB9;
	Thu, 24 Nov 2005 16:35:44 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id jAO7Zh4D081281;
	Thu, 24 Nov 2005 16:35:44 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 24 Nov 2005 16:35:42 +0900 (JST)
Message-Id: <20051124.163542.66180964.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] gdb-stub.c build fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Remove a semicolon to fix build error.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/gdb-stub.c b/arch/mips/kernel/gdb-stub.c
index 96d18c4..9fedfa4 100644
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
