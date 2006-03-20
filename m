Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:38:13 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:57103 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133808AbWCTEbN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 04:31:13 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 40D2D64D3F; Mon, 20 Mar 2006 04:40:49 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 1DEAE66ED9; Mon, 20 Mar 2006 04:40:36 +0000 (GMT)
Date:	Mon, 20 Mar 2006 04:40:36 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	akpm@osdl.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-mtd@lists.infradead.org
Subject: [PATCH 9/12] [MTD] Fix #else directive in the docprobe driver
Message-ID: <20060320044036.GI20416@deprecation.cyrius.com>
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
X-archive-position: 10867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

The following difference was found between the mainline and linux-mips
kernel.  Fix the #else directive in the docprobe driver, and change
some space to tabs for consistency.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- linux-2.6/drivers/mtd/devices/docprobe.c	2006-03-05 19:35:04.000000000 +0000
+++ mips.git/drivers/mtd/devices/docprobe.c	2006-03-05 18:51:15.000000000 +0000
@@ -84,10 +84,10 @@
 	0xe4000000,
 #elif defined(CONFIG_MOMENCO_OCELOT)
 	0x2f000000,
-        0xff000000,
+	0xff000000,
 #elif defined(CONFIG_MOMENCO_OCELOT_G) || defined (CONFIG_MOMENCO_OCELOT_C)
-        0xff000000,
-##else
+	0xff000000,
+#else
 #warning Unknown architecture for DiskOnChip. No default probe locations defined
 #endif
 	0xffffffff };

-- 
Martin Michlmayr
http://www.cyrius.com/
