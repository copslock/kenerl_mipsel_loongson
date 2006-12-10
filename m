Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Dec 2006 16:16:59 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:32482 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039260AbWLJQQx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 10 Dec 2006 16:16:53 +0000
Received: from localhost (p1056-ipad26funabasi.chiba.ocn.ne.jp [220.104.87.56])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6E218B62E; Mon, 11 Dec 2006 01:16:47 +0900 (JST)
Date:	Mon, 11 Dec 2006 01:16:47 +0900 (JST)
Message-Id: <20061211.011647.41196525.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix negative buffer overflow in copy_from_user
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
X-archive-position: 13422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

If we passed an invalid _and_ unaligned source address to
copy_from_user(), the fault handling code miscalculates a length of
uncopied bytes and returns a value greater than original length.  This
also causes an negative buffer overflow and overwrites some bytes just
before the destination kernel buffer.

This can happen "src_unaligned" case in memcpy.S.  If the first load
from source buffer was a LDFIRST/LDREST (L[WD][RL]) instruction, it
raise an exception and the THREAD_BUADDR will be an aligned address so
it will _smaller_ than its real target address.

For all case "src" register is smaller than its target load address
(ie. the offset of load instruction is always greater then zero), and
on the first load instruction "src" is always start of uncopied source
buffer, so we can fix the faulted address using the "src" value.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index a526c62..7b21bc9 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -434,6 +434,12 @@ l_exc:
 	 nop
 	LOAD	t0, THREAD_BUADDR(t0)	# t0 is just past last good address
 	 nop
+	/* If src was unaligned, t0 might be _smaller_ then src.  Fix it. */
+	slt	t1, t0, src
+	beqz	t1, 1f
+	 nop
+	move	t0, src
+1:
 	SUB	len, AT, t0		# len number of uncopied bytes
 	/*
 	 * Here's where we rely on src and dst being incremented in tandem,
