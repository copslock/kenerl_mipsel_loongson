Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 15:28:35 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:55552 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012384AbbHMNZE3DbXp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Aug 2015 15:25:04 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd001.nsn-inter.net (8.15.1/8.15.1) with ESMTPS id t7DDOoNP004132
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 13 Aug 2015 13:24:50 GMT
Received: from localhost.localdomain ([10.144.34.184])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t7DDObQT030804;
        Thu, 13 Aug 2015 15:24:44 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Janne Huttunen <janne.huttunen@nokia.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH 10/14] MIPS/staging: OCTEON: support CN68XX style WQE
Date:   Thu, 13 Aug 2015 16:21:42 +0300
Message-Id: <1439472106-7750-11-git-send-email-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
References: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 18100
X-purgate-ID: 151667::1439472290-00007F5C-A1DDD023/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48857
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

CN68XX has a bit different WQE structure. This patch provides the new
definitions and converts the code to use the proper variant based on
the actual model.

Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 .../cavium-octeon/executive/cvmx-helper-util.c     |   8 +-
 arch/mips/include/asm/octeon/cvmx-pow.h            |   9 +-
 arch/mips/include/asm/octeon/cvmx-wqe.h            | 308 +++++++++++++++++----
 drivers/staging/octeon/ethernet-rx.c               |  58 ++--
 drivers/staging/octeon/ethernet-tx.c               |  19 +-
 5 files changed, 304 insertions(+), 98 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-util.c b/arch/mips/cavium-octeon/executive/cvmx-helper-util.c
index 453d7f6..4029596 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-util.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-util.c
@@ -95,9 +95,9 @@ int cvmx_helper_dump_packet(cvmx_wqe_t *work)
 	uint8_t *data_address;
 	uint8_t *end_of_data;
 
-	cvmx_dprintf("Packet Length:   %u\n", work->len);
-	cvmx_dprintf("	  Input Port:  %u\n", work->ipprt);
-	cvmx_dprintf("	  QoS:	       %u\n", work->qos);
+	cvmx_dprintf("Packet Length:   %u\n", work->word1.len);
+	cvmx_dprintf("	  Input Port:  %u\n", cvmx_wqe_get_port(work));
+	cvmx_dprintf("	  QoS:	       %u\n", cvmx_wqe_get_qos(work));
 	cvmx_dprintf("	  Buffers:     %u\n", work->word2.s.bufs);
 
 	if (work->word2.s.bufs == 0) {
@@ -127,7 +127,7 @@ int cvmx_helper_dump_packet(cvmx_wqe_t *work)
 		}
 	} else
 		buffer_ptr = work->packet_ptr;
