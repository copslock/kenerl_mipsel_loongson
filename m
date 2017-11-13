Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 17:13:51 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:60943 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990426AbdKMQNnOqMCu convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Nov 2017 17:13:43 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 13 Nov 2017 16:12:35 +0000
Received: from jhogan-linux.mipstec.com (192.168.154.110) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Mon, 13 Nov 2017 08:12:21 -0800
From:   James Hogan <james.hogan@mips.com>
To:     David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Daniel Walker <dwalker@fifo99.com>
CC:     James Hogan <jhogan@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Steven J . Hill" <steven.hill@cavium.com>,
        <linux-edac@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: [PATCH RFC] EDAC: octeon: Fix uninitialized variable warning
Date:   Mon, 13 Nov 2017 16:12:06 +0000
Message-ID: <20171113161206.20990-1-james.hogan@mips.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510589533-321459-27081-257643-2
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186880
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

From: James Hogan <jhogan@kernel.org>

Fix uninitialized variable warning in the Octeon EDAC driver, as seen in
MIPS cavium_octeon_defconfig builds since v4.14 with Codescape GNU Tools
2016.05-03:

drivers/edac/octeon_edac-lmc.c In function ‘octeon_lmc_edac_poll_o2’:
drivers/edac/octeon_edac-lmc.c:87:24: warning: ‘((long unsigned int*)&int_reg)[1]’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  if (int_reg.s.sec_err || int_reg.s.ded_err) {
                        ^

This was introduced in commit 1bc021e81565 ("EDAC: Octeon: Add error
injection support"), and is fixed by initialising the whole int_reg
variable to zero before the conditional assignments in the error
injection case.

Fixes: 1bc021e81565 ("EDAC: Octeon: Add error injection support")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Steven J. Hill <steven.hill@cavium.com>
Cc: linux-edac@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.15+
---
Comments appreciated. Is this correct?

I've added the stable tag on the assumption that this might matter. If
not it can be changed. It'd be nice to have it in 4.14 though to silence
the warning since the driver was added to cavium_octeon_defconfig in
commit f922bc0ad08b ("MIPS: Octeon: cavium_octeon_defconfig: Enable more
drivers").
---
 drivers/edac/octeon_edac-lmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/octeon_edac-lmc.c b/drivers/edac/octeon_edac-lmc.c
index 9c1ffe3e912b..aeb222ca3ed1 100644
--- a/drivers/edac/octeon_edac-lmc.c
+++ b/drivers/edac/octeon_edac-lmc.c
@@ -78,6 +78,7 @@ static void octeon_lmc_edac_poll_o2(struct mem_ctl_info *mci)
 	if (!pvt->inject)
 		int_reg.u64 = cvmx_read_csr(CVMX_LMCX_INT(mci->mc_idx));
 	else {
+		int_reg.u64 = 0;
 		if (pvt->error_type == 1)
 			int_reg.s.sec_err = 1;
 		if (pvt->error_type == 2)
-- 
2.14.1
