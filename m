Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Apr 2009 10:31:34 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:54243 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28575365AbZDRJbB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 18 Apr 2009 10:31:01 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3I9Uveb017391;
	Sat, 18 Apr 2009 11:30:58 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3I9UusL017389;
	Sat, 18 Apr 2009 11:30:56 +0200
Date:	Sat, 18 Apr 2009 11:30:56 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] <linux/seccomp.h> needs to include <linux/errno.h>.
Message-ID: <20090418093056.GA17056@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

<linux/seccomp.h> uses EINVAL so should include <linux/errno.h>.  This
fixes a build error on 64-bit MIPS if CONFIG_SECCOMP is disabled.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 include/linux/seccomp.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 262a8dc..167c333 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -21,6 +21,8 @@ extern long prctl_set_seccomp(unsigned long);
 
 #else /* CONFIG_SECCOMP */
 
+#include <linux/errno.h>
+
 typedef struct { } seccomp_t;
 
 #define secure_computing(x) do { } while (0)
