Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 07:11:48 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:40731
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133382AbVJTGLa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 07:11:30 +0100
Received: from dl2.hq2.avtrex.com (dl2.hq2.avtrex.com [127.0.0.1])
	by avtrex.com (8.13.1/8.13.1) with ESMTP id j9K6BTg5001308
	for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:11:29 -0700
Received: (from daney@localhost)
	by dl2.hq2.avtrex.com (8.13.1/8.13.1/Submit) id j9K6BTTu001305;
	Wed, 19 Oct 2005 23:11:29 -0700
From:	David Daney <ddaney@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17239.13585.316748.227825@dl2.hq2.avtrex.com>
Date:	Wed, 19 Oct 2005 23:11:29 -0700
To:	linux-mips@linux-mips.org
Subject: Patch: ATI Xilleon port 6/11 Xilleon boot info constants
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: ddaney@avtrex.com
Return-Path: <daney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is the sixth part of my Xilleon port.

This patch adds bootinfo constants for ATI's Xilleon family of SOCs.

Patch against 2.6.14-rc2 from linux-mips.org

Signed-off-by: David Daney <ddaney@avtrex.com>

Add Xilleon boot info constants.

---
commit 72de26a8574419f86b2459f9957bde08820ef50f
tree 0939dde47094e2fc7394c98ff87724b9dbbac4a3
parent 33019afad122415869a7a0b2f2a3600249c55704
author David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 13:45:14 -0700
committer David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 13:45:14 -0700

 include/asm-mips/bootinfo.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/asm-mips/bootinfo.h b/include/asm-mips/bootinfo.h
--- a/include/asm-mips/bootinfo.h
+++ b/include/asm-mips/bootinfo.h
@@ -218,6 +218,10 @@
 #define MACH_GROUP_TITAN       22	/* PMC-Sierra Titan		*/
 #define  MACH_TITAN_YOSEMITE	1	/* PMC-Sierra Yosemite		*/
 
+ /* Valid machtype for group ATI */
+#define MACH_GROUP_ATI         23
+#define MACH_ATI_XILLEON        0
+
 #define CL_SIZE			COMMAND_LINE_SIZE
 
 const char *get_system_type(void);
