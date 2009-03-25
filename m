Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2009 00:15:59 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:37860 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21370464AbZCYAP5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 25 Mar 2009 00:15:57 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2P0Ft0F001452;
	Wed, 25 Mar 2009 01:15:55 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2P0Ft6B001450;
	Wed, 25 Mar 2009 01:15:55 +0100
Date:	Wed, 25 Mar 2009 01:15:55 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:	dann frazier <dannf@dannf.org>, linux-mips@linux-mips.org
Subject: [PATCH 2/2] MIPS: o32: Get rid of useless wrapper for llseek
Message-ID: <20090325001555.GA1357@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/kernel/linux32.c     |    7 -------
 arch/mips/kernel/scall64-o32.S |    2 +-
 2 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 49aac6e..ab2da41 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -133,13 +133,6 @@ SYSCALL_DEFINE4(32_ftruncate64, unsigned long, fd, unsigned long, __dummy,
 	return sys_ftruncate(fd, merge_64(a2, a3));
 }
 
-SYSCALL_DEFINE5(32_llseek, unsigned long, fd, unsigned long, offset_high,
-	unsigned long, offset_low, loff_t __user *, result,
-	unsigned long, origin)
-{
-	return sys_llseek(fd, offset_high, offset_low, result, origin);
-}
-
 /* From the Single Unix Spec: pread & pwrite act like lseek to pos + op +
    lseek back to original location.  They fail just like lseek does on
    non-seekable files.  */
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index b0fef4f..d928614 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -343,7 +343,7 @@ sys_call_table:
 	PTR	sys_ni_syscall	 		/* for afs_syscall */
 	PTR	sys_setfsuid
 	PTR	sys_setfsgid
-	PTR	sys_32_llseek			/* 4140 */
+	PTR	sys_llseek			/* 4140 */
 	PTR	compat_sys_getdents
 	PTR	compat_sys_select
 	PTR	sys_flock
