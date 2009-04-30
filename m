Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2009 00:56:39 +0100 (BST)
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:60935 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026850AbZD3X4d (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2009 00:56:33 +0100
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n3UNrYHV016911;
	Thu, 30 Apr 2009 19:53:35 -0400 (EDT)
Received: from localhost (c-67-186-133-195.hsd1.ma.comcast.net [67.186.133.195])
	(authenticated bits=0)
        (User authenticated as tabbott@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n3UNrXp2011404;
	Thu, 30 Apr 2009 19:53:34 -0400 (EDT)
From:	Tim Abbott <tabbott@MIT.EDU>
To:	Sam Ravnborg <sam@ravnborg.org>
Cc:	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Anders Kaseorg <andersk@mit.edu>,
	Waseem Daher <wdaher@mit.edu>,
	Denys Vlasenko <vda.linux@googlemail.com>,
	Jeff Arnold <jbarnold@mit.edu>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Tim Abbott <tabbott@mit.edu>
Subject: [PATCH 3/4] mips: use new macros for .data.init_task.
Date:	Thu, 30 Apr 2009 19:53:29 -0400
Message-Id: <1241135610-9012-4-git-send-email-tabbott@mit.edu>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1241135610-9012-3-git-send-email-tabbott@mit.edu>
References: <1241135610-9012-1-git-send-email-tabbott@mit.edu>
 <1241135610-9012-2-git-send-email-tabbott@mit.edu>
 <1241135610-9012-3-git-send-email-tabbott@mit.edu>
X-Scanned-By: MIMEDefang 2.42
Return-Path: <tabbott@MIT.EDU>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tabbott@MIT.EDU
Precedence: bulk
X-list: linux-mips

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/init_task.c   |    5 ++---
 arch/mips/kernel/vmlinux.lds.S |    3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/init_task.c b/arch/mips/kernel/init_task.c
index 149cd91..30051b4 100644
--- a/arch/mips/kernel/init_task.c
+++ b/arch/mips/kernel/init_task.c
@@ -25,9 +25,8 @@ EXPORT_SYMBOL(init_mm);
  *
  * The things we do for performance..
  */
-union thread_union init_thread_union
-	__attribute__((__section__(".data.init_task"),
-	               __aligned__(THREAD_SIZE))) =
+union thread_union init_thread_union __init_task_data
+	__attribute__((__aligned__(THREAD_SIZE))) =
 		{ INIT_THREAD_INFO(init_task) };
 
 /*
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index ba459cb..85085e3 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -76,8 +76,7 @@ SECTIONS
 		 * of ‘init_thread_union’ is greater than maximum
 		 * object file alignment.  Using 32768
 		 */
-		. = ALIGN(_PAGE_SIZE);
-		*(.data.init_task)
+		INIT_TASK_DATA(_PAGE_SIZE)
 		NOSAVE_DATA
 		CACHELINE_ALIGNED_DATA(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
 		DATA_DATA
-- 
1.6.2.1
