Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2015 21:38:46 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:40977 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026285AbbEAThwB2KdL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2015 21:37:52 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 5154421B7B4;
        Fri,  1 May 2015 22:37:52 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id M83VW8EVXeqn; Fri,  1 May 2015 22:37:47 +0300 (EEST)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 465E15BC006;
        Fri,  1 May 2015 22:37:47 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RFC PATCH 03/11] MIPS: OCTEON: make __cvmx_helper_sgmii/xaui_probe void
Date:   Fri,  1 May 2015 22:37:05 +0300
Message-Id: <1430509033-12113-4-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
References: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47190
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

Make __cvmx_helper_sgmii/xaui_probe void, nobody is using return values
and this makes functions independent of enumeration functions.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c | 5 +----
 arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c  | 5 +----
 arch/mips/include/asm/octeon/cvmx-helper-sgmii.h      | 2 +-
 arch/mips/include/asm/octeon/cvmx-helper-xaui.h       | 2 +-
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
index 6f9609e..6a47b04 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
@@ -340,10 +340,8 @@ int __cvmx_helper_sgmii_enumerate(int interface)
  * this call.
  *
  * @interface: Interface to probe
- *
- * Returns Number of ports on the interface. Zero to disable.
  */
-int __cvmx_helper_sgmii_probe(int interface)
+void __cvmx_helper_sgmii_probe(int interface)
 {
 	union cvmx_gmxx_inf_mode mode;
 
@@ -355,7 +353,6 @@ int __cvmx_helper_sgmii_probe(int interface)
 	mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
 	mode.s.en = 1;
 	cvmx_write_csr(CVMX_GMXX_INF_MODE(interface), mode.u64);
-	return __cvmx_helper_sgmii_enumerate(interface);
 }
 
 /**
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
index 7653b7e..49d7507 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
@@ -63,10 +63,8 @@ int __cvmx_helper_xaui_enumerate(int interface)
  * after this call.
  *
  * @interface: Interface to probe
- *
- * Returns Number of ports on the interface. Zero to disable.
  */
-int __cvmx_helper_xaui_probe(int interface)
+void __cvmx_helper_xaui_probe(int interface)
 {
 	int i;
 	union cvmx_gmxx_inf_mode mode;
@@ -102,7 +100,6 @@ int __cvmx_helper_xaui_probe(int interface)
 		pko_mem_port_ptrs.s.pid = interface * 16 + i;
 		cvmx_write_csr(CVMX_PKO_MEM_PORT_PTRS, pko_mem_port_ptrs.u64);
 	}
-	return __cvmx_helper_xaui_enumerate(interface);
 }
 
 /**
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-sgmii.h b/arch/mips/include/asm/octeon/cvmx-helper-sgmii.h
index 4debb1c..eb51835 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-sgmii.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-sgmii.h
@@ -44,7 +44,7 @@
  *
  * Returns Number of ports on the interface. Zero to disable.
  */
-extern int __cvmx_helper_sgmii_probe(int interface);
+extern void __cvmx_helper_sgmii_probe(int interface);
 extern int __cvmx_helper_sgmii_enumerate(int interface);
 
 /**
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-xaui.h b/arch/mips/include/asm/octeon/cvmx-helper-xaui.h
index 5e89ed7..9fbcea3 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-xaui.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-xaui.h
@@ -44,7 +44,7 @@
  *
  * Returns Number of ports on the interface. Zero to disable.
  */
-extern int __cvmx_helper_xaui_probe(int interface);
+extern void __cvmx_helper_xaui_probe(int interface);
 extern int __cvmx_helper_xaui_enumerate(int interface);
 
 /**
-- 
2.3.3
