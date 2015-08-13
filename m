Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 15:26:31 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:55505 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012331AbbHMNZAyEz0G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Aug 2015 15:25:00 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd001.nsn-inter.net (8.15.1/8.15.1) with ESMTPS id t7DDOkwY003829
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 13 Aug 2015 13:24:46 GMT
Received: from localhost.localdomain ([10.144.34.184])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t7DDObQW030804;
        Thu, 13 Aug 2015 15:24:45 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Janne Huttunen <janne.huttunen@nokia.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH 13/14] MIPS: OCTEON: support interfaces 4 and 5
Date:   Thu, 13 Aug 2015 16:21:45 +0300
Message-Id: <1439472106-7750-14-git-send-email-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
References: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 1602
X-purgate-ID: 151667::1439472286-00007F5C-7DC1F3E6/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nokia.com
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

From: Janne Huttunen <janne.huttunen@nokia.com>

Add the support for mapping between interface/port numbers and IPD port
numbers also for the additional interfaces some Octeon II models have.

Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/mips/cavium-octeon/executive/cvmx-helper-util.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-util.c b/arch/mips/cavium-octeon/executive/cvmx-helper-util.c
index 4029596..b45b297 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-util.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-util.c
@@ -382,6 +382,10 @@ int cvmx_helper_get_ipd_port(int interface, int port)
 		return port + 32;
 	case 3:
 		return port + 36;
+	case 4:
+		return port + 40;
+	case 5:
+		return port + 44;
 	}
 	return -1;
 }
@@ -404,6 +408,10 @@ int cvmx_helper_get_interface_num(int ipd_port)
 		return 2;
 	else if (ipd_port < 40)
 		return 3;
+	else if (ipd_port < 44)
+		return 4;
+	else if (ipd_port < 48)
+		return 5;
 	else
 		cvmx_dprintf("cvmx_helper_get_interface_num: Illegal IPD "
 			     "port number\n");
@@ -428,6 +436,10 @@ int cvmx_helper_get_interface_index_num(int ipd_port)
 		return ipd_port & 3;
 	else if (ipd_port < 40)
 		return ipd_port & 3;
+	else if (ipd_port < 44)
+		return ipd_port & 3;
+	else if (ipd_port < 48)
+		return ipd_port & 3;
 	else
 		cvmx_dprintf("cvmx_helper_get_interface_index_num: "
 			     "Illegal IPD port number\n");
-- 
2.4.3
