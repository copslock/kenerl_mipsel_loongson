Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2009 00:54:06 +0100 (BST)
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:60448 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026838AbZD3XyA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2009 00:54:00 +0100
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n3UNrWHT016874;
	Thu, 30 Apr 2009 19:53:33 -0400 (EDT)
Received: from localhost (c-67-186-133-195.hsd1.ma.comcast.net [67.186.133.195])
	(authenticated bits=0)
        (User authenticated as tabbott@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n3UNrVn7011398;
	Thu, 30 Apr 2009 19:53:32 -0400 (EDT)
From:	Tim Abbott <tabbott@MIT.EDU>
To:	Sam Ravnborg <sam@ravnborg.org>
Cc:	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Anders Kaseorg <andersk@mit.edu>,
	Waseem Daher <wdaher@mit.edu>,
	Denys Vlasenko <vda.linux@googlemail.com>,
	Jeff Arnold <jbarnold@mit.edu>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Tim Abbott <tabbott@mit.edu>
Subject: [PATCH 1/4] mips: use NOSAVE_DATA macro for .data.nosave section.
Date:	Thu, 30 Apr 2009 19:53:27 -0400
Message-Id: <1241135610-9012-2-git-send-email-tabbott@mit.edu>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1241135610-9012-1-git-send-email-tabbott@mit.edu>
References: <1241135610-9012-1-git-send-email-tabbott@mit.edu>
X-Scanned-By: MIMEDefang 2.42
Return-Path: <tabbott@MIT.EDU>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tabbott@MIT.EDU
Precedence: bulk
X-list: linux-mips

This has the consequence of replacing the alignment of _PAGE_SIZE with
an alignment of PAGE_SIZE.  I believe these have the same value.

.data.nosave should not need a separate output section; this change
moves it into the .data section.

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/vmlinux.lds.S |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 58738c8..2a6a995 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -78,7 +78,7 @@ SECTIONS
 		 */
 		. = ALIGN(_PAGE_SIZE);
 		*(.data.init_task)
-
+		NOSAVE_DATA
 		DATA_DATA
 		CONSTRUCTORS
 	}
@@ -96,14 +96,6 @@ SECTIONS
 		*(.sdata)
 	}
 
-	. = ALIGN(_PAGE_SIZE);
-	.data_nosave : {
-		__nosave_begin = .;
-		*(.data.nosave)
-	}
-	. = ALIGN(_PAGE_SIZE);
-	__nosave_end = .;
-
 	. = ALIGN(1 << CONFIG_MIPS_L1_CACHE_SHIFT);
 	.data.cacheline_aligned : {
 		*(.data.cacheline_aligned)
-- 
1.6.2.1
