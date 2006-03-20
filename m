Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:34:17 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:51727 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133782AbWCTEaX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 04:30:23 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id BC3E864D3D; Mon, 20 Mar 2006 04:40:00 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id F34BD66ED5; Mon, 20 Mar 2006 04:39:44 +0000 (GMT)
Date:	Mon, 20 Mar 2006 04:39:44 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	akpm@osdl.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: [PATCH 4/12] [NET] Improve description of MV643XX_ETH
Message-ID: <20060320043944.GD20416@deprecation.cyrius.com>
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
X-archive-position: 10862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Slightly improve the wording of the description of MV643XX_ETH
in Kconfig.  This difference was found between the mainline and
linux-mips kernel trees.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- linux-2.6/drivers/net/Kconfig	2006-03-13 18:55:59.000000000 +0000
+++ mips.git/drivers/net/Kconfig	2006-03-13 18:43:52.000000000 +0000
@@ -2197,8 +2213,8 @@
 	depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX || MV64360 || MOMENCO_OCELOT_3 || PPC_MULTIPLATFORM
 	help
 	  This driver supports the gigabit Ethernet on the Marvell MV643XX
-	  chipset which is used in the Momenco Ocelot C and Jaguar ATX and
-	  Pegasos II, amongst other PPC and MIPS boards.
+	  chipset which is used in the Momenco Ocelot C Ocelot, Jaguar ATX
+	  and Pegasos II, amongst other PPC and MIPS boards.
 
 config MV643XX_ETH_0
 	bool "MV-643XX Port 0"

-- 
Martin Michlmayr
http://www.cyrius.com/
