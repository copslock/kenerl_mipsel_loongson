Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2017 10:12:11 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37142 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992236AbdCJJLrPcwbm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Mar 2017 10:11:47 +0100
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4A573B2A;
        Fri, 10 Mar 2017 09:11:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Cowgill <James.Cowgill@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.4 03/91] MIPS: OCTEON: Fix copy_from_user fault handling for large buffers
Date:   Fri, 10 Mar 2017 10:08:02 +0100
Message-Id: <20170310083900.909377010@linuxfoundation.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170310083900.730556986@linuxfoundation.org>
References: <20170310083900.730556986@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/cavium-octeon/octeon-memcpy.S |   20 ++++++++++++--------
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
