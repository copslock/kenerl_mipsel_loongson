Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 15:28:54 +0200 (CEST)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:53740 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012385AbbHMNZFn2Ruh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Aug 2015 15:25:05 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd002.nsn-inter.net (8.15.1/8.15.1) with ESMTPS id t7DDOjXC010065
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 13 Aug 2015 13:24:45 GMT
Received: from localhost.localdomain ([10.144.34.184])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t7DDObQU030804;
        Thu, 13 Aug 2015 15:24:44 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Janne Huttunen <janne.huttunen@nokia.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH 11/14] MIPS: OCTEON: initialize CN68XX PKO
Date:   Thu, 13 Aug 2015 16:21:43 +0300
Message-Id: <1439472106-7750-12-git-send-email-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
References: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 5307
X-purgate-ID: 151667::1439472286-0000676C-59863BBB/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48858
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

CN68XX requires a different PKO configuration. This patch provides
just enough setup to get the XAUI interfaces on CN6880 working with
default parameters.

Signed-off-by: Janne Huttunen <janne.huttunen@nsn.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/mips/cavium-octeon/executive/cvmx-pko.c | 149 ++++++++++++++++++++++++++-
 1 file changed, 144 insertions(+), 5 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-pko.c b/arch/mips/cavium-octeon/executive/cvmx-pko.c
index 008b881..87be167 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-pko.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-pko.c
@@ -39,6 +39,143 @@
  * Internal state of packet output
  */
 
