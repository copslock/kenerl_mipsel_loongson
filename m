Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 14:53:57 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35839 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009790AbaKXNx4PN1Qz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 14:53:56 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C87C93975E8B9;
        Mon, 24 Nov 2014 13:53:47 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 24 Nov
 2014 13:53:50 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 24 Nov 2014 13:53:50 +0000
Received: from raava.le.imgtec.org (192.168.154.64) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 24 Nov
 2014 13:53:49 +0000
From:   James Cowgill <James.Cowgill@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        David Daney <david.daney@cavium.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Cowgill <James.Cowgill@imgtec.com>
Subject: [PATCH] MIPS: octeon: Add support for the UBNT E200 board
Date:   Mon, 24 Nov 2014 13:51:36 +0000
Message-ID: <1416837096-52243-1-git-send-email-James.Cowgill@imgtec.com>
X-Mailer: git-send-email 2.1.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.64]
Return-Path: <James.Cowgill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Cowgill@imgtec.com
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

From: Markos Chandras <markos.chandras@imgtec.com>

Add support for the UBNT E200 board (EdgeRouter/EdgeRouter Pro 8 port).

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
---
 arch/mips/cavium-octeon/executive/cvmx-helper-board.c | 3 +++
 arch/mips/include/asm/octeon/cvmx-bootinfo.h          | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index 5dfef84..69ba6fb 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -186,6 +186,8 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
 			return 7 - ipd_port;
 		else
 			return -1;
+	case CVMX_BOARD_TYPE_UBNT_E200:
+		return -1;
 	case CVMX_BOARD_TYPE_CUST_DSR1000N:
 		/*
 		 * Port 2 connects to Broadcom PHY (B5081). Other ports (0-1)
@@ -759,6 +761,7 @@ enum cvmx_helper_board_usb_clock_types __cvmx_helper_board_usb_get_clock_type(vo
 	case CVMX_BOARD_TYPE_LANAI2_G:
 	case CVMX_BOARD_TYPE_NIC10E_66:
 	case CVMX_BOARD_TYPE_UBNT_E100:
+	case CVMX_BOARD_TYPE_UBNT_E200:
 	case CVMX_BOARD_TYPE_CUST_DSR1000N:
 		return USB_CLOCK_TYPE_CRYSTAL_12;
 	case CVMX_BOARD_TYPE_NIC10E:
diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
index 2298199..0567847 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
@@ -228,6 +228,7 @@ enum cvmx_board_types_enum {
 	 */
 	CVMX_BOARD_TYPE_CUST_PRIVATE_MIN = 20001,
 	CVMX_BOARD_TYPE_UBNT_E100 = 20002,
+	CVMX_BOARD_TYPE_UBNT_E200 = 20003,
 	CVMX_BOARD_TYPE_CUST_DSR1000N = 20006,
 	CVMX_BOARD_TYPE_CUST_PRIVATE_MAX = 30000,
 
@@ -328,6 +329,7 @@ static inline const char *cvmx_board_type_to_string(enum
 		    /* Customer private range */
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MIN)
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_UBNT_E100)
+		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_UBNT_E200)
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_DSR1000N)
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MAX)
 	}
-- 
2.1.3
