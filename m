Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2006 22:03:59 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:52748 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133724AbWBSWDu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Feb 2006 22:03:50 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 3203264D3D; Sun, 19 Feb 2006 22:10:43 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 014368D5D; Sun, 19 Feb 2006 22:10:35 +0000 (GMT)
Date:	Sun, 19 Feb 2006 22:10:35 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org,
	Stanislaw Skowronek <skylark@linux-mips.org>
Subject: Re: Merging Skylark's IOC3 patch
Message-ID: <20060219221035.GA14314@deprecation.cyrius.com>
References: <20060219211527.GA12848@deprecation.cyrius.com> <20060219215804.GR10266@deprecation.cyrius.com> <20060219220132.GT10266@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219220132.GT10266@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-02-19 22:01]:
> 21:59 < Skylark> The 6/6 isn't exactly right
> 22:00 < Skylark> It should be a part of the 5/6, really (making it 5/5)
> 22:00 < Skylark> And dependent on 4/6

Updated patch, merged 5/6 and 6/6 into 5/5.


From: Stanislaw Skowronek <skylark@linux-mips.org>

[PATCH 5/5] [MIPS] Switch IP27 to the new IOC3 UART driver

Switch IP27 to the new IOC3 UART driver.  Also now that IOC3 swapping
has been moved to where it belongs, namely into the serial layer, make
IP27 swizzle the 8-bit accesses in the correct way.

Signed-off-by: Stanislaw Skowronek <skylark@linux-mips.org>
Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

---

 arch/mips/sgi-ip27/ip27-console.c        |    2 +-
 include/asm-mips/mach-ip27/mangle-port.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-mips/mach-ip27/mangle-port.h b/include/asm-mips/mach-ip27/mangle-port.h
index f76c448..83e12e3 100644
--- a/include/asm-mips/mach-ip27/mangle-port.h
+++ b/include/asm-mips/mach-ip27/mangle-port.h
@@ -8,7 +8,7 @@
 #ifndef __ASM_MACH_IP27_MANGLE_PORT_H
 #define __ASM_MACH_IP27_MANGLE_PORT_H
 
-#define __swizzle_addr_b(port)	(port)
+#define __swizzle_addr_b(port)	((port) ^ 3)
 #define __swizzle_addr_w(port)	((port) ^ 2)
 #define __swizzle_addr_l(port)	(port)
 #define __swizzle_addr_q(port)	(port)
diff --git a/arch/mips/sgi-ip27/ip27-console.c b/arch/mips/sgi-ip27/ip27-console.c
index 3e1ac29..a973610 100644
--- a/arch/mips/sgi-ip27/ip27-console.c
+++ b/arch/mips/sgi-ip27/ip27-console.c
@@ -64,7 +64,7 @@ static void inline ioc3_console_probe(vo
 	up.irq		= 0;
 	up.uartclk	= IOC3_CLK;
 	up.regshift	= 0;
-	up.iotype	= UPIO_MEM;
+	up.iotype	= UPIO_IOC3;
 	up.flags	= IOC3_FLAGS;
 	up.line		= 0;
 


-- 
Martin Michlmayr
http://www.cyrius.com/
