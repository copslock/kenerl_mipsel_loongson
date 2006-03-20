Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:30:18 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:40207 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133372AbWCTE12 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 04:27:28 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 8BFE864D3D; Mon, 20 Mar 2006 04:37:05 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id C849766ED5; Mon, 20 Mar 2006 04:36:46 +0000 (GMT)
Date:	Mon, 20 Mar 2006 04:36:46 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, akpm@osdl.org
Subject: [PATCH 6/6] [MTD] Remove typecast from drivers/mtd/maps/lasat.c
Message-ID: <20060320043646.GF20200@deprecation.cyrius.com>
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
X-archive-position: 10857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Remove an unneeded typecast from drivers/mtd/maps/lasat.c, thereby
bringing the file in sync with Linus' tree.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- a/drivers/mtd/maps/lasat.c
+++ b/drivers/mtd/maps/lasat.c
@@ -7,7 +7,8 @@
  * modify it under the terms of the GNU General Public License version
  * 2 as published by the Free Software Foundation.
  *
- * $Id: lasat.c,v 1.7 2004/07/12 21:59:44 dwmw2 Exp $
+ * $Id: lasat.c,v 1.9 2004/11/04 13:24:15 gleixner Exp $
+ *
  *
  */
 
@@ -50,7 +51,7 @@ static int __init init_lasat(void)
 	ENABLE_VPP((&lasat_map));
 
 	lasat_map.phys = lasat_flash_partition_start(LASAT_MTD_BOOTLOADER);
-	lasat_map.virt = (unsigned long)ioremap_nocache(
+	lasat_map.virt = ioremap_nocache(
 		        lasat_map.phys, lasat_board_info.li_flash_size);
 	lasat_map.size = lasat_board_info.li_flash_size;
 

-- 
Martin Michlmayr
http://www.cyrius.com/
