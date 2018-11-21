Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 23:38:29 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58424 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994059AbeKUWiDIPti- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 23:38:03 +0100
Received: from localhost.localdomain (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id D0AEB20096;
        Thu, 22 Nov 2018 00:38:02 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 12/24] MIPS: OCTEON: cvmx-helper-util: delete cvmx_helper_dump_packet
Date:   Thu, 22 Nov 2018 00:37:33 +0200
Message-Id: <20181121223745.22792-13-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181121223745.22792-1-aaro.koskinen@iki.fi>
References: <20181121223745.22792-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67439
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

Delete unused cvmx_helper_dump_packet().

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../executive/cvmx-helper-util.c              | 87 -------------------
 .../include/asm/octeon/cvmx-helper-util.h     |  8 --
 2 files changed, 95 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-util.c b/arch/mips/cavium-octeon/executive/cvmx-helper-util.c
index b45b2975746d..5e353a91138e 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-util.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-util.c
@@ -80,93 +80,6 @@ const char *cvmx_helper_interface_mode_to_string(cvmx_helper_interface_mode_t
 	return "UNKNOWN";
 }
 
-/**
- * Debug routine to dump the packet structure to the console
- *
- * @work:   Work queue entry containing the packet to dump
- * Returns
- */
-int cvmx_helper_dump_packet(cvmx_wqe_t *work)
-{
-	uint64_t count;
-	uint64_t remaining_bytes;
-	union cvmx_buf_ptr buffer_ptr;
-	uint64_t start_of_buffer;
-	uint8_t *data_address;
-	uint8_t *end_of_data;
-
-	cvmx_dprintf("Packet Length:   %u\n", work->word1.len);
-	cvmx_dprintf("	  Input Port:  %u\n", cvmx_wqe_get_port(work));
-	cvmx_dprintf("	  QoS:	       %u\n", cvmx_wqe_get_qos(work));
-	cvmx_dprintf("	  Buffers:     %u\n", work->word2.s.bufs);
-
-	if (work->word2.s.bufs == 0) {
-		union cvmx_ipd_wqe_fpa_queue wqe_pool;
-		wqe_pool.u64 = cvmx_read_csr(CVMX_IPD_WQE_FPA_QUEUE);
-		buffer_ptr.u64 = 0;
-		buffer_ptr.s.pool = wqe_pool.s.wqe_pool;
-		buffer_ptr.s.size = 128;
-		buffer_ptr.s.addr = cvmx_ptr_to_phys(work->packet_data);
-		if (likely(!work->word2.s.not_IP)) {
-			union cvmx_pip_ip_offset pip_ip_offset;
-			pip_ip_offset.u64 = cvmx_read_csr(CVMX_PIP_IP_OFFSET);
-			buffer_ptr.s.addr +=
-			    (pip_ip_offset.s.offset << 3) -
-			    work->word2.s.ip_offset;
-			buffer_ptr.s.addr += (work->word2.s.is_v6 ^ 1) << 2;
-		} else {
-			/*
-			 * WARNING: This code assumes that the packet
-			 * is not RAW. If it was, we would use
-			 * PIP_GBL_CFG[RAW_SHF] instead of
-			 * PIP_GBL_CFG[NIP_SHF].
-			 */
-			union cvmx_pip_gbl_cfg pip_gbl_cfg;
-			pip_gbl_cfg.u64 = cvmx_read_csr(CVMX_PIP_GBL_CFG);
-			buffer_ptr.s.addr += pip_gbl_cfg.s.nip_shf;
-		}
-	} else
-		buffer_ptr = work->packet_ptr;
-	remaining_bytes = work->word1.len;
-
-	while (remaining_bytes) {
-		start_of_buffer =
-		    ((buffer_ptr.s.addr >> 7) - buffer_ptr.s.back) << 7;
-		cvmx_dprintf("	  Buffer Start:%llx\n",
-			     (unsigned long long)start_of_buffer);
-		cvmx_dprintf("	  Buffer I   : %u\n", buffer_ptr.s.i);
-		cvmx_dprintf("	  Buffer Back: %u\n", buffer_ptr.s.back);
-		cvmx_dprintf("	  Buffer Pool: %u\n", buffer_ptr.s.pool);
-		cvmx_dprintf("	  Buffer Data: %llx\n",
-			     (unsigned long long)buffer_ptr.s.addr);
-		cvmx_dprintf("	  Buffer Size: %u\n", buffer_ptr.s.size);
-
-		cvmx_dprintf("\t\t");
-		data_address = (uint8_t *) cvmx_phys_to_ptr(buffer_ptr.s.addr);
-		end_of_data = data_address + buffer_ptr.s.size;
-		count = 0;
-		while (data_address < end_of_data) {
-			if (remaining_bytes == 0)
-				break;
-			else
-				remaining_bytes--;
-			cvmx_dprintf("%02x", (unsigned int)*data_address);
-			data_address++;
-			if (remaining_bytes && (count == 7)) {
-				cvmx_dprintf("\n\t\t");
-				count = 0;
-			} else
-				count++;
-		}
-		cvmx_dprintf("\n");
-
-		if (remaining_bytes)
-			buffer_ptr = *(union cvmx_buf_ptr *)
-				cvmx_phys_to_ptr(buffer_ptr.s.addr - 8);
-	}
-	return 0;
-}
-
 /**
  * Setup Random Early Drop on a specific input queue
  *
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-util.h b/arch/mips/include/asm/octeon/cvmx-helper-util.h
index f446f212bbd4..d88e3abb16c1 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-util.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-util.h
@@ -44,14 +44,6 @@
 extern const char
     *cvmx_helper_interface_mode_to_string(cvmx_helper_interface_mode_t mode);
 
-/**
- * Debug routine to dump the packet structure to the console
- *
- * @work:   Work queue entry containing the packet to dump
- * Returns
- */
-extern int cvmx_helper_dump_packet(cvmx_wqe_t *work);
-
 /**
  * Setup Random Early Drop on a specific input queue
  *
-- 
2.17.0
