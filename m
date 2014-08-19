Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2014 04:55:14 +0200 (CEST)
Received: from qmta14.westchester.pa.mail.comcast.net ([76.96.59.212]:46151
        "EHLO qmta14.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816503AbaHSCzLCt99H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2014 04:55:11 +0200
Received: from omta13.westchester.pa.mail.comcast.net ([76.96.62.52])
        by qmta14.westchester.pa.mail.comcast.net with comcast
        id gRzZ1o00217dt5G5ESv40S; Tue, 19 Aug 2014 02:55:04 +0000
Received: from [192.168.1.13] ([50.190.84.14])
        by omta13.westchester.pa.mail.comcast.net with comcast
        id gSv41o0070JZ7Re3ZSv49U; Tue, 19 Aug 2014 02:55:04 +0000
Message-ID: <53F2BC86.8000506@gentoo.org>
Date:   Mon, 18 Aug 2014 22:55:02 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: IP28: Correct IO_BASE in mach-ip28/spaces.h for proper
 ioremap
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1408416904;
        bh=udqjCuYdP//nyWw8+BsjIF3E7DYBS/B3kbyzk4D0y8o=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=lMloXOoIu7Qafz143juCFdszQOBryiOwrd07rQYkVQc24t7Zat+ZECRC0Mihd9+51
         jAhlyxhKjZfl8SjJzomGe7h8gsr7uqMU8pPam/eHnspysIGTu7/QELRDlYOVCgl+rF
         6VDKe8a3lj13Em/6x+hupoXY5GPHgE5YFoDX5gZ0YesToHabXAoiE7pB3ugiyXGZdM
         BK5ANEamq8e4Naqmrg8xiQWNdhgxKwcsjNpu4Objs1OP1/3vraY9Jcz5UYkx0/Mux5
         nJi7v1ToOA2IBU3GSO9KsVuK/KqWySMD5bhGujwUOlfsmit4runlAD1teJXGopP4Qm
         pFdMJAyZZv0WQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On SGI IP28 systems, fix an early crash at boot by setting IO_BASE to a
correct value so that ioremap works properly.

Exception: <vector=normal>
Status register: 0x34004882<CU1,CU0,FR,IM7,IM4,IPL=???,KX,MODE=KERNEL>
Cause register: 0x10<CE=0,EXC=RADE>
Exception PC: 0xa800000020654004, Exception RA: 0xa800000020654c9c
Read address error exception, bad address: 0xdfbdd600

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
Reported-by: Joshua Kinard <kumba@gentoo.org>
Suggested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Tested-by: Joshua Kinard <kumba@gentoo.org>
Fixes: ed3ce16c3d2b ("Revert "MIPS: make CAC_ADDR and UNCAC_ADDR account for
PHYS_OFFSET"")
---
 arch/mips/include/asm/mach-ip28/spaces.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-ip28/spaces.h
b/arch/mips/include/asm/mach-ip28/spaces.h
index 5d6a764..8c60fb0 100644
--- a/arch/mips/include/asm/mach-ip28/spaces.h
+++ b/arch/mips/include/asm/mach-ip28/spaces.h
@@ -18,7 +18,7 @@
 #define PHYS_OFFSET	_AC(0x20000000, UL)

 #define UNCAC_BASE	_AC(0xc0000000, UL)     /* 0xa0000000 + PHYS_OFFSET */
-#define IO_BASE		UNCAC_BASE
+#define IO_BASE		_AC(0x9000000000000000, UL)

 #include <asm/mach-generic/spaces.h>
