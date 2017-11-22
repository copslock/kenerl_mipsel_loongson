Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2017 03:20:50 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37585 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991033AbdKVCUP6bpNn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Nov 2017 03:20:15 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1eHKe1-0004In-EP; Wed, 22 Nov 2017 02:20:09 +0000
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1eHKdv-0002zR-Kd; Wed, 22 Nov 2017 02:20:03 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "Mathias Kresin" <dev@kresin.me>,
        "Jonas Gorski" <jonas.gorski@gmail.com>,
        "James Hogan" <james.hogan@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Date:   Wed, 22 Nov 2017 02:11:06 +0000
Message-ID: <lsq.1511316666.333111077@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 39/61] MIPS: BCM63XX: allow NULL clock for clk_get_rate
In-Reply-To: <lsq.1511316665.221837797@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.2.96-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Gorski <jonas.gorski@gmail.com>

commit 1b495faec231980b6c719994b24044ccc04ae06c upstream.

Make the behaviour of clk_get_rate consistent with common clk's
clk_get_rate by accepting NULL clocks as parameter. Some device
drivers rely on this, and will cause an OOPS otherwise.

Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx family of SOCs.")
Reported-by: Mathias Kresin <dev@kresin.me>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/16776/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/bcm63xx/clk.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -193,6 +193,9 @@ EXPORT_SYMBOL(clk_disable);
 
 unsigned long clk_get_rate(struct clk *clk)
 {
+	if (!clk)
+		return 0;
+
 	return clk->rate;
 }
 
