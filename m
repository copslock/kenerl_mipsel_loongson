Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2015 21:39:02 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:50264 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026294AbbEAThxRSt9j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2015 21:37:53 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id BF5CD19BCBC;
        Fri,  1 May 2015 22:37:54 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id ZjJWjV4oVR0E; Fri,  1 May 2015 22:37:49 +0300 (EEST)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 8E7365BC008;
        Fri,  1 May 2015 22:37:47 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RFC PATCH 05/11] MIPS: OCTEON: delete calls to __cvmx_helper_npi/rgmii_probe
Date:   Fri,  1 May 2015 22:37:07 +0300
Message-Id: <1430509033-12113-6-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
References: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47191
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

These calls have no side effects so drop the calls, so that we
don't need to export these functions to modules.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/cvmx-helper-ethernet.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-ethernet.c b/arch/mips/cavium-octeon/executive/cvmx-helper-ethernet.c
index 6fe990e..390f8f80 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-ethernet.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-ethernet.c
@@ -130,7 +130,6 @@ int cvmx_helper_interface_probe(int interface)
 		 */
 	case CVMX_HELPER_INTERFACE_MODE_RGMII:
 	case CVMX_HELPER_INTERFACE_MODE_GMII:
-		__cvmx_helper_rgmii_probe(interface);
 		break;
 		/*
 		 * SPI4 can have 1-16 ports depending on the device at
@@ -149,7 +148,6 @@ int cvmx_helper_interface_probe(int interface)
 		break;
 		/* PCI target Network Packet Interface */
 	case CVMX_HELPER_INTERFACE_MODE_NPI:
-		__cvmx_helper_npi_probe(interface);
 		break;
 		/*
 		 * Special loopback only ports. These are not the same
-- 
2.3.3
