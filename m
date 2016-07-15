Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2016 13:17:13 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:31190 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993311AbcGOLRGcfNbT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jul 2016 13:17:06 +0200
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u6FBGsMP002409
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2016 11:16:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.13.8) with ESMTP id u6FBGsZX017687
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2016 11:16:54 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id u6FBGoni026587;
        Fri, 15 Jul 2016 11:16:52 GMT
Received: from mwanda (/154.0.139.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jul 2016 04:16:50 -0700
Date:   Fri, 15 Jul 2016 14:16:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Ricardo Mendoza <ricmm@gentoo.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [patch] MIPS: RM7000: Double locking bug in rm7k_tc_disable()
Message-ID: <20160715111644.GA13153@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54337
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

We obviously intended to enable IRQs again at the end.

Fixes: 745aef5df1e2 ('MIPS: RM7000: Add support for tertiary cache')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/mips/mm/sc-rm7k.c b/arch/mips/mm/sc-rm7k.c
index 9ac1efc..78f900c 100644
--- a/arch/mips/mm/sc-rm7k.c
+++ b/arch/mips/mm/sc-rm7k.c
@@ -161,7 +161,7 @@ static void rm7k_tc_disable(void)
 	local_irq_save(flags);
 	blast_rm7k_tcache();
 	clear_c0_config(RM7K_CONF_TE);
-	local_irq_save(flags);
+	local_irq_restore(flags);
 }
 
 static void rm7k_sc_disable(void)