+static int __cvmx_pko_int(int interface, int index)
+{
+	switch (interface) {
+	case 0:
+		return index;
+	case 1:
+		return 4;
+	case 2:
+		return index + 0x08;
+	case 3:
+		return index + 0x0c;
+	case 4:
+		return index + 0x10;
+	case 5:
+		return 0x1c;
+	case 6:
+		return 0x1d;
+	case 7:
+		return 0x1e;
+	case 8:
+		return 0x1f;
+	default:
+		return -1;
+	}
+}
+
+static void __cvmx_pko_iport_config(int pko_port)
+{
+	int queue;
+	const int num_queues = 1;
+	const int base_queue = pko_port;
+	const int static_priority_end = 1;
+	const int static_priority_base = 1;
+
+	for (queue = 0; queue < num_queues; queue++) {
+		union cvmx_pko_mem_iqueue_ptrs config;
+		cvmx_cmd_queue_result_t cmd_res;
+		uint64_t *buf_ptr;
+
+		config.u64		= 0;
+		config.s.index		= queue;
+		config.s.qid		= base_queue + queue;
+		config.s.ipid		= pko_port;
+		config.s.tail		= (queue == (num_queues - 1));
+		config.s.s_tail		= (queue == static_priority_end);
+		config.s.static_p	= (static_priority_base >= 0);
+		config.s.static_q	= (queue <= static_priority_end);
+		config.s.qos_mask	= 0xff;
+
+		cmd_res = cvmx_cmd_queue_initialize(
+				CVMX_CMD_QUEUE_PKO(base_queue + queue),
+				CVMX_PKO_MAX_QUEUE_DEPTH,
+				CVMX_FPA_OUTPUT_BUFFER_POOL,
+				(CVMX_FPA_OUTPUT_BUFFER_POOL_SIZE -
+				 CVMX_PKO_COMMAND_BUFFER_SIZE_ADJUST * 8));
+
+		WARN(cmd_res,
+		     "%s: cmd_res=%d pko_port=%d base_queue=%d num_queues=%d queue=%d\n",
+			__func__, (int)cmd_res, pko_port, base_queue,
+			num_queues, queue);
+
+		buf_ptr = (uint64_t *)cvmx_cmd_queue_buffer(
+				CVMX_CMD_QUEUE_PKO(base_queue + queue));
+		config.s.buf_ptr = cvmx_ptr_to_phys(buf_ptr) >> 7;
+		CVMX_SYNCWS;
+		cvmx_write_csr(CVMX_PKO_MEM_IQUEUE_PTRS, config.u64);
+	}
+}
+
+static void __cvmx_pko_queue_alloc_o68(void)
+{
+	int port;
+
+	for (port = 0; port < 48; port++)
+		__cvmx_pko_iport_config(port);
+}
+
+static void __cvmx_pko_port_map_o68(void)
+{
+	int port;
+	int interface, index;
+	cvmx_helper_interface_mode_t mode;
+	union cvmx_pko_mem_iport_ptrs config;
+
+	/*
+	 * Initialize every iport with the invalid eid.
+	 */
+	config.u64 = 0;
+	config.s.eid = 31; /* Invalid */
+	for (port = 0; port < 128; port++) {
+		config.s.ipid = port;
+		cvmx_write_csr(CVMX_PKO_MEM_IPORT_PTRS, config.u64);
+	}
+
+	/*
+	 * Set up PKO_MEM_IPORT_PTRS
+	 */
+	for (port = 0; port < 48; port++) {
+		interface = cvmx_helper_get_interface_num(port);
+		index = cvmx_helper_get_interface_index_num(port);
+		mode = cvmx_helper_interface_get_mode(interface);
+		if (mode == CVMX_HELPER_INTERFACE_MODE_DISABLED)
+			continue;
+
+		config.s.ipid = port;
+		config.s.qos_mask = 0xff;
+		config.s.crc = 1;
+		config.s.min_pkt = 1;
+		config.s.intr = __cvmx_pko_int(interface, index);
+		config.s.eid = config.s.intr;
+		config.s.pipe = (mode == CVMX_HELPER_INTERFACE_MODE_LOOP) ?
+			index : port;
+		cvmx_write_csr(CVMX_PKO_MEM_IPORT_PTRS, config.u64);
+	}
+}
+
+static void __cvmx_pko_chip_init(void)
+{
+	int i;
+
+	if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
+		__cvmx_pko_port_map_o68();
+		__cvmx_pko_queue_alloc_o68();
+		return;
+	}
+
+	/*
+	 * Initialize queues
+	 */
+	for (i = 0; i < CVMX_PKO_MAX_OUTPUT_QUEUES; i++) {
+		const uint64_t priority = 8;
+
+		cvmx_pko_config_port(CVMX_PKO_MEM_QUEUE_PTRS_ILLEGAL_PID, i, 1,
+				     &priority);
+	}
+}
+
 /**
  * Call before any other calls to initialize the packet
  * output system.  This does chip global config, and should only be
@@ -47,8 +184,6 @@
 
 void cvmx_pko_initialize_global(void)
 {
-	int i;
-	uint64_t priority = 8;
 	union cvmx_pko_reg_cmd_buf config;
 
 	/*
@@ -62,9 +197,10 @@ void cvmx_pko_initialize_global(void)
 
 	cvmx_write_csr(CVMX_PKO_REG_CMD_BUF, config.u64);
 
-	for (i = 0; i < CVMX_PKO_MAX_OUTPUT_QUEUES; i++)
-		cvmx_pko_config_port(CVMX_PKO_MEM_QUEUE_PTRS_ILLEGAL_PID, i, 1,
-				     &priority);
+	/*
+	 * Chip-specific setup.
+	 */
+	__cvmx_pko_chip_init();
 
 	/*
 	 * If we aren't using all of the queues optimize PKO's
@@ -212,6 +348,9 @@ cvmx_pko_status_t cvmx_pko_config_port(uint64_t port, uint64_t base_queue,
 	int static_priority_base = -1;
 	int static_priority_end = -1;
 
+	if (OCTEON_IS_MODEL(OCTEON_CN68XX))
+		return CVMX_PKO_SUCCESS;
+
 	if ((port >= CVMX_PKO_NUM_OUTPUT_PORTS)
 	    && (port != CVMX_PKO_MEM_QUEUE_PTRS_ILLEGAL_PID)) {
 		cvmx_dprintf("ERROR: cvmx_pko_config_port: Invalid port %llu\n",
-- 
2.4.3
