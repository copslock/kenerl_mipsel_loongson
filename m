Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2006 21:51:57 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:38668 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133588AbWBSVvT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Feb 2006 21:51:19 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id F238164D59; Sun, 19 Feb 2006 21:58:11 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id DB5348D5D; Sun, 19 Feb 2006 21:58:04 +0000 (GMT)
Date:	Sun, 19 Feb 2006 21:58:04 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org,
	Stanislaw Skowronek <skylark@linux-mips.org>
Subject: Re: Merging Skylark's IOC3 patch
Message-ID: <20060219215804.GR10266@deprecation.cyrius.com>
References: <20060219211527.GA12848@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219211527.GA12848@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Ralf, please apply.


From: Stanislaw Skowronek <skylark@linux-mips.org>

[PATCH 5/6] [MIPS] Make 8-bit devices on PCI work on IP27

Fix the definition of __swizzle_addr_b and make 8-bit PCI devices work
on IP27.

Signed-off-by: Stanislaw Skowronek <skylark@linux-mips.org>
Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

---

 mangle-port.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

-- 
Martin Michlmayr
http://www.cyrius.com/
