Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Jun 2013 23:39:19 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:49645 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6821310Ab3FWVjCk0NOc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 Jun 2013 23:39:02 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 109D521B87A;
        Mon, 24 Jun 2013 00:38:59 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id hkHcmcBBHHvE; Mon, 24 Jun 2013 00:38:54 +0300 (EEST)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp4.welho.com (Postfix) with ESMTP id 198E15BC011;
        Mon, 24 Jun 2013 00:38:54 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 2/2] MIPS: cavium-octeon: enable interfaces on EdgeRouter Lite
Date:   Mon, 24 Jun 2013 00:38:44 +0300
Message-Id: <1372023524-17333-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1372023524-17333-1-git-send-email-aaro.koskinen@iki.fi>
References: <1372023524-17333-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Enable interfaces on EdgeRouter Lite. Tested with cavium_octeon_defconfig
and busybox shell. DHCP & ping works with eth0, eth1 and eth2.

The board type "UBNT_E100" is taken from the sources of the vendor kernel
shipped with the product.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/cvmx-helper-board.c | 13 +++++++++++++
 arch/mips/include/asm/octeon/cvmx-bootinfo.h          |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index 9838c0e..2fcf030 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -183,6 +183,11 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
 			return ipd_port - 16 + 4;
 		else
 			return -1;
+	case CVMX_BOARD_TYPE_UBNT_E100:
+		if (ipd_port >= 0 && ipd_port <= 2)
+			return 7 - ipd_port;
+		else
+			return -1;
 	}
 
 	/* Some unknown board. Somebody forgot to update this function... */
@@ -707,6 +712,14 @@ int __cvmx_helper_board_hardware_enable(int interface)
 				}
 			}
 		}
+	} else if (cvmx_sysinfo_get()->board_type ==
+			CVMX_BOARD_TYPE_UBNT_E100) {
+		cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(0, interface), 0);
+		cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(0, interface), 0x10);
+		cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(1, interface), 0);
+		cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(1, interface), 0x10);
+		cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(2, interface), 0);
+		cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(2, interface), 0x10);
 	}
 	return 0;
 }
diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
index 284fa8d..7b7818d 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
@@ -227,6 +227,7 @@ enum cvmx_board_types_enum {
 	 * use any numbers in this range.
 	 */
 	CVMX_BOARD_TYPE_CUST_PRIVATE_MIN = 20001,
+	CVMX_BOARD_TYPE_UBNT_E100 = 20002,
 	CVMX_BOARD_TYPE_CUST_PRIVATE_MAX = 30000,
 
 	/* The remaining range is reserved for future use. */
@@ -325,6 +326,7 @@ static inline const char *cvmx_board_type_to_string(enum
 
 		    /* Customer private range */
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MIN)
+		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_UBNT_E100)
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MAX)
 	}
 	return "Unsupported Board";
-- 
1.8.3.1
