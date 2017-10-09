Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2017 14:46:47 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51812 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992675AbdJIMpLVf2eY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Oct 2017 14:45:11 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1XQh-0004v9-M1; Mon, 09 Oct 2017 13:45:08 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1XQa-0002Jw-I5; Mon, 09 Oct 2017 13:45:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "James Hogan" <james.hogan@imgtec.com>
Date:   Mon, 09 Oct 2017 13:30:34 +0100
Message-ID: <lsq.1507552234.970886519@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 17/74] MIPS: Fix mips_atomic_set() retry condition
In-Reply-To: <lsq.1507552233.547064726@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60332
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

3.2.94-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 2ec420b26f7b6ff332393f0bb5a7d245f7ad87f0 upstream.

The inline asm retry check in the MIPS_ATOMIC_SET operation of the
sysmips system call has been backwards since commit f1e39a4a616c ("MIPS:
Rewrite sysmips(MIPS_ATOMIC_SET, ...) in C with inline assembler")
merged in v2.6.32, resulting in the non R10000_LLSC_WAR case retrying
until the operation was inatomic, before returning the new value that
was probably just written multiple times instead of the old value.

Invert the branch condition to fix that particular issue.

Fixes: f1e39a4a616c ("MIPS: Rewrite sysmips(MIPS_ATOMIC_SET, ...) in C with inline assembler")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16148/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -203,7 +203,7 @@ static inline int mips_atomic_set(struct
 		"1:	ll	%[old], (%[addr])			\n"
 		"	move	%[tmp], %[new]				\n"
 		"2:	sc	%[tmp], (%[addr])			\n"
-		"	bnez	%[tmp], 4f				\n"
+		"	beqz	%[tmp], 4f				\n"
 		"3:							\n"
 		"	.subsection 2					\n"
 		"4:	b	1b					\n"
