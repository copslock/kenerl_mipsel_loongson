Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:39:02 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:58895 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133385AbWCTEbY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 04:31:24 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id F0A6064D3D; Mon, 20 Mar 2006 04:41:01 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 5CF8766ED5; Mon, 20 Mar 2006 04:40:46 +0000 (GMT)
Date:	Mon, 20 Mar 2006 04:40:46 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	akpm@osdl.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-mtd@lists.infradead.org
Subject: [PATCH 10/12] [MTD] LASAT depends on MTD_CFI
Message-ID: <20060320044046.GJ20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320043802.GA20389@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

The following difference was found between the mainline and linux-mips
kernel.  LASAT depends on MTD_CFI.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- linux-2.6/drivers/mtd/maps/Kconfig	2006-03-05 19:35:04.000000000 +0000
+++ mips.git/drivers/mtd/maps/Kconfig	2006-03-05 18:51:15.000000000 +0000
@@ -200,8 +200,8 @@
 	  Support for the flash chip on Tsunami TIG bus.
 
 config MTD_LASAT
-	tristate "Flash chips on LASAT board"
-	depends on LASAT
+	tristate "LASAT flash device"
+	depends on LASAT && MTD_CFI
 	help
 	  Support for the flash chips on the Lasat 100 and 200 boards.
 

-- 
Martin Michlmayr
http://www.cyrius.com/
