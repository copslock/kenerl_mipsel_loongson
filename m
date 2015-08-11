Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Aug 2015 09:59:22 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:42266 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010977AbbHKH7VRw6e9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Aug 2015 09:59:21 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd001.nsn-inter.net (8.15.1/8.15.1) with ESMTPS id t7B7xFmm008933
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 11 Aug 2015 07:59:15 GMT
Received: from localhost.localdomain ([10.144.34.184])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t7B7xEBN017671;
        Tue, 11 Aug 2015 09:59:15 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: OCTEON: fix management port MII address on Kontron S1901
Date:   Tue, 11 Aug 2015 10:56:28 +0300
Message-Id: <1439279788-2050-1-git-send-email-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.4.3
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 1954
X-purgate-ID: 151667::1439279955-00007F5C-AD92F6CC/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48764
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

Management port MII address is incorrect on Kontron S1901 resulting
in broken networking. Fix by providing definitions for the in-tree DT
pruning code.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/mips/cavium-octeon/executive/cvmx-helper-board.c | 6 ++++++
 arch/mips/include/asm/octeon/cvmx-bootinfo.h          | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index 9eb0fee..36e30d6 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -195,6 +195,12 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
 			return 8;
 		else
 			return -1;
+	case CVMX_BOARD_TYPE_KONTRON_S1901:
+		if (ipd_port == CVMX_HELPER_BOARD_MGMT_IPD_PORT)
+			return 1;
+		else
+			return -1;
+
 	}
 
 	/* Some unknown board. Somebody forgot to update this function... */
diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
index c373d95..d92cf59 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
@@ -284,6 +284,7 @@ enum cvmx_board_types_enum {
 	CVMX_BOARD_TYPE_CUST_PRIVATE_MIN = 20001,
 	CVMX_BOARD_TYPE_UBNT_E100 = 20002,
 	CVMX_BOARD_TYPE_CUST_DSR1000N = 20006,
+	CVMX_BOARD_TYPE_KONTRON_S1901 = 21901,
 	CVMX_BOARD_TYPE_CUST_PRIVATE_MAX = 30000,
 
 	/* The remaining range is reserved for future use. */
@@ -384,6 +385,7 @@ static inline const char *cvmx_board_type_to_string(enum
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MIN)
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_UBNT_E100)
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_DSR1000N)
+		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_KONTRON_S1901)
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MAX)
 	}
 	return "Unsupported Board";
-- 
2.4.3
