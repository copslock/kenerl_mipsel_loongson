Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jun 2013 23:33:48 +0200 (CEST)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:45115 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835130Ab3FDVcAwkTs- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jun 2013 23:32:00 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 7CE2E56F886;
        Wed,  5 Jun 2013 00:32:00 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id Pa2fDAzvqvKN; Wed,  5 Jun 2013 00:31:55 +0300 (EEST)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp4.welho.com (Postfix) with ESMTP id 8AF695BC015;
        Wed,  5 Jun 2013 00:31:55 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 6/6] staging: octeon-usb: cvmx-usbcx-defs.h: reformat license text to fit 80 cols
Date:   Wed,  5 Jun 2013 00:31:35 +0300
Message-Id: <1370381495-3358-7-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1370381495-3358-1-git-send-email-aaro.koskinen@iki.fi>
References: <1370381495-3358-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36680
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

Reformat the original license text to fit in 80-column terminal. No
change in wording.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/staging/octeon-usb/cvmx-usbcx-defs.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/octeon-usb/cvmx-usbcx-defs.h b/drivers/staging/octeon-usb/cvmx-usbcx-defs.h
index d241191..c955e0b 100644
--- a/drivers/staging/octeon-usb/cvmx-usbcx-defs.h
+++ b/drivers/staging/octeon-usb/cvmx-usbcx-defs.h
@@ -20,16 +20,16 @@
  *     derived from this software without specific prior written
  *     permission.
 
- * This Software, including technical data, may be subject to U.S. export  control
- * laws, including the U.S. Export Administration Act and its  associated
+ * This Software, including technical data, may be subject to U.S. export
+ * control laws, including the U.S. Export Administration Act and its associated
  * regulations, and may be subject to export or import  regulations in other
  * countries.
 
  * TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
- * AND WITH ALL FAULTS AND CAVIUM  NETWORKS MAKES NO PROMISES, REPRESENTATIONS OR
+ * AND WITH ALL FAULTS AND CAVIUM NETWORKS MAKES NO PROMISES, REPRESENTATIONS OR
  * WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT TO
- * THE SOFTWARE, INCLUDING ITS CONDITION, ITS CONFORMITY TO ANY REPRESENTATION OR
- * DESCRIPTION, OR THE EXISTENCE OF ANY LATENT OR PATENT DEFECTS, AND CAVIUM
+ * THE SOFTWARE, INCLUDING ITS CONDITION, ITS CONFORMITY TO ANY REPRESENTATION
+ * OR DESCRIPTION, OR THE EXISTENCE OF ANY LATENT OR PATENT DEFECTS, AND CAVIUM
  * SPECIFICALLY DISCLAIMS ALL IMPLIED (IF ANY) WARRANTIES OF TITLE,
  * MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A PARTICULAR PURPOSE, LACK OF
  * VIRUSES, ACCURACY OR COMPLETENESS, QUIET ENJOYMENT, QUIET POSSESSION OR
-- 
1.7.10.4
