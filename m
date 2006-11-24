Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Nov 2006 15:01:00 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:23283 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038978AbWKXPAz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Nov 2006 15:00:55 +0000
Received: from localhost (p6014-ipad01funabasi.chiba.ocn.ne.jp [61.207.80.14])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 996B7B7AC; Sat, 25 Nov 2006 00:00:50 +0900 (JST)
Date:	Sat, 25 Nov 2006 00:03:34 +0900 (JST)
Message-Id: <20061125.000334.75185150.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 0/3] fix and cleanup FPU ownership management
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
X-archive-position: 13252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This patchset fixes several potential problem related FPU ownership
management.  The main problem is
save_fp_contect()/restore_fp_context() might sleep on accessing user
stack and therefore might lose FPU ownership in middle of them.

The first patch ("do_fpe() cleanup") is just a cleanup to preparation.

The second patch ("Allow CpU exception in kernel partially") is main
part.  This is an alternative of the patch posted before:
http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20060829.225631.41630441.anemo%40mba.ocn.ne.jp

The third patch ("Cleanup FPU ownership management") is an another
cleanup and get rid of most preempt_disable()/preempt_enable() pairs
around.


Please review.  Thank you.

---
Atsushi Nemoto
