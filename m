Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2018 16:46:48 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:50636 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994750AbeBOPqkf8Pck (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Feb 2018 16:46:40 +0100
Received: from localhost (LFbn-1-12258-90.w90-92.abo.wanadoo.fr [90.92.71.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 013A5F3E;
        Thu, 15 Feb 2018 15:46:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        David Daney <david.daney@cavium.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-mips@linux-mips.org, Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.15 174/202] EDAC, octeon: Fix an uninitialized variable warning
Date:   Thu, 15 Feb 2018 16:17:54 +0100
Message-Id: <20180215151721.968525779@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62559
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

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

commit 544e92581a2ac44607d7cc602c6b54d18656f56d upstream.

Fix an uninitialized variable warning in the Octeon EDAC driver, as seen
in MIPS cavium_octeon_defconfig builds since v4.14 with Codescape GNU
Tools 2016.05-03:

  drivers/edac/octeon_edac-lmc.c In function ‘octeon_lmc_edac_poll_o2’:
  drivers/edac/octeon_edac-lmc.c:87:24: warning: ‘((long unsigned int*)&int_reg)[1]’ may \
    be used uninitialized in this function [-Wmaybe-uninitialized]
    if (int_reg.s.sec_err || int_reg.s.ded_err) {
                        ^
Iinitialise the whole int_reg variable to zero before the conditional
assignments in the error injection case.

Signed-off-by: James Hogan <jhogan@kernel.org>
Acked-by: David Daney <david.daney@cavium.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: linux-mips@linux-mips.org
Fixes: 1bc021e81565 ("EDAC: Octeon: Add error injection support")
Link: http://lkml.kernel.org/r/20171113161206.20990-1-james.hogan@mips.com
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/edac/octeon_edac-lmc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/edac/octeon_edac-lmc.c
+++ b/drivers/edac/octeon_edac-lmc.c
@@ -78,6 +78,7 @@ static void octeon_lmc_edac_poll_o2(stru
 	if (!pvt->inject)
 		int_reg.u64 = cvmx_read_csr(CVMX_LMCX_INT(mci->mc_idx));
 	else {
+		int_reg.u64 = 0;
 		if (pvt->error_type == 1)
 			int_reg.s.sec_err = 1;
 		if (pvt->error_type == 2)
