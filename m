Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jun 2010 01:52:01 +0200 (CEST)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:31027 "EHLO
        sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492357Ab0FRXv4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Jun 2010 01:51:56 +0200
Authentication-Results: sj-iport-6.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApsFAAejG0yrR7Hu/2dsb2JhbACSc4wicagwmkeFGwSDUg
X-IronPort-AV: E=Sophos;i="4.53,442,1272844800"; 
   d="scan'208";a="547146279"
Received: from sj-core-5.cisco.com ([171.71.177.238])
  by sj-iport-6.cisco.com with ESMTP; 18 Jun 2010 23:51:49 +0000
Received: from dvomlehn-lnx2.corp.sa.net (dhcp-171-71-47-241.cisco.com [171.71.47.241])
        by sj-core-5.cisco.com (8.13.8/8.14.3) with ESMTP id o5INpnMF014757;
        Fri, 18 Jun 2010 23:51:49 GMT
Date:   Fri, 18 Jun 2010 16:51:49 -0700
From:   David VomLehn <dvomlehn@cisco.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH][MIPS] powertv: move device address setup before use
Message-ID: <20100618235149.GA30686@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 27172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13279

Move register setup to before reading registers.

The 4600 family code reads registers to differentiate between two ASIC
variants, but this was being done prior to the register setup. This moves
register setup before the reading code.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/mips/powertv/asic/asic_devices.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/powertv/asic/asic_devices.c b/arch/mips/powertv/asic/asic_devices.c
index 2276c18..006285c 100644
--- a/arch/mips/powertv/asic/asic_devices.c
+++ b/arch/mips/powertv/asic/asic_devices.c
@@ -472,6 +472,9 @@ void __init configure_platform(void)
 		 * it*/
 		platform_features = FFS_CAPABLE | DISPLAY_CAPABLE;
 
+		/* Cronus and Cronus Lite have the same register map */
+		set_register_map(CRONUS_IO_BASE, &cronus_register_map);
+
 		/* ASIC version will determine if this is a real CronusLite or
 		 * Castrati(Cronus) */
 		chipversion  = asic_read(chipver3) << 24;
@@ -484,8 +487,6 @@ void __init configure_platform(void)
 		else
 			asic = ASIC_CRONUSLITE;
 
-		/* Cronus and Cronus Lite have the same register map */
-		set_register_map(CRONUS_IO_BASE, &cronus_register_map);
 		gp_resources = non_dvr_cronuslite_resources;
 		pr_info("Platform: 4600 - %s, NON_DVR_CAPABLE, "
 			"chipversion=0x%08X\n",
