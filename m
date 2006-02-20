Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 14:12:13 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:54290 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133758AbWBTOMB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 14:12:01 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 8E2B864D3D; Mon, 20 Feb 2006 14:18:56 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 9D9648DC5; Mon, 20 Feb 2006 14:18:48 +0000 (GMT)
Date:	Mon, 20 Feb 2006 14:18:48 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: trivial changes
Message-ID: <20060220141848.GL29098@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060219234757.GW10266@deprecation.cyrius.com> <Pine.LNX.4.64N.0602201329100.13723@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0602201329100.13723@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

[MIPS] Remove typecase from drivers/mtd/maps/lasat.c - sync with Linus tree

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

diff --git a/drivers/mtd/maps/lasat.c b/drivers/mtd/maps/lasat.c
index 2a2efaa..31d2c35 100644
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
