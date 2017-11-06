Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 00:54:19 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33862 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990506AbdKFXyLbxY9f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 00:54:11 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1eBrDU-0008UD-AG; Mon, 06 Nov 2017 23:54:08 +0000
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1eBrDT-00012q-LO; Mon, 06 Nov 2017 23:54:07 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Kevin Cernekee" <cernekee@gmail.com>,
        jfraser@broadcom.com, linux-mips@linux-mips.org,
        f.fainelli@gmail.com, "Arnd Bergmann" <arnd@arndb.de>,
        mbizon@freebox.fr, "Ralf Baechle" <ralf@linux-mips.org>,
        devicetree@vger.kernel.org, jogo@openwrt.org
Date:   Mon, 06 Nov 2017 23:03:02 +0000
Message-ID: <lsq.1510009382.234145624@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 277/294] MIPS: BMIPS: Fix ".previous without
 corresponding .section" warnings
In-Reply-To: <lsq.1510009377.526284287@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60728
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

3.16.50-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kevin Cernekee <cernekee@gmail.com>

commit 4ec8f9e9b08451303253249e4e302f10ee23d565 upstream.

Commit 078a55fc824c1 ("Delete __cpuinit/__CPUINIT usage from MIPS code")
removed our __CPUINIT directives, so now the ".previous" directives
are superfluous.  Remove them.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Cc: f.fainelli@gmail.com
Cc: mbizon@freebox.fr
Cc: jogo@openwrt.org
Cc: jfraser@broadcom.com
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/8156/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/bmips_vec.S | 3 ---
 1 file changed, 3 deletions(-)

--- a/arch/mips/kernel/bmips_vec.S
+++ b/arch/mips/kernel/bmips_vec.S
@@ -211,7 +211,6 @@ bmips_reset_nmi_vec_end:
 END(bmips_reset_nmi_vec)
 
 	.set	pop
-	.previous
 
 /***********************************************************************
  * CPU1 warm restart vector (used for second and subsequent boots).
@@ -286,5 +285,3 @@ LEAF(bmips_enable_xks01)
 	jr	ra
 
 END(bmips_enable_xks01)
-
-	.previous
