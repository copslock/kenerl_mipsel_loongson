Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jan 2008 14:14:14 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:3731 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28579874AbYA3OOM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Jan 2008 14:14:12 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0UEE9Ui012693;
	Wed, 30 Jan 2008 14:14:09 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0UEE88K012692;
	Wed, 30 Jan 2008 14:14:08 GMT
Date:	Wed, 30 Jan 2008 14:14:08 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sam Ravnborg <sam@ravnborg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] Remove __INIT_REFOK and __INITDATA_REFOK
Message-ID: <20080130141408.GA6116@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Commit 312b1485fb509c9bc32eda28ad29537896658cb8 made __INIT_REFOK expand
into .section .section ".ref.text", "ax".  Since the assembler doesn't
tolerate stuttering in the source that broke all MIPS builds.

Since with this change Sam downgraded __INIT_REFOK to just a backward
compat thing and there being only a single use in the MIPS arch code the
best solution is to delete both of __INIT_REFOK and __INITDATA_REFOK (which
was equally broken) being unused anyway these can be deleted.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---

I'll send out the MIPS bits as part of my next pull request to Linus.

diff --git a/include/linux/init.h b/include/linux/init.h
index 2efbda0..90cdbbb 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -124,9 +124,6 @@
 #define __REF            .section       ".ref.text", "ax"
 #define __REFDATA        .section       ".ref.data", "aw"
 #define __REFCONST       .section       ".ref.rodata", "aw"
-/* backward compatibility */
-#define __INIT_REFOK     .section	__REF
-#define __INITDATA_REFOK .section	__REFDATA
 
 #ifndef __ASSEMBLY__
 /*