-	remaining_bytes = work->len;
+	remaining_bytes = work->word1.len;
 
 	while (remaining_bytes) {
 		start_of_buffer =
diff --git a/arch/mips/include/asm/octeon/cvmx-pow.h b/arch/mips/include/asm/octeon/cvmx-pow.h
index d5565d7..5153156 100644
--- a/arch/mips/include/asm/octeon/cvmx-pow.h
+++ b/arch/mips/include/asm/octeon/cvmx-pow.h
@@ -1810,10 +1810,11 @@ static inline void cvmx_pow_work_submit(cvmx_wqe_t *wqp, uint32_t tag,
 	cvmx_addr_t ptr;
 	cvmx_pow_tag_req_t tag_req;
 
-	wqp->qos = qos;
-	wqp->tag = tag;
-	wqp->tag_type = tag_type;
-	wqp->grp = grp;
+	wqp->word1.tag = tag;
+	wqp->word1.tag_type = tag_type;
+
+	cvmx_wqe_set_qos(wqp, qos);
+	cvmx_wqe_set_grp(wqp, grp);
 
 	tag_req.u64 = 0;
 	tag_req.s.op = CVMX_POW_TAG_OP_ADDWQ;
diff --git a/arch/mips/include/asm/octeon/cvmx-wqe.h b/arch/mips/include/asm/octeon/cvmx-wqe.h
index 2d6d0c7..0d697aa 100644
--- a/arch/mips/include/asm/octeon/cvmx-wqe.h
+++ b/arch/mips/include/asm/octeon/cvmx-wqe.h
@@ -193,6 +193,53 @@ typedef union {
 	        uint64_t bufs:8;
 #endif
 	} s;
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t bufs:8;
+		uint64_t ip_offset:8;
+		uint64_t vlan_valid:1;
+		uint64_t vlan_stacked:1;
+		uint64_t unassigned:1;
+		uint64_t vlan_cfi:1;
+		uint64_t vlan_id:12;
+		uint64_t port:12;		/* MAC/PIP port number. */
+		uint64_t dec_ipcomp:1;
+		uint64_t tcp_or_udp:1;
+		uint64_t dec_ipsec:1;
+		uint64_t is_v6:1;
+		uint64_t software:1;
+		uint64_t L4_error:1;
+		uint64_t is_frag:1;
+		uint64_t IP_exc:1;
+		uint64_t is_bcast:1;
+		uint64_t is_mcast:1;
+		uint64_t not_IP:1;
+		uint64_t rcv_error:1;
+		uint64_t err_code:8;
+#else
+		uint64_t err_code:8;
+		uint64_t rcv_error:1;
+		uint64_t not_IP:1;
+		uint64_t is_mcast:1;
+		uint64_t is_bcast:1;
+		uint64_t IP_exc:1;
+		uint64_t is_frag:1;
+		uint64_t L4_error:1;
+		uint64_t software:1;
+		uint64_t is_v6:1;
+		uint64_t dec_ipsec:1;
+		uint64_t tcp_or_udp:1;
+		uint64_t dec_ipcomp:1;
+		uint64_t port:12;
+		uint64_t vlan_id:12;
+		uint64_t vlan_cfi:1;
+		uint64_t unassigned:1;
+		uint64_t vlan_stacked:1;
+		uint64_t vlan_valid:1;
+		uint64_t ip_offset:8;
+		uint64_t bufs:8;
+#endif
+	} s_cn68xx;
 
 	/* use this to get at the 16 vlan bits */
 	struct {
@@ -355,6 +402,146 @@ typedef union {
 
 } cvmx_pip_wqe_word2;
 
+union cvmx_pip_wqe_word0 {
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		/**
+		 * raw chksum result generated by the HW
+		 */
+		uint16_t hw_chksum;
+		/**
+		 * Field unused by hardware - available for software
+		 */
+		uint8_t unused;
+		/**
+		 * Next pointer used by hardware for list maintenance.
+		 * May be written/read by HW before the work queue
+		 * entry is scheduled to a PP (Only 36 bits used in
+		 * Octeon 1)
+		 */
+		uint64_t next_ptr:40;
+#else
+		uint64_t next_ptr:40;
+		uint8_t unused;
+		uint16_t hw_chksum;
+#endif
+	} cn38xx;
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t l4ptr:8;       /* 56..63 */
+		uint64_t unused0:8;     /* 48..55 */
+		uint64_t l3ptr:8;       /* 40..47 */
+		uint64_t l2ptr:8;       /* 32..39 */
+		uint64_t unused1:18;    /* 14..31 */
+		uint64_t bpid:6;        /* 8..13 */
+		uint64_t unused2:2;     /* 6..7 */
+		uint64_t pknd:6;        /* 0..5 */
+#else
+		uint64_t pknd:6;        /* 0..5 */
+		uint64_t unused2:2;     /* 6..7 */
+		uint64_t bpid:6;        /* 8..13 */
+		uint64_t unused1:18;    /* 14..31 */
+		uint64_t l2ptr:8;       /* 32..39 */
+		uint64_t l3ptr:8;       /* 40..47 */
+		uint64_t unused0:8;     /* 48..55 */
+		uint64_t l4ptr:8;       /* 56..63 */
+#endif
+	} cn68xx;
+};
+
+union cvmx_wqe_word0 {
+	uint64_t u64;
+	union cvmx_pip_wqe_word0 pip;
+};
+
+union cvmx_wqe_word1 {
+	uint64_t u64;
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t len:16;
+		uint64_t varies:14;
+		/**
+		 * the type of the tag (ORDERED, ATOMIC, NULL)
+		 */
+		uint64_t tag_type:2;
+		uint64_t tag:32;
+#else
+		uint64_t tag:32;
+		uint64_t tag_type:2;
+		uint64_t varies:14;
+		uint64_t len:16;
+#endif
+	};
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t len:16;
+		uint64_t zero_0:1;
+		/**
+		 * HW sets this to what it thought the priority of
+		 * the input packet was
+		 */
+		uint64_t qos:3;
+
+		uint64_t zero_1:1;
+		/**
+		 * the group that the work queue entry will be scheduled to
+		 */
+		uint64_t grp:6;
+		uint64_t zero_2:3;
+		uint64_t tag_type:2;
+		uint64_t tag:32;
+#else
+		uint64_t tag:32;
+		uint64_t tag_type:2;
+		uint64_t zero_2:3;
+		uint64_t grp:6;
+		uint64_t zero_1:1;
+		uint64_t qos:3;
+		uint64_t zero_0:1;
+		uint64_t len:16;
+#endif
+	} cn68xx;
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		/**
+		 * HW sets to the total number of bytes in the packet
+		 */
+		uint64_t len:16;
+		/**
+		 * HW sets this to input physical port
+		 */
+		uint64_t ipprt:6;
+
+		/**
+		 * HW sets this to what it thought the priority of
+		 * the input packet was
+		 */
+		uint64_t qos:3;
+
+		/**
+		 * the group that the work queue entry will be scheduled to
+		 */
+		uint64_t grp:4;
+		/**
+		 * the type of the tag (ORDERED, ATOMIC, NULL)
+		 */
+		uint64_t tag_type:3;
+		/**
+		 * the synchronization/ordering tag
+		 */
+		uint64_t tag:32;
+#else
+		uint64_t tag:32;
+		uint64_t tag_type:2;
+		uint64_t zero_2:1;
+		uint64_t grp:4;
+		uint64_t qos:3;
+		uint64_t ipprt:6;
+		uint64_t len:16;
+#endif
+	} cn38xx;
+};
+
 /**
  * Work queue entry format
  *
@@ -366,70 +553,13 @@ typedef struct {
      * WORD 0
      *	HW WRITE: the following 64 bits are filled by HW when a packet arrives
      */
