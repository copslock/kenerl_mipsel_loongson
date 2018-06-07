Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2018 16:09:51 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:47363 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994541AbeFGOJYGhV01 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2018 16:09:24 +0200
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbM-0005hL-7h; Thu, 07 Jun 2018 15:09:20 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbE-0003Hy-5K; Thu, 07 Jun 2018 15:09:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "John Crispin" <john@phrozen.org>, linux-mips@linux-mips.org,
        "NeilBrown" <neil@brown.name>, "James Hogan" <jhogan@kernel.org>
Date:   Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.505773218@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 386/410] MIPS: ralink: Remove ralink_halt()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64208
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

From: NeilBrown <neil@brown.name>

commit 891731f6a5dbe508d12443175a7e166a2fba616a upstream.

ralink_halt() does nothing that machine_halt() doesn't already do, so it
adds no value.

It actually causes incorrect behaviour due to the "unreachable()" at the
end. This tells the compiler that the end of the function will never be
reached, which isn't true. The compiler responds by not adding a
'return' instruction, so control simply moves on to whatever bytes come
afterwards in memory. In my tested, that was the ralink_restart()
function. This means that an attempt to 'halt' the machine would
actually cause a reboot.

So remove ralink_halt() so that a 'halt' really does halt.

Fixes: c06e836ada59 ("MIPS: ralink: adds reset code")
Signed-off-by: NeilBrown <neil@brown.name>
Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18851/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/ralink/reset.c | 7 -------
 1 file changed, 7 deletions(-)

--- a/arch/mips/ralink/reset.c
+++ b/arch/mips/ralink/reset.c
@@ -88,16 +88,9 @@ static void ralink_restart(char *command
 	unreachable();
 }
 
-static void ralink_halt(void)
-{
-	local_irq_disable();
-	unreachable();
-}
-
 static int __init mips_reboot_setup(void)
 {
 	_machine_restart = ralink_restart;
-	_machine_halt = ralink_halt;
 
 	return 0;
 }
