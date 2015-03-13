Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2015 18:37:14 +0100 (CET)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:46546 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013709AbbCMRfv2dsrl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Mar 2015 18:35:51 +0100
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id D09C146095A
        for <linux-mips@linux-mips.org>; Fri, 13 Mar 2015 17:35:46 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6YtqqWDvocb4; Fri, 13 Mar 2015 17:35:44 +0000 (GMT)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id A7A0E4602EF;
        Fri, 13 Mar 2015 17:35:40 +0000 (GMT)
Received: from pm by pm-laptop.codethink.co.uk with local (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1YWTUq-0000R4-FP; Fri, 13 Mar 2015 17:35:40 +0000
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Cc:     Paul Martin <paul.martin@codethink.co.uk>
Subject: [PATCH 6/6] MIPS: OCTEON: Set up ethernet hardware for little endian
Date:   Fri, 13 Mar 2015 17:34:58 +0000
Message-Id: <1426268098-1603-7-git-send-email-paul.martin@codethink.co.uk>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426268098-1603-1-git-send-email-paul.martin@codethink.co.uk>
References: <1426268098-1603-1-git-send-email-paul.martin@codethink.co.uk>
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.martin@codethink.co.uk
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

---
 drivers/staging/octeon/ethernet-tx.c |  3 +++
 drivers/staging/octeon/ethernet.c    | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index b7a7854..a078b90 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -274,6 +274,9 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/* Build the PKO command */
 	pko_command.u64 = 0;
+#ifdef __LITTLE_ENDIAN
+	pko_command.s.le = 1;
+#endif
 	pko_command.s.n2 = 1;	/* Don't pollute L2 with the outgoing packet */
 	pko_command.s.segs = 1;
 	pko_command.s.total_bytes = skb->len;
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 460e854..85618f1 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -170,6 +170,16 @@ static void cvm_oct_configure_common_hw(void)
 		cvm_oct_mem_fill_fpa(CVMX_FPA_OUTPUT_BUFFER_POOL,
 				     CVMX_FPA_OUTPUT_BUFFER_POOL_SIZE, 128);
 
+#ifdef __LITTLE_ENDIAN
+	{
+		union cvmx_ipd_ctl_status ipd_ctl_status;
+		ipd_ctl_status.u64 = cvmx_read_csr(CVMX_IPD_CTL_STATUS);
+		ipd_ctl_status.s.pkt_lend = 1;
+		ipd_ctl_status.s.wqe_lend = 1;
+		cvmx_write_csr(CVMX_IPD_CTL_STATUS, ipd_ctl_status.u64);
+	}
+#endif
+
 	if (USE_RED)
 		cvmx_helper_setup_red(num_packet_buffers / 4,
 				      num_packet_buffers / 8);
-- 
2.1.4
