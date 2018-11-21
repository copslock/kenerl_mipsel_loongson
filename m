Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 23:38:47 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58424 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994541AbeKUWiEEQML- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 23:38:04 +0100
Received: from localhost.localdomain (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id BD349200A1;
        Thu, 22 Nov 2018 00:38:03 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 18/24] MIPS: OCTEON: delete cvmx override functions
Date:   Thu, 22 Nov 2018 00:37:39 +0200
Message-Id: <20181121223745.22792-19-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181121223745.22792-1-aaro.koskinen@iki.fi>
References: <20181121223745.22792-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67447
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

Delete cmvx override functions, they are not used.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../cavium-octeon/executive/cvmx-helper.c     | 31 -------------------
 arch/mips/include/asm/octeon/cvmx-helper.h    | 20 ------------
 2 files changed, 51 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index 11f5fb4e0736..7b1ff7fe1bf9 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -46,26 +46,6 @@
 #include <asm/octeon/cvmx-smix-defs.h>
 #include <asm/octeon/cvmx-asxx-defs.h>
 
-/**
- * cvmx_override_pko_queue_priority(int ipd_port, uint64_t
- * priorities[16]) is a function pointer. It is meant to allow
- * customization of the PKO queue priorities based on the port
- * number. Users should set this pointer to a function before
- * calling any cvmx-helper operations.
- */
-void (*cvmx_override_pko_queue_priority) (int pko_port,
-					  uint64_t priorities[16]);
-
-/**
- * cvmx_override_ipd_port_setup(int ipd_port) is a function
- * pointer. It is meant to allow customization of the IPD port
- * setup before packet input/output comes online. It is called
- * after cvmx-helper does the default IPD configuration, but
- * before IPD is enabled. Users should set this pointer to a
- * function before calling any cvmx-helper operations.
- */
-void (*cvmx_override_ipd_port_setup) (int ipd_port);
-
 /* Port count per interface */
 static int interface_port_count[9];
 
@@ -436,10 +416,6 @@ static int __cvmx_helper_port_setup_ipd(int ipd_port)
 
 	cvmx_pip_config_port(ipd_port, port_config, tag_config);
 
-	/* Give the user a chance to override our setting for each port */
-	if (cvmx_override_ipd_port_setup)
-		cvmx_override_ipd_port_setup(ipd_port);
-
 	return 0;
 }
 
@@ -663,13 +639,6 @@ static int __cvmx_helper_interface_setup_pko(int interface)
 	int ipd_port = cvmx_helper_get_ipd_port(interface, 0);
 	int num_ports = interface_port_count[interface];
 	while (num_ports--) {
-		/*
-		 * Give the user a chance to override the per queue
-		 * priorities.
-		 */
-		if (cvmx_override_pko_queue_priority)
-			cvmx_override_pko_queue_priority(ipd_port, priorities);
-
 		cvmx_pko_config_port(ipd_port,
 				     cvmx_pko_get_base_queue_per_core(ipd_port,
 								      0),
diff --git a/arch/mips/include/asm/octeon/cvmx-helper.h b/arch/mips/include/asm/octeon/cvmx-helper.h
index f77d946d482e..ba0e76f578e0 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper.h
@@ -70,26 +70,6 @@ typedef union {
 #include <asm/octeon/cvmx-helper-util.h>
 #include <asm/octeon/cvmx-helper-xaui.h>
 
-/**
- * cvmx_override_pko_queue_priority(int ipd_port, uint64_t
- * priorities[16]) is a function pointer. It is meant to allow
- * customization of the PKO queue priorities based on the port
- * number. Users should set this pointer to a function before
- * calling any cvmx-helper operations.
- */
-extern void (*cvmx_override_pko_queue_priority) (int pko_port,
-						 uint64_t priorities[16]);
-
-/**
- * cvmx_override_ipd_port_setup(int ipd_port) is a function
- * pointer. It is meant to allow customization of the IPD port
- * setup before packet input/output comes online. It is called
- * after cvmx-helper does the default IPD configuration, but
- * before IPD is enabled. Users should set this pointer to a
- * function before calling any cvmx-helper operations.
- */
-extern void (*cvmx_override_ipd_port_setup) (int ipd_port);
-
 /**
  * This function enables the IPD and also enables the packet interfaces.
  * The packet interfaces (RGMII and SPI) must be enabled after the
-- 
2.17.0
