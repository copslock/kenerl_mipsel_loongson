Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Mar 2008 01:34:49 +0000 (GMT)
Received: from smtp-out26.alice.it ([85.33.2.26]:28944 "EHLO
	smtp-out26.alice.it") by ftp.linux-mips.org with ESMTP
	id S28577827AbYCLBer (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Mar 2008 01:34:47 +0000
Received: from FBCMMO03.fbc.local ([192.168.68.197]) by smtp-out26.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 12 Mar 2008 02:34:41 +0100
Received: from FBCMCL01B03.fbc.local ([192.168.69.84]) by FBCMMO03.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 12 Mar 2008 02:34:41 +0100
Received: from raver.openwrt ([87.11.94.38]) by FBCMCL01B03.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 12 Mar 2008 02:34:41 +0100
From:	Matteo Croce <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org, linux-net@vger.kernel.org
Subject: [PATCH][MIPS][6/6]: AR7 leds
Date:	Wed, 12 Mar 2008 02:34:39 +0100
User-Agent: KMail/1.9.9
References: <200803120221.25044.technoboy85@gmail.com>
In-Reply-To: <200803120221.25044.technoboy85@gmail.com>
X-Face:	0AUq?,0sKh2O65+R5#[nTCS'~}"m)9|g3Tsi=g7A9q69S+=M!BY)=?utf-8?q?Zdmwo2u!i=5CUylx=26=27D+=0A=09=5B7u=26z1=27s=7E=5B=3F+=24=27w?=
 =?utf-8?q?O6+?="'WWcr5Jy,]}8namg8NP:9<E,o^21xGB~/HRhB(u^@
 =?utf-8?q?ZB=2EXLP0swe=0A=09r9M=7EL?=<b1=^'4cv*_N1tNJ$`9Ot*KL/;8oXFdrT@r|-Ki2wCQI"R(X(
 =?utf-8?q?73r=3A=3BmnNPoA2a=5D=7EZ=0A=092n2sUh?=,B|bt;ys*hv.QR>a]{m
Cc:	Eugene Konev <ejka@imfi.kspu.ru>, netdev@vger.kernel.org,
	davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
	jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Anton Vorontsov <avorontsov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200803120234.40306.technoboy85@gmail.com>
X-OriginalArrivalTime: 12 Mar 2008 01:34:41.0241 (UTC) FILETIME=[3E139490:01C883E1]
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Matteo Croce <technoboy85@gmail.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

diff --git a/drivers/net/cpmac.c b/drivers/net/cpmac.c
index c85194f..05191b6 100644
--- a/drivers/net/cpmac.c
+++ b/drivers/net/cpmac.c
@@ -1006,23 +1006,10 @@ static int __devinit cpmac_probe(struct platform_device *pdev)
 
 	if (phy_id == PHY_MAX_ADDR) {
 		if (external_switch || dumb_switch) {
-			struct fixed_phy_status status = {};
-
-			mdio_bus_id = 0;
-
-			/*
-			 * FIXME: this should be in the platform code!
-			 * Since there is not platform code at all (that is,
-			 * no mainline users of that driver), place it here
-			 * for now.
-			 */
-			phy_id = 0;
-			status.link = 1;
-			status.duplex = 1;
-			status.speed = 100;
-			fixed_phy_add(PHY_POLL, phy_id, &status);
+			mdio_bus_id = 0; /* fixed phys bus */
+			phy_id = pdev->id;
 		} else {
-			printk(KERN_ERR "cpmac: no PHY present\n");
+			dev_err(&pdev->dev, "no PHY present\n");
 			return -ENODEV;
 		}
 	}
