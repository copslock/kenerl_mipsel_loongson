Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2017 20:52:22 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:48864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993981AbdCMTwOtiTCP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Mar 2017 20:52:14 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A1269ADA6;
        Mon, 13 Mar 2017 19:52:14 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     James Cowgill <James.Cowgill@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to 3.12-stable] MIPS: OCTEON: Fix copy_from_user fault handling for large buffers
Date:   Mon, 13 Mar 2017 20:51:15 +0100
Message-Id: <20170313195209.25177-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170313195209.25177-1-jslaby@suse.cz>
References: <20170313195209.25177-1-jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: James Cowgill <James.Cowgill@imgtec.com>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

commit 884b426917e4b3c85f33b382c792a94305dfdd62 upstream.

If copy_from_user is called with a large buffer (>= 128 bytes) and the
userspace buffer refers partially to unreadable memory, then it is
possible for Octeon's copy_from_user to report the wrong number of bytes
have been copied. In the case where the buffer size is an exact multiple
of 128 and the fault occurs in the last 64 bytes, copy_from_user will
report that all the bytes were copied successfully but leave some
garbage in the destination buffer.

The bug is in the main __copy_user_common loop in octeon-memcpy.S where
in the middle of the loop, src and dst are incremented by 128 bytes. The
l_exc_copy fault handler is used after this but that assumes that
"src < THREAD_BUADDR($28)". This is not the case if src has already been
incremented.

Fix by adding an extra fault handler which rewinds the src and dst
pointers 128 bytes before falling though to l_exc_copy.

Thanks to the pwritev test from the strace test suite for originally
highlighting this bug!

Fixes: 5b3b16880f40 ("MIPS: Add Cavium OCTEON processor support ...")
Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
Acked-by: David Daney <david.daney@cavium.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14978/
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/cavium-octeon/octeon-memcpy.S | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-memcpy.S b/arch/mips/cavium-octeon/octeon-memcpy.S
index 64e08df51d65..8b7004132491 100644
--- a/arch/mips/cavium-octeon/octeon-memcpy.S
+++ b/arch/mips/cavium-octeon/octeon-memcpy.S
@@ -208,18 +208,18 @@ EXC(	STORE	t2, UNIT(6)(dst),	s_exc_p10u)
 	ADD	src, src, 16*NBYTES
 EXC(	STORE	t3, UNIT(7)(dst),	s_exc_p9u)
 	ADD	dst, dst, 16*NBYTES
-EXC(	LOAD	t0, UNIT(-8)(src),	l_exc_copy)
-EXC(	LOAD	t1, UNIT(-7)(src),	l_exc_copy)
-EXC(	LOAD	t2, UNIT(-6)(src),	l_exc_copy)
-EXC(	LOAD	t3, UNIT(-5)(src),	l_exc_copy)
+EXC(	LOAD	t0, UNIT(-8)(src),	l_exc_copy_rewind16)
+EXC(	LOAD	t1, UNIT(-7)(src),	l_exc_copy_rewind16)
+EXC(	LOAD	t2, UNIT(-6)(src),	l_exc_copy_rewind16)
+EXC(	LOAD	t3, UNIT(-5)(src),	l_exc_copy_rewind16)
 EXC(	STORE	t0, UNIT(-8)(dst),	s_exc_p8u)
 EXC(	STORE	t1, UNIT(-7)(dst),	s_exc_p7u)
 EXC(	STORE	t2, UNIT(-6)(dst),	s_exc_p6u)
 EXC(	STORE	t3, UNIT(-5)(dst),	s_exc_p5u)
-EXC(	LOAD	t0, UNIT(-4)(src),	l_exc_copy)
-EXC(	LOAD	t1, UNIT(-3)(src),	l_exc_copy)
-EXC(	LOAD	t2, UNIT(-2)(src),	l_exc_copy)
-EXC(	LOAD	t3, UNIT(-1)(src),	l_exc_copy)
+EXC(	LOAD	t0, UNIT(-4)(src),	l_exc_copy_rewind16)
+EXC(	LOAD	t1, UNIT(-3)(src),	l_exc_copy_rewind16)
+EXC(	LOAD	t2, UNIT(-2)(src),	l_exc_copy_rewind16)
+EXC(	LOAD	t3, UNIT(-1)(src),	l_exc_copy_rewind16)
 EXC(	STORE	t0, UNIT(-4)(dst),	s_exc_p4u)
 EXC(	STORE	t1, UNIT(-3)(dst),	s_exc_p3u)
 EXC(	STORE	t2, UNIT(-2)(dst),	s_exc_p2u)
@@ -383,6 +383,10 @@ done:
 	 nop
 	END(memcpy)
 
+l_exc_copy_rewind16:
+	/* Rewind src and dst by 16*NBYTES for l_exc_copy */
+	SUB	src, src, 16*NBYTES
+	SUB	dst, dst, 16*NBYTES
 l_exc_copy:
 	/*
 	 * Copy bytes from src until faulting load address (or until a
-- 
2.12.0
