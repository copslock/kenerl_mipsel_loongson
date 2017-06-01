Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jun 2017 17:49:11 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37457 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993996AbdFAPpDw4L0- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jun 2017 17:45:03 +0200
Received: from 82-70-136-246.dsl.in-addr.zen.co.uk ([82.70.136.246] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1dGSHW-000599-Nc; Thu, 01 Jun 2017 16:45:03 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1dGSHV-0007rE-KZ; Thu, 01 Jun 2017 16:45:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "James Cowgill" <James.Cowgill@imgtec.com>,
        linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "David Daney" <david.daney@cavium.com>,
        "James Hogan" <james.hogan@imgtec.com>
Date:   Thu, 01 Jun 2017 16:43:16 +0100
Message-ID: <lsq.1496331796.502932910@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 134/212] MIPS: OCTEON: Fix copy_from_user fault
 handling for large buffers
In-Reply-To: <lsq.1496331794.574686034@decadent.org.uk>
X-SA-Exim-Connect-IP: 82.70.136.246
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.44-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: James Cowgill <James.Cowgill@imgtec.com>

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/cavium-octeon/octeon-memcpy.S | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

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
