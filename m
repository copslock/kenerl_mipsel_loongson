Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2018 17:30:37 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40203 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990509AbeJNPa0pEEHA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Oct 2018 17:30:26 +0200
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0004cf-IB; Sun, 14 Oct 2018 16:30:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLT-0000MK-1y; Sun, 14 Oct 2018 16:30:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Matt Redfearn" <matt.redfearn@mips.com>,
        "James Hogan" <jhogan@kernel.org>,
        "Chuanhua Lei" <chuanhua.lei@intel.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.226474109@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 161/366] MIPS: memset.S: EVA & fault support for
 small_memset
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66831
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

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@mips.com>

commit 8a8158c85e1e774a44fbe81106fa41138580dfd1 upstream.

The MIPS kernel memset / bzero implementation includes a small_memset
branch which is used when the region to be set is smaller than a long (4
bytes on 32bit, 8 bytes on 64bit). The current small_memset
implementation uses a simple store byte loop to write the destination.
There are 2 issues with this implementation:

1. When EVA mode is active, user and kernel address spaces may overlap.
Currently the use of the sb instruction means kernel mode addressing is
always used and an intended write to userspace may actually overwrite
some critical kernel data.

2. If the write triggers a page fault, for example by calling
__clear_user(NULL, 2), instead of gracefully handling the fault, an OOPS
is triggered.

Fix these issues by replacing the sb instruction with the EX() macro,
which will emit EVA compatible instuctions as required. Additionally
implement a fault fixup for small_memset which sets a2 to the number of
bytes that could not be cleared (as defined by __clear_user).

Reported-by: Chuanhua Lei <chuanhua.lei@intel.com>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18975/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/lib/memset.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -178,7 +178,7 @@
 1:	PTR_ADDIU	a0, 1			/* fill bytewise */
 	R10KCBARRIER(0(ra))
 	bne		t1, a0, 1b
-	sb		a1, -1(a0)
+	 EX(sb, a1, -1(a0), .Lsmall_fixup\@)
 
 2:	jr		ra			/* done */
 	move		a2, zero
@@ -212,6 +212,11 @@
 	jr		ra
 	andi		v1, a2, STORMASK
 
+.Lsmall_fixup\@:
+	PTR_SUBU	a2, t1, a0
+	jr		ra
+	 PTR_ADDIU	a2, 1
+
 	.endm
 
 /*
