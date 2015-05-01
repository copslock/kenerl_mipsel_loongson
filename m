Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2015 21:37:51 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:40966 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025943AbbEAThuXbqOc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2015 21:37:50 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 1ABC421B77C;
        Fri,  1 May 2015 22:37:51 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id ZQyvKff8BGZF; Fri,  1 May 2015 22:37:46 +0300 (EEST)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 1B26B5BC004;
        Fri,  1 May 2015 22:37:46 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RFC PATCH 01/11] MIPS: OCTEON: cvmx-helper: use function to access interface_port_count
Date:   Fri,  1 May 2015 22:37:03 +0300
Message-Id: <1430509033-12113-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
References: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47187
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

Use function to access interface_port_count. This allows moving
functions requiring the info to different files.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/cvmx-helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index 7e5cf7a..301a9ce 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -557,7 +557,7 @@ int cvmx_helper_interface_probe(int interface)
 static int __cvmx_helper_interface_setup_ipd(int interface)
 {
 	int ipd_port = cvmx_helper_get_ipd_port(interface, 0);
-	int num_ports = interface_port_count[interface];
+	int num_ports = cvmx_helper_ports_on_interface(interface);
 
 	while (num_ports--) {
 		__cvmx_helper_port_setup_ipd(ipd_port);
@@ -620,7 +620,7 @@ static int __cvmx_helper_interface_setup_pko(int interface)
 	 * priorities are set.
 	 */
 	int ipd_port = cvmx_helper_get_ipd_port(interface, 0);
-	int num_ports = interface_port_count[interface];
+	int num_ports = cvmx_helper_ports_on_interface(interface);
 	while (num_ports--) {
 		/*
 		 * Give the user a chance to override the per queue
-- 
2.3.3
