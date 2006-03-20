Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:37:27 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:55823 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133821AbWCTEbM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 04:31:12 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 8F20564D3E; Mon, 20 Mar 2006 04:40:48 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 1A6D266ED7; Mon, 20 Mar 2006 04:40:26 +0000 (GMT)
Date:	Mon, 20 Mar 2006 04:40:26 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	akpm@osdl.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-mtd@lists.infradead.org
Subject: [PATCH 8/12] [MTD] Re-add module description for ms02-nv to Kconfig
Message-ID: <20060320044026.GH20416@deprecation.cyrius.com>
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
X-archive-position: 10866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

In an unrelated MTD commit, a description about the ms02-nv module
got removed from Kconfig.  While I personally agree with this
removal, the module maintainer (Maciej W. Rozycki) would like to
see it added back.  In the absense of any consistency regarding
Kconfig descriptions his wish should be followed.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Acked-by: Maciej W. Rozycki <macro@linux-mips.org>


--- linux-2.6/drivers/mtd/devices/Kconfig	2006-03-05 19:35:04.000000000 +0000
+++ mips.git/drivers/mtd/devices/Kconfig	2006-03-05 18:51:15.000000000 +0000
@@ -47,6 +47,11 @@
 	  accelerator.  Say Y here if you have a DECstation 5000/2x0 or a
 	  DECsystem 5900 equipped with such a module.
 
+	  If you want to compile this driver as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want),
+	  say M here and read <file:Documentation/modules.txt>.  The module will
+	  be called ms02-nv.o.
+
 config MTD_DATAFLASH
 	tristate "Support for AT45xxx DataFlash"
 	depends on MTD && SPI_MASTER && EXPERIMENTAL

-- 
Martin Michlmayr
http://www.cyrius.com/