-
-#ifdef __BIG_ENDIAN_BITFIELD
-    /**
-     * raw chksum result generated by the HW
-     */
-	uint16_t hw_chksum;
-    /**
-     * Field unused by hardware - available for software
-     */
-	uint8_t unused;
-    /**
-     * Next pointer used by hardware for list maintenance.
-     * May be written/read by HW before the work queue
-     *		 entry is scheduled to a PP
-     * (Only 36 bits used in Octeon 1)
-     */
-	uint64_t next_ptr:40;
-#else
-	uint64_t next_ptr:40;
-	uint8_t unused;
-	uint16_t hw_chksum;
-#endif
+	union cvmx_wqe_word0 word0;
 
     /*****************************************************************
      * WORD 1
      *	HW WRITE: the following 64 bits are filled by HW when a packet arrives
      */
-
-#ifdef __BIG_ENDIAN_BITFIELD
-    /**
-     * HW sets to the total number of bytes in the packet
-     */
-	uint64_t len:16;
-    /**
-     * HW sets this to input physical port
-     */
-	uint64_t ipprt:6;
-
-    /**
-     * HW sets this to what it thought the priority of the input packet was
-     */
-	uint64_t qos:3;
-
-    /**
-     * the group that the work queue entry will be scheduled to
-     */
-	uint64_t grp:4;
-    /**
-     * the type of the tag (ORDERED, ATOMIC, NULL)
-     */
-	uint64_t tag_type:3;
-    /**
-     * the synchronization/ordering tag
-     */
-	uint64_t tag:32;
-#else
-	uint64_t tag:32;
-	uint64_t tag_type:2;
-	uint64_t zero_2:1;
-	uint64_t grp:4;
-	uint64_t qos:3;
-	uint64_t ipprt:6;
-	uint64_t len:16;
-#endif
+	union cvmx_wqe_word1 word1;
 
     /**
      * WORD 2 HW WRITE: the following 64-bits are filled in by
@@ -465,4 +595,64 @@ typedef struct {
 
 } CVMX_CACHE_LINE_ALIGNED cvmx_wqe_t;
 
+static inline int cvmx_wqe_get_port(cvmx_wqe_t *work)
+{
+	int port;
+
+	if (octeon_has_feature(OCTEON_FEATURE_CN68XX_WQE))
+		port = work->word2.s_cn68xx.port;
+	else
+		port = work->word1.cn38xx.ipprt;
+
+	return port;
+}
+
+static inline void cvmx_wqe_set_port(cvmx_wqe_t *work, int port)
+{
+	if (octeon_has_feature(OCTEON_FEATURE_CN68XX_WQE))
+		work->word2.s_cn68xx.port = port;
+	else
+		work->word1.cn38xx.ipprt = port;
+}
+
+static inline int cvmx_wqe_get_grp(cvmx_wqe_t *work)
+{
+	int grp;
+
+	if (octeon_has_feature(OCTEON_FEATURE_CN68XX_WQE))
+		grp = work->word1.cn68xx.grp;
+	else
+		grp = work->word1.cn38xx.grp;
+
+	return grp;
+}
+
+static inline void cvmx_wqe_set_grp(cvmx_wqe_t *work, int grp)
+{
+	if (octeon_has_feature(OCTEON_FEATURE_CN68XX_WQE))
+		work->word1.cn68xx.grp = grp;
+	else
+		work->word1.cn38xx.grp = grp;
+}
+
+static inline int cvmx_wqe_get_qos(cvmx_wqe_t *work)
+{
+	int qos;
+
+	if (octeon_has_feature(OCTEON_FEATURE_CN68XX_WQE))
+		qos = work->word1.cn68xx.qos;
+	else
+		qos = work->word1.cn38xx.qos;
+
+	return qos;
+}
+
+static inline void cvmx_wqe_set_qos(cvmx_wqe_t *work, int qos)
+{
+	if (octeon_has_feature(OCTEON_FEATURE_CN68XX_WQE))
+		work->word1.cn68xx.qos = qos;
+	else
+		work->word1.cn38xx.qos = qos;
+}
+
 #endif /* __CVMX_WQE_H__ */
diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
index abfe934..d1a33a9 100644
--- a/drivers/staging/octeon/ethernet-rx.c
+++ b/drivers/staging/octeon/ethernet-rx.c
@@ -70,7 +70,14 @@ static irqreturn_t cvm_oct_do_interrupt(int cpl, void *dev_id)
  */
 static inline int cvm_oct_check_rcv_error(cvmx_wqe_t *work)
 {
-	if ((work->word2.snoip.err_code == 10) && (work->len <= 64)) {
+	int port;
+
+	if (octeon_has_feature(OCTEON_FEATURE_PKND))
+		port = work->word0.pip.cn68xx.pknd;
+	else
+		port = work->word1.cn38xx.ipprt;
+
+	if ((work->word2.snoip.err_code == 10) && (work->word1.len <= 64)) {
 		/*
 		 * Ignore length errors on min size packets. Some
 		 * equipment incorrectly pads packets to 64+4FCS
@@ -87,8 +94,8 @@ static inline int cvm_oct_check_rcv_error(cvmx_wqe_t *work)
 		 * packet to determine if we can remove a non spec
 		 * preamble and generate a correct packet.
 		 */
-		int interface = cvmx_helper_get_interface_num(work->ipprt);
-		int index = cvmx_helper_get_interface_index_num(work->ipprt);
+		int interface = cvmx_helper_get_interface_num(port);
+		int index = cvmx_helper_get_interface_index_num(port);
 		union cvmx_gmxx_rxx_frm_ctl gmxx_rxx_frm_ctl;
 
 		gmxx_rxx_frm_ctl.u64 =
@@ -99,7 +106,7 @@ static inline int cvm_oct_check_rcv_error(cvmx_wqe_t *work)
 			    cvmx_phys_to_ptr(work->packet_ptr.s.addr);
 			int i = 0;
 
-			while (i < work->len - 1) {
+			while (i < work->word1.len - 1) {
 				if (*ptr != 0x55)
 					break;
 				ptr++;
@@ -109,18 +116,18 @@ static inline int cvm_oct_check_rcv_error(cvmx_wqe_t *work)
 			if (*ptr == 0xd5) {
 				/*
 				  printk_ratelimited("Port %d received 0xd5 preamble\n",
-					  work->ipprt);
+					  port);
 				 */
 				work->packet_ptr.s.addr += i + 1;
-				work->len -= i + 5;
+				work->word1.len -= i + 5;
 			} else if ((*ptr & 0xf) == 0xd) {
 				/*
 				  printk_ratelimited("Port %d received 0x?d preamble\n",
-					  work->ipprt);
+					  port);
 				 */
 				work->packet_ptr.s.addr += i;
-				work->len -= i + 4;
-				for (i = 0; i < work->len; i++) {
+				work->word1.len -= i + 4;
+				for (i = 0; i < work->word1.len; i++) {
 					*ptr =
 					    ((*ptr & 0xf0) >> 4) |
 					    ((*(ptr + 1) & 0xf) << 4);
@@ -128,7 +135,7 @@ static inline int cvm_oct_check_rcv_error(cvmx_wqe_t *work)
 				}
 			} else {
 				printk_ratelimited("Port %d unknown preamble, packet dropped\n",
-						   work->ipprt);
+						   port);
 				/*
 				   cvmx_helper_dump_packet(work);
 				 */
@@ -138,7 +145,7 @@ static inline int cvm_oct_check_rcv_error(cvmx_wqe_t *work)
 		}
 	} else {
 		printk_ratelimited("Port %d receive error code %d, packet dropped\n",
-				   work->ipprt, work->word2.snoip.err_code);
+				   port, work->word2.snoip.err_code);
 		cvm_oct_free_work(work);
 		return 1;
 	}
@@ -193,6 +200,7 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
 		struct sk_buff **pskb = NULL;
 		int skb_in_hw;
 		cvmx_wqe_t *work;
+		int port;
 
 		if (USE_ASYNC_IOBDMA && did_work_request)
 			work = cvmx_pow_work_response_async(CVMX_SCR_SCRATCH);
@@ -234,7 +242,13 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
 			prefetch(&skb->head);
 			prefetch(&skb->len);
 		}
-		prefetch(cvm_oct_device[work->ipprt]);
+
+		if (octeon_has_feature(OCTEON_FEATURE_PKND))
+			port = work->word0.pip.cn68xx.pknd;
+		else
+			port = work->word1.cn38xx.ipprt;
+
+		prefetch(cvm_oct_device[port]);
 
 		/* Immediately throw away all packets with receive errors */
 		if (unlikely(work->word2.snoip.rcv_error)) {
@@ -251,7 +265,7 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
 			skb->data = skb->head + work->packet_ptr.s.addr -
 				cvmx_ptr_to_phys(skb->head);
 			prefetch(skb->data);
-			skb->len = work->len;
+			skb->len = work->word1.len;
 			skb_set_tail_pointer(skb, skb->len);
 			packet_not_copied = 1;
 		} else {
@@ -259,7 +273,7 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
 			 * We have to copy the packet. First allocate
 			 * an skbuff for it.
 			 */
-			skb = dev_alloc_skb(work->len);
+			skb = dev_alloc_skb(work->word1.len);
 			if (!skb) {
 				cvm_oct_free_work(work);
 				continue;
@@ -282,13 +296,14 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
 					else
 						ptr += 6;
 				}
-				memcpy(skb_put(skb, work->len), ptr, work->len);
+				memcpy(skb_put(skb, work->word1.len), ptr,
+				       work->word1.len);
 				/* No packet buffers to free */
 			} else {
 				int segments = work->word2.s.bufs;
 				union cvmx_buf_ptr segment_ptr =
 				    work->packet_ptr;
-				int len = work->len;
+				int len = work->word1.len;
 
 				while (segments--) {
 					union cvmx_buf_ptr next_ptr =
@@ -324,10 +339,9 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
 			}
 			packet_not_copied = 0;
 		}
-
-		if (likely((work->ipprt < TOTAL_NUMBER_OF_PORTS) &&
-			   cvm_oct_device[work->ipprt])) {
-			struct net_device *dev = cvm_oct_device[work->ipprt];
+		if (likely((port < TOTAL_NUMBER_OF_PORTS) &&
+			   cvm_oct_device[port])) {
+			struct net_device *dev = cvm_oct_device[port];
 			struct octeon_ethernet *priv = netdev_priv(dev);
 
 			/*
@@ -347,7 +361,7 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 				/* Increment RX stats for virtual ports */
-				if (work->ipprt >= CVMX_PIP_NUM_INPUT_PORTS) {
+				if (port >= CVMX_PIP_NUM_INPUT_PORTS) {
 #ifdef CONFIG_64BIT
 					atomic64_add(1,
 						     (atomic64_t *)&priv->stats.rx_packets);
@@ -382,7 +396,7 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
 			 * doesn't exist.
 			 */
 			printk_ratelimited("Port %d not controlled by Linux, packet dropped\n",
-				   work->ipprt);
+				   port);
 			dev_kfree_skb_irq(skb);
 		}
 		/*
diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index 7c1c1b0..5883547 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -589,13 +589,14 @@ int cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
 	 * Fill in some of the work queue fields. We may need to add
 	 * more if the software at the other end needs them.
 	 */
-	work->hw_chksum = skb->csum;
-	work->len = skb->len;
-	work->ipprt = priv->port;
-	work->qos = priv->port & 0x7;
-	work->grp = pow_send_group;
-	work->tag_type = CVMX_HELPER_INPUT_TAG_TYPE;
-	work->tag = pow_send_group;	/* FIXME */
+	if (!OCTEON_IS_MODEL(OCTEON_CN68XX))
+		work->word0.pip.cn38xx.hw_chksum = skb->csum;
+	work->word1.len = skb->len;
+	cvmx_wqe_set_port(work, priv->port);
+	cvmx_wqe_set_qos(work, priv->port & 0x7);
+	cvmx_wqe_set_grp(work, pow_send_group);
+	work->word1.tag_type = CVMX_HELPER_INPUT_TAG_TYPE;
+	work->word1.tag = pow_send_group;	/* FIXME */
 	/* Default to zero. Sets of zero later are commented out */
 	work->word2.u64 = 0;
 	work->word2.s.bufs = 1;
@@ -675,8 +676,8 @@ int cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	/* Submit the packet to the POW */
-	cvmx_pow_work_submit(work, work->tag, work->tag_type, work->qos,
-			     work->grp);
+	cvmx_pow_work_submit(work, work->word1.tag, work->word1.tag_type,
+			     cvmx_wqe_get_qos(work), cvmx_wqe_get_grp(work));
 	priv->stats.tx_packets++;
 	priv->stats.tx_bytes += skb->len;
 	dev_consume_skb_any(skb);
-- 
2.4.3
