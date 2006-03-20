Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:28:02 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:37135 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8126537AbWCTE0e (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 04:26:34 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 68D8B64D3D; Mon, 20 Mar 2006 04:36:11 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 6FB3466ED5; Mon, 20 Mar 2006 04:35:55 +0000 (GMT)
Date:	Mon, 20 Mar 2006 04:35:55 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, akpm@osdl.org
Subject: [PATCH 3/6] Remove bogus blank lines - sync with Linus' tree
Message-ID: <20060320043555.GC20200@deprecation.cyrius.com>
References: <20060320043445.GA20171@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320043445.GA20171@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

This brings video/au1100fb.c and mach-au1x00/au1xxx_ide.h in sync
with Linus' tree by removing two blank lines.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- mips.git/drivers/video/au1100fb.c	2006-03-05 18:51:17.000000000 +0000
+++ linux-2.6/drivers/video/au1100fb.c	2006-03-05 19:35:05.000000000 +0000
@@ -38,7 +38,6 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
--- mips.git/include/asm-mips/mach-au1x00/au1xxx_ide.h	2006-03-13 18:43:52.000000000 +0000
+++ linux-2.6/include/asm-mips/mach-au1x00/au1xxx_ide.h	2006-03-05 19:35:08.000000000 +0000
@@ -84,7 +84,6 @@
 } _auide_hwif;
 
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
-
 /* HD white list */
 static const struct drive_list_entry dma_white_list [] = {
 /*

-- 
Martin Michlmayr
http://www.cyrius.com/
