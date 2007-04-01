Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Apr 2007 13:23:25 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.169]:10000 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022092AbXDAMXV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 1 Apr 2007 13:23:21 +0100
Received: by ug-out-1314.google.com with SMTP id 40so1414217uga
        for <linux-mips@linux-mips.org>; Sun, 01 Apr 2007 05:22:21 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=OIsOnIc/nn72fyNsbYZyrwp/5+yFw2AZAsZF6rmT+m/YXfF/xoKeZcpryT9skF8fCFd25tanLpWtRQiwqAHUr+LvQbYDk3A/O2ctA/skdJgGSRgQfORzcnSh+sJZPkNkvreNPmu3MXmaDD7jcQXXxCpF+Lmgoa3OeEyZC1XA8h0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Lo6AQ98DPI0i4inUNbdJL+9qUL3g8g2VMdG5B/1xruksc59ayC8odA7DLHg+bJMtTjXAQEXXVso/6jDmDHipBBiUX4i3/iVtBu9O7ECETHvw/QCsKLNKeNHl0YwwUd4k/w+cXjXsDw/Wuie38uwaj5LbLGawyDf7w8CltsdfsMw=
Received: by 10.67.95.3 with SMTP id x3mr3465960ugl.1175430141370;
        Sun, 01 Apr 2007 05:22:21 -0700 (PDT)
Received: from localhost ( [59.95.8.28])
        by mx.google.com with ESMTP id e34sm5681534ugd.2007.04.01.05.22.17;
        Sun, 01 Apr 2007 05:22:20 -0700 (PDT)
Date:	Sun, 1 Apr 2007 17:53:19 +0530
From:	Milind Arun Choudhary <milindchoudhary@gmail.com>
To:	kernel-janitors@lists.osdl.org
Cc:	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [KJ][PATCH] ROUND_UP cleanup in arch/mips/kernel/sysirix.c
Message-ID: <20070401122319.GA10178@arun.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Return-Path: <milindchoudhary@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: milindchoudhary@gmail.com
Precedence: bulk
X-list: linux-mips

ROUND_UP(32|64) cleanup, use ALIGN

Signed-off-by: Milind Arun Choudhary <milindchoudhary@gmail.com>

---
 sysirix.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


diff --git a/arch/mips/kernel/sysirix.c b/arch/mips/kernel/sysirix.c
index 93a1484..59c25bc 100644
--- a/arch/mips/kernel/sysirix.c
+++ b/arch/mips/kernel/sysirix.c
@@ -1736,14 +1736,13 @@ struct irix_dirent32_callback {
 };
 
 #define NAME_OFFSET32(de) ((int) ((de)->d_name - (char *) (de)))
-#define ROUND_UP32(x) (((x)+sizeof(u32)-1) & ~(sizeof(u32)-1))
 
 static int irix_filldir32(void *__buf, const char *name,
 	int namlen, loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct irix_dirent32 __user *dirent;
 	struct irix_dirent32_callback *buf = __buf;
-	unsigned short reclen = ROUND_UP32(NAME_OFFSET32(dirent) + namlen + 1);
+	unsigned short reclen = ALIGN(NAME_OFFSET32(dirent) + namlen + 1, sizeof(u32));
 	int err = 0;
 	u32 d_ino;
 
@@ -1838,14 +1837,13 @@ struct irix_dirent64_callback {
 };
 
 #define NAME_OFFSET64(de) ((int) ((de)->d_name - (char *) (de)))
-#define ROUND_UP64(x) (((x)+sizeof(u64)-1) & ~(sizeof(u64)-1))
 
 static int irix_filldir64(void *__buf, const char *name,
 	int namlen, loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct irix_dirent64 __user *dirent;
 	struct irix_dirent64_callback * buf = __buf;
-	unsigned short reclen = ROUND_UP64(NAME_OFFSET64(dirent) + namlen + 1);
+	unsigned short reclen = ALIGN(NAME_OFFSET64(dirent) + namlen + 1,sizeof(u64));
 	int err = 0;
 
 	if (!access_ok(VERIFY_WRITE, buf, sizeof(*buf)))

-- 
Milind Arun Choudhary
