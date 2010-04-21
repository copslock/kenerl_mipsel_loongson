Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Apr 2010 20:55:54 +0200 (CEST)
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:37800 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491891Ab0DUSzv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Apr 2010 20:55:51 +0200
Received: id: bigeasy by Chamillionaire.breakpoint.cc with local
        (easymta 1.00 BETA 1)
        id 1O4f5P-00020f-Ax; Wed, 21 Apr 2010 20:55:47 +0200
Date:   Wed, 21 Apr 2010 20:55:47 +0200
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [RFC] mips/swarm: fixup screen_info struct
Message-ID: <20100421185547.GA7708@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Key-Id: FE3F4706
X-Key-Fingerprint: FFDA BBBB 3563 1B27 75C9  925B 98D5 5C1C FE3F 4706
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <sebastian@breakpoint.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastian@breakpoint.cc
Precedence: bulk
X-list: linux-mips

|arch/mips/sibyte/swarm/setup.c:153:
| warning: large integer implicitly truncated to unsigned type

The field was changed in d9b26352 aka ("x86, setup: Store the boot
cursor state").
This patch changes the values back they way they were before this extra
field got introduced. I have no idea who needs it anyway.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
Using C99 initializer might be better

 arch/mips/sibyte/swarm/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index 5277aac..128b699 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -150,7 +150,7 @@ void __init plat_mem_setup(void)
 		52,             /* orig_video_page */
 		3,              /* orig_video_mode */
 		80,             /* orig_video_cols */
-		4626, 3, 9,     /* unused, ega_bx, unused */
+		12, 12, 3, 9,   /* flags, unused, ega_bx, unused */
 		25,             /* orig_video_lines */
 		0x22,           /* orig_video_isVGA */
 		16              /* orig_video_points */
-- 
1.6.6.1
