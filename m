Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 17:52:41 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1615 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991859AbdAIQwfJjXWy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 17:52:35 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id AE03135E41907;
        Mon,  9 Jan 2017 16:52:25 +0000 (GMT)
Received: from [10.150.130.85] (10.150.130.85) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 9 Jan
 2017 16:52:28 +0000
From:   James Cowgill <James.Cowgill@imgtec.com>
Subject: [PATCH] MIPS: OCTEON: Fix copy_from_user fault handling for large
 buffers
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>
Message-ID: <ede411ad-ee19-e4e4-e6a2-585a85c640db@imgtec.com>
Date:   Mon, 9 Jan 2017 16:52:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.85]
Return-Path: <James.Cowgill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Cowgill@imgtec.com
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

Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
Cc: stable@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/cavium-octeon/octeon-memcpy.S | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-memcpy.S b/arch/mips/cavium-octeon/octeon-memcpy.S
index 64e08df51d65..4668537b09c2 100644
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
2.11.0
