Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Apr 2006 15:22:05 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:37568 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133618AbWDUOVz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Apr 2006 15:21:55 +0100
Received: from localhost (p2209-ipad34funabasi.chiba.ocn.ne.jp [124.85.59.209])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E5CAE9478; Fri, 21 Apr 2006 23:34:41 +0900 (JST)
Date:	Fri, 21 Apr 2006 23:35:11 +0900 (JST)
Message-Id: <20060421.233511.82352266.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix oprofile module unloading
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

When unloading oprofile module with timer-mode, oprofile_arch_exit
dereferences a NULL pointer.  This patch fixes it and also fix a
sparse warning.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index 935dd85..f2b4862 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -27,7 +27,7 @@ static int op_mips_setup(void)
 	model->reg_setup(ctr);
 
 	/* Configure the registers on all cpus.  */
-	on_each_cpu(model->cpu_setup, 0, 0, 1);
+	on_each_cpu(model->cpu_setup, NULL, 0, 1);
 
         return 0;
 }
@@ -114,5 +114,6 @@ int __init oprofile_arch_init(struct opr
 
 void oprofile_arch_exit(void)
 {
-	model->exit();
+	if (model)
+		model->exit();
 }
