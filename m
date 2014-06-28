Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2014 22:35:11 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:60696 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859960AbaF1UecohB6d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Jun 2014 22:34:32 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id F3FFA19BFDC;
        Sat, 28 Jun 2014 23:34:31 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id e94mNiH2O3om; Sat, 28 Jun 2014 23:34:25 +0300 (EEST)
Received: from cooljazz.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 535B35BC011;
        Sat, 28 Jun 2014 23:34:25 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/3] MIPS: OCTEON: add USB clock type for D-Link DSR-1000N
Date:   Sat, 28 Jun 2014 23:34:09 +0300
Message-Id: <1403987650-6194-3-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1403987650-6194-1-git-send-email-aaro.koskinen@iki.fi>
References: <1403987650-6194-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40908
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

Add USB clock type for D-Link DSR-1000N.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/cvmx-helper-board.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index b764df6..6c871a5 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -738,6 +738,7 @@ enum cvmx_helper_board_usb_clock_types __cvmx_helper_board_usb_get_clock_type(vo
 	case CVMX_BOARD_TYPE_LANAI2_G:
 	case CVMX_BOARD_TYPE_NIC10E_66:
 	case CVMX_BOARD_TYPE_UBNT_E100:
+	case CVMX_BOARD_TYPE_CUST_DSR1000N:
 		return USB_CLOCK_TYPE_CRYSTAL_12;
 	case CVMX_BOARD_TYPE_NIC10E:
 		return USB_CLOCK_TYPE_REF_12;
-- 
2.0.0
