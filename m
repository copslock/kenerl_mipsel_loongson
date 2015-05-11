Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 20:00:30 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35753 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027482AbbEKRzvJl1W0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 19:55:51 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E2E0CBC6;
        Mon, 11 May 2015 17:55:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 09/72] MIPS: OCTEON: Use correct CSR to soft reset
Date:   Mon, 11 May 2015 10:54:15 -0700
Message-Id: <20150511175437.388532228@linuxfoundation.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <20150511175437.112151861@linuxfoundation.org>
References: <20150511175437.112151861@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Chandrakala Chavva <cchavva@caviumnetworks.com>

Commit 9a49899eb88803dcc0ef437f09912f9a7b7a66fd upstream.

Also delete unused cvmx_reset_octeon()
This fixes reboot for Octeon III boards

Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: David Daney <david.daney@cavium.com>
Patchwork: https://patchwork.linux-mips.org/patch/9471/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/cavium-octeon/setup.c     |    5 ++++-
 arch/mips/include/asm/octeon/cvmx.h |    8 --------
 2 files changed, 4 insertions(+), 9 deletions(-)

--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -413,7 +413,10 @@ static void octeon_restart(char *command
 
 	mb();
 	while (1)
-		cvmx_write_csr(CVMX_CIU_SOFT_RST, 1);
+		if (OCTEON_IS_OCTEON3())
+			cvmx_write_csr(CVMX_RST_SOFT_RST, 1);
+		else
+			cvmx_write_csr(CVMX_CIU_SOFT_RST, 1);
 }
 
 
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -436,14 +436,6 @@ static inline uint64_t cvmx_get_cycle_gl
 
 /***************************************************************************/
 
-static inline void cvmx_reset_octeon(void)
-{
-	union cvmx_ciu_soft_rst ciu_soft_rst;
-	ciu_soft_rst.u64 = 0;
-	ciu_soft_rst.s.soft_rst = 1;
-	cvmx_write_csr(CVMX_CIU_SOFT_RST, ciu_soft_rst.u64);
-}
-
 /* Return the number of cores available in the chip */
 static inline uint32_t cvmx_octeon_num_cores(void)
 {
