Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2006 12:52:44 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:47689 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133472AbWHBLwf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Aug 2006 12:52:35 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 2 Aug 2006 20:52:34 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 9DA7F20463;
	Wed,  2 Aug 2006 20:52:32 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 8A7A32040D;
	Wed,  2 Aug 2006 20:52:32 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k72BqVW0020977;
	Wed, 2 Aug 2006 20:52:32 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 02 Aug 2006 20:52:31 +0900 (JST)
Message-Id: <20060802.205231.02106717.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, vagabon.xyz@gmail.com
Subject: [PATCH] fix stack range checking in unwind_stack()
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
X-archive-position: 12159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Remove wrong division by sizeof(long).

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 8709a46..9f367a0 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -472,7 +472,7 @@ unsigned long unwind_stack(struct task_s
 		return 0;
 	}
 	if ((unsigned long)*sp < stack_page ||
-	    (unsigned long)*sp + info.frame_size / sizeof(long) >
+	    (unsigned long)*sp + info.frame_size >
 	    stack_page + THREAD_SIZE - 32)
 		return 0;
 
