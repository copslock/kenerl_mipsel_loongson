Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 15:29:12 +0200 (CEST)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:53759 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012398AbbHMNZHLY-n5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Aug 2015 15:25:07 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd002.nsn-inter.net (8.15.1/8.15.1) with ESMTPS id t7DDOlXo010209
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 13 Aug 2015 13:24:47 GMT
Received: from localhost.localdomain ([10.144.34.184])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t7DDObQX030804;
        Thu, 13 Aug 2015 15:24:46 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Janne Huttunen <janne.huttunen@nokia.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH 14/14] MIPS/staging: OCTEON: use common helpers for determining interface and port
Date:   Thu, 13 Aug 2015 16:21:46 +0300
Message-Id: <1439472106-7750-15-git-send-email-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
References: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 2055
X-purgate-ID: 151667::1439472287-0000676C-9BB4984A/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48859
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

Currently the Octeon Ethernet driver hardcodes the mapping between
interface/port and IPD port number. Since we have generic helpers for
the very same purpose, we might as well use them instead. This prevents
having the same information in multiple places.

Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 drivers/staging/octeon/ethernet-util.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-util.h b/drivers/staging/octeon/ethernet-util.h
index 1ba789a..45f024b 100644
--- a/drivers/staging/octeon/ethernet-util.h
+++ b/drivers/staging/octeon/ethernet-util.h
@@ -8,6 +8,10 @@
  * published by the Free Software Foundation.
  */
 
+#include <asm/octeon/cvmx-pip.h>
+#include <asm/octeon/cvmx-helper.h>
+#include <asm/octeon/cvmx-helper-util.h>
+
 /**
  * cvm_oct_get_buffer_ptr - convert packet data address to pointer
  * @packet_ptr: Packet data hardware address
@@ -28,14 +32,12 @@ static inline void *cvm_oct_get_buffer_ptr(union cvmx_buf_ptr packet_ptr)
  */
 static inline int INTERFACE(int ipd_port)
 {
-	if (ipd_port < 32)	/* Interface 0 or 1 for RGMII,GMII,SPI, etc */
-		return ipd_port >> 4;
-	else if (ipd_port < 36)	/* Interface 2 for NPI */
-		return 2;
-	else if (ipd_port < 40)	/* Interface 3 for loopback */
-		return 3;
-	else if (ipd_port == 40)	/* Non existent interface for POW0 */
-		return 4;
+	int interface = cvmx_helper_get_interface_num(ipd_port);
+
+	if (interface >= 0)
+		return interface;
+	else if (ipd_port == CVMX_PIP_NUM_INPUT_PORTS)
+		return 10;
 	panic("Illegal ipd_port %d passed to INTERFACE\n", ipd_port);
 }
 
@@ -47,7 +49,5 @@ static inline int INTERFACE(int ipd_port)
  */
 static inline int INDEX(int ipd_port)
 {
-	if (ipd_port < 32)
-		return ipd_port & 15;
-	return ipd_port & 3;
+	return cvmx_helper_get_interface_index_num(ipd_port);
 }
-- 
2.4.3
