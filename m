Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2018 16:09:36 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:47356 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994427AbeFGOJYGZ5f1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2018 16:09:24 +0200
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbM-0005Zj-T3; Thu, 07 Jun 2018 15:09:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbE-0003Hs-4b; Thu, 07 Jun 2018 15:09:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "John Crispin" <blogic@openwrt.org>
Date:   Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.412991301@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 385/410] MIPS: ralink: Don't set pm_power_off
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64207
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

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: John Crispin <blogic@openwrt.org>

commit 81ab9f6c5ff8565e4cba330e340a8979a10521d7 upstream.

Setting pm_power_off is apprently wrong and makes drivers such as
gpio-poweroff not work.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/11445/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/ralink/reset.c | 1 -
 1 file changed, 1 deletion(-)

--- a/arch/mips/ralink/reset.c
+++ b/arch/mips/ralink/reset.c
@@ -98,7 +98,6 @@ static int __init mips_reboot_setup(void
 {
 	_machine_restart = ralink_restart;
 	_machine_halt = ralink_halt;
-	pm_power_off = ralink_halt;
 
 	return 0;
 }
