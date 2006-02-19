Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2006 21:52:42 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:40460 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133569AbWBSVvr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Feb 2006 21:51:47 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id DF04C64D3D; Sun, 19 Feb 2006 21:58:39 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 47F308D5D; Sun, 19 Feb 2006 21:58:32 +0000 (GMT)
Date:	Sun, 19 Feb 2006 21:58:32 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org,
	Stanislaw Skowronek <skylark@linux-mips.org>
Subject: Re: Merging Skylark's IOC3 patch
Message-ID: <20060219215832.GS10266@deprecation.cyrius.com>
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
X-archive-position: 10521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

To be applied after the IOC3 UART driver has been accepted.


From: Stanislaw Skowronek <skylark@linux-mips.org>

[PATCH 6/6] [MIPS] Switch IP27 to the new IOC3 UART driver

Signed-off-by: Stanislaw Skowronek <skylark@linux-mips.org>
Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

---

 ip27-console.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
