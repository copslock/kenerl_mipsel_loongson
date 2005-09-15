Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Sep 2005 17:16:31 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:25583 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225326AbVIOQQC>; Thu, 15 Sep 2005 17:16:02 +0100
Received: from localhost (p4183-ipad27funabasi.chiba.ocn.ne.jp [220.107.195.183])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A4B2F85C1; Fri, 16 Sep 2005 01:15:57 +0900 (JST)
Date:	Fri, 16 Sep 2005 01:17:38 +0900 (JST)
Message-Id: <20050916.011738.41198368.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: unkillable process due to setup_frame() failure
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050907.234413.108737010.anemo@mba.ocn.ne.jp>
References: <Pine.LNX.4.61L.0509071011560.4591@blysk.ds.pg.gda.pl>
	<20050907134717.GA3493@linux-mips.org>
	<20050907.234413.108737010.anemo@mba.ocn.ne.jp>
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
X-archive-position: 8960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 07 Sep 2005 23:44:13 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> So my "which is preferred" question was inappropriate.  I had
anemo> to ask "#1 or #2 or both or other ?"

In 2.6.14-rc1, another fix is done in arch/i386/kernel/entry.S.
It also fixes a race condition in signal delivery.

>    [PATCH] i386: Don't miss pending signals returning to user mode after signal processing
>    
>    Signed-off-by: Roland McGrath <roland@redhat.com>

Let's follow.

--- linux-mips/arch/mips/kernel/entry.S	2005-03-04 22:17:29.000000000 +0900
+++ linux/arch/mips/kernel/entry.S	2005-09-16 01:04:52.365022536 +0900
@@ -105,7 +105,7 @@
 	move	a0, sp
 	li	a1, 0
 	jal	do_notify_resume	# a2 already loaded
-	j	restore_all
+	j	resume_userspace
 
 FEXPORT(syscall_exit_work_partial)
 	SAVE_STATIC

---
Atsushi Nemoto
