Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Jul 2015 22:03:10 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:48971 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011916AbbGaUDI0N0mS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Jul 2015 22:03:08 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 292134A7;
        Fri, 31 Jul 2015 20:03:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>,
        David Daney <david.daney@cavium.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-mips@linux-mips.org, Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.1 256/267] EDAC, octeon: Fix broken build due to model helper renames
Date:   Fri, 31 Jul 2015 12:41:47 -0700
Message-Id: <20150731194011.686888848@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <20150731194001.933895871@linuxfoundation.org>
References: <20150731194001.933895871@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48517
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

4.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaro Koskinen <aaro.koskinen@nokia.com>

commit 75a15a7864c9e281c74a1670b10b69d1d7ff1c82 upstream.

Commit

  debe6a623d3c ("MIPS: OCTEON: Update octeon-model.h code for new SoCs.")

renamed some SoC model helper functions, but forgot to update the EDAC
drivers resulting in build failures. Fix that.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Acked-by: David Daney <david.daney@cavium.com>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: linux-mips@linux-mips.org
Link: http://lkml.kernel.org/r/1435747132-10954-1-git-send-email-aaro.koskinen@nokia.com
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/edac/octeon_edac-l2c.c |    2 +-
 drivers/edac/octeon_edac-lmc.c |    2 +-
 drivers/edac/octeon_edac-pc.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/edac/octeon_edac-l2c.c
+++ b/drivers/edac/octeon_edac-l2c.c
@@ -151,7 +151,7 @@ static int octeon_l2c_probe(struct platf
 	l2c->ctl_name = "octeon_l2c_err";
 
 
-	if (OCTEON_IS_MODEL(OCTEON_FAM_1_PLUS)) {
+	if (OCTEON_IS_OCTEON1PLUS()) {
 		union cvmx_l2t_err l2t_err;
 		union cvmx_l2d_err l2d_err;
 
--- a/drivers/edac/octeon_edac-lmc.c
+++ b/drivers/edac/octeon_edac-lmc.c
@@ -234,7 +234,7 @@ static int octeon_lmc_edac_probe(struct
 	layers[0].size = 1;
 	layers[0].is_virt_csrow = false;
 
-	if (OCTEON_IS_MODEL(OCTEON_FAM_1_PLUS)) {
+	if (OCTEON_IS_OCTEON1PLUS()) {
 		union cvmx_lmcx_mem_cfg0 cfg0;
 
 		cfg0.u64 = cvmx_read_csr(CVMX_LMCX_MEM_CFG0(0));
--- a/drivers/edac/octeon_edac-pc.c
+++ b/drivers/edac/octeon_edac-pc.c
@@ -73,7 +73,7 @@ static int  co_cache_error_event(struct
 			edac_device_handle_ce(p->ed, cpu, 0, "dcache");
 
 		/* Clear the error indication */
-		if (OCTEON_IS_MODEL(OCTEON_FAM_2))
+		if (OCTEON_IS_OCTEON2())
 			write_octeon_c0_dcacheerr(1);
 		else
 			write_octeon_c0_dcacheerr(0);
