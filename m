Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2014 17:18:47 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:36299 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816288AbaFIPSlJud52 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jun 2014 17:18:41 +0200
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id s59FISJl024481
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 9 Jun 2014 15:18:30 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
        by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s59FIQJO027009
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 9 Jun 2014 15:18:27 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id s59FIPXf029738;
        Mon, 9 Jun 2014 15:18:25 GMT
Received: from mwanda (/41.202.240.3)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jun 2014 08:18:24 -0700
Date:   Mon, 9 Jun 2014 18:18:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, kernel-janitors@vger.kernel.org
Subject: [patch] MIPS: mipsreg: remove duplicate MIPS_CONF4_FTLBSETS_SHIFT
Message-ID: <20140609151820.GK9600@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: acsinet21.oracle.com [141.146.126.237]
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40459
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

The MIPS_CONF4_FTLBSETS_SHIFT define is cut and pasted twice so we can
remove the second define.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 98e9754..dcc7872 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -630,7 +630,6 @@
 #define MIPS_CONF4_MMUSIZEEXT_SHIFT	(0)
 #define MIPS_CONF4_MMUSIZEEXT	(_ULCAST_(255) << 0)
 #define MIPS_CONF4_FTLBSETS_SHIFT	(0)
-#define MIPS_CONF4_FTLBSETS_SHIFT	(0)
 #define MIPS_CONF4_FTLBSETS	(_ULCAST_(15) << MIPS_CONF4_FTLBSETS_SHIFT)
 #define MIPS_CONF4_FTLBWAYS_SHIFT	(4)
 #define MIPS_CONF4_FTLBWAYS	(_ULCAST_(15) << MIPS_CONF4_FTLBWAYS_SHIFT)
