Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2007 07:45:36 +0100 (BST)
Received: from DSL022.labridge.com ([206.117.136.22]:63241 "EHLO perches.com")
	by ftp.linux-mips.org with ESMTP id S20022019AbXHMGpe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Aug 2007 07:45:34 +0100
Received: from localhost ([192.168.1.128])
	by perches.com (8.9.3/8.9.3) with SMTP id XAA11569;
	Sun, 12 Aug 2007 23:55:07 -0700
Date:	Sun, 12 Aug 2007 23:32:02 -0700
From:	joe@perches.com
To:	torvalds@linux-foundation.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH] [318/2many] MAINTAINERS - MIPS
Message-ID: <46bffae2.5W/JqMcNOgZqqFED%joe@perches.com>
User-Agent: Heirloom mailx 12.2 01/07/07
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
X-list: linux-mips

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c98162..cda5f15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3062,6 +3062,9 @@ W:	http://www.linux-mips.org/
 L:	linux-mips@linux-mips.org
 T:	git www.linux-mips.org:/pub/scm/linux.git
 S:	Supported
+F:	Documentation/mips/
+F:	arch/mips/
+F:	include/asm-mips/
 
 MISCELLANEOUS MCA-SUPPORT
 P:	James Bottomley
