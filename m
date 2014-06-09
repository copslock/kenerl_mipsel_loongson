Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2014 17:17:12 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:32716 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822318AbaFIPRJucU62 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jun 2014 17:17:09 +0200
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id s59FH1Vk019194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 9 Jun 2014 15:17:02 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
        by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s59FH08k020813
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 9 Jun 2014 15:17:00 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s59FH0LT014364;
        Mon, 9 Jun 2014 15:17:00 GMT
Received: from mwanda (/41.202.240.3)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jun 2014 08:16:59 -0700
Date:   Mon, 9 Jun 2014 18:17:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     kernel-janitors@vger.kernel.org, linux-mips@linux-mips.org
Subject: [patch]  MIPS: Bonito64: remove a duplicate define
Message-ID: <20140609151700.GJ9600@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: acsinet21.oracle.com [141.146.126.237]
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40458
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

BONITO_PCIMEMBASECFG_ADDRMASK was cut and pasted twice so we can delete
the second define.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/mips/include/asm/mips-boards/bonito64.h b/arch/mips/include/asm/mips-boards/bonito64.h
index b2048d1..5368891 100644
--- a/arch/mips/include/asm/mips-boards/bonito64.h
+++ b/arch/mips/include/asm/mips-boards/bonito64.h
@@ -414,7 +414,6 @@ extern unsigned long _pcictrl_bonito_pcicfg;
 
 
 #define BONITO_PCIMEMBASECFG_ADDRMASK(WIN, CFG)	 ((((CFG) & BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK) >> BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK_SHIFT) << BONITO_PCIMEMBASECFG_ASHIFT)
-#define BONITO_PCIMEMBASECFG_ADDRMASK(WIN, CFG)	 ((((CFG) & BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK) >> BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK_SHIFT) << BONITO_PCIMEMBASECFG_ASHIFT)
 #define BONITO_PCIMEMBASECFG_ADDRTRANS(WIN, CFG) ((((CFG) & BONITO_PCIMEMBASECFG_MEMBASE##WIN##_TRANS) >> BONITO_PCIMEMBASECFG_MEMBASE##WIN##_TRANS_SHIFT) << BONITO_PCIMEMBASECFG_ASHIFT)
 
 #define BONITO_PCITOPHYS(WIN, ADDR, CFG)	  ( \
