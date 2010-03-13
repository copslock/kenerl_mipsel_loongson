Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Mar 2010 01:09:50 +0100 (CET)
Received: from lo.gmane.org ([80.91.229.12]:36420 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492419Ab0CMAJr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 13 Mar 2010 01:09:47 +0100
Received: from list by lo.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1NqEvI-0002oS-5J
        for linux-mips@linux-mips.org; Sat, 13 Mar 2010 01:09:44 +0100
Received: from chipmunk.wormnet.eu ([195.195.131.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sat, 13 Mar 2010 01:09:44 +0100
Received: from alex by chipmunk.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sat, 13 Mar 2010 01:09:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Alexander Clouter <alex@digriz.org.uk>
Subject: [PATCH] MIPS: AR7: fix phat finger of cpmac fixed_phy_add
Date:   Sat, 13 Mar 2010 00:09:15 +0000
Message-ID: <bm1r67-9mq.ln1@chipmunk.wormnet.eu>
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: chipmunk.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-2-sparc64-smp (sparc64))
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

Seems I trimmed one too many lines in
7084338eb8eb0cc021ba86c340157bad397f3f0b which led to no functioning
Ethernet on my WAG54Gv2.  This patch restores the AWOL line.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/mips/ar7/platform.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 0bd5f67..2fafc78 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -600,6 +600,7 @@ static int __init ar7_register_devices(void)
 	}
 
 	if (ar7_has_high_cpmac()) {
+		res = fixed_phy_add(PHY_POLL, cpmac_high.id, &fixed_phy_status);
 		if (!res) {
 			cpmac_get_mac(1, cpmac_high_data.dev_addr);
 
-- 
1.7.0
