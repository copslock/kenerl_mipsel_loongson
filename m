Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Feb 2008 19:26:53 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:15044 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28584309AbYBYT0v (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Feb 2008 19:26:51 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1PJQnNs014441;
	Mon, 25 Feb 2008 19:26:49 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1PJQmiL014440;
	Mon, 25 Feb 2008 19:26:48 GMT
Date:	Mon, 25 Feb 2008 19:26:48 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc:	Chris Dearman <chris@mips.com>, linux-mips@linux-mips.org
Subject: [PATCH] Try both endianess when checking for endianess.
Message-ID: <20080225192648.GA14357@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

From: Chris Dearman <chris@mips.com>

When checking for the swap header try byteswapping the endianess dependent
fields to allow the swap partition to be shared between big & little endian
systems.

Signed-off-by: Chris Dearman <chris@mips.com>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 mm/swapfile.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-queue/mm/swapfile.c
===================================================================
--- linux-queue.orig/mm/swapfile.c
+++ linux-queue/mm/swapfile.c
@@ -1551,6 +1551,14 @@ asmlinkage long sys_swapon(const char __
 		error = -EINVAL;
 		goto bad_swap;
 	case 2:
+		/* swap partition endianess hack... */
+		if (swab32(swap_header->info.version) == 1) {
+			swab32s(&swap_header->info.version);
+			swab32s(&swap_header->info.last_page);
+			swab32s(&swap_header->info.nr_badpages);
+			for (i = 0; i < swap_header->info.nr_badpages; i++)
+				swab32s(&swap_header->info.badpages[i]);
+		}
 		/* Check the swap header's sub-version and the size of
                    the swap file and bad block lists */
 		if (swap_header->info.version != 1) {
