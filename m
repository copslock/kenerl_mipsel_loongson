Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2016 12:15:06 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:17796 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995252AbcGNKPAdEbOL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jul 2016 12:15:00 +0200
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u6EAEh7N007645
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 14 Jul 2016 10:14:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u6EAEfUF006377
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 14 Jul 2016 10:14:41 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id u6EAEbBd011026;
        Thu, 14 Jul 2016 10:14:38 GMT
Received: from mwanda (/154.0.139.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jul 2016 03:14:37 -0700
Date:   Thu, 14 Jul 2016 13:14:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Cc:     Rob Herring <robh@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
        linux-mips@linux-mips.org, kernel-janitors@vger.kernel.org
Subject: [patch] MIPS: OCTEON: Off by one in octeon_irq_gpio_map()
Message-ID: <20160714101429.GA18175@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.carpenter@oracle.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

It should be >= ARRAY_SIZE() instead of > ARRAY_SIZE().

Fixes: 64b139f97c01 ('MIPS: OCTEON: irq: add CIB and other fixes')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 368eb49..75a4add 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1260,7 +1260,7 @@ static int octeon_irq_gpio_map(struct irq_domain *d,
 
 	line = (hw + gpiod->base_hwirq) >> 6;
 	bit = (hw + gpiod->base_hwirq) & 63;
-	if (line > ARRAY_SIZE(octeon_irq_ciu_to_irq) ||
+	if (line >= ARRAY_SIZE(octeon_irq_ciu_to_irq) ||
 		octeon_irq_ciu_to_irq[line][bit] != 0)
 		return -EINVAL;
 
