Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2006 16:55:36 +0100 (BST)
Received: from userbg049.dsl.pipex.com ([62.190.246.49]:46341 "EHLO
	homer.intra.qzxyz.com") by ftp.linux-mips.org with ESMTP
	id S20039474AbWJFPzC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Oct 2006 16:55:02 +0100
Received: from lisa.intra.qzxyz.com ([192.168.42.132])
	by homer.intra.qzxyz.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GVs2J-0003N9-00
	for <linux-mips@linux-mips.org>; Fri, 06 Oct 2006 16:54:55 +0100
Message-ID: <45267C4E.8090101@talk21.com>
Date:	Fri, 06 Oct 2006 16:54:54 +0100
From:	Scott Ashcroft <scott.ashcroft@talk21.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] Time runs too quickly on Cobalt
Content-Type: multipart/mixed;
 boundary="------------070103080007020100050900"
Return-Path: <scott.ashcroft@talk21.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: scott.ashcroft@talk21.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070103080007020100050900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

If I build a kernel with HZ==250 then time runs about 4 four times too 
quickly on my Cobalt RaQ2.

The following patch seems to fix it but I'm not sure this is the correct 
thing to do.

Signed-off-by: Scott Ashcroft <scott.ashcroft@talk21.com>


--------------070103080007020100050900
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/arch/mips/cobalt/setup.c b/arch/mips/cobalt/setup.c
index c01a017..f7c6eb2 100644
--- a/arch/mips/cobalt/setup.c
+++ b/arch/mips/cobalt/setup.c
@@ -51,8 +51,8 @@ const char *get_system_type(void)
 
 void __init plat_timer_setup(struct irqaction *irq)
 {
-	/* Load timer value for 1KHz (TCLK is 50MHz) */
-	GALILEO_OUTL(50*1000*1000 / 1000, GT_TC0_OFS);
+	/* Load timer value for HZ (TCLK is 50MHz) */
+	GALILEO_OUTL(50*1000*1000 / HZ, GT_TC0_OFS);
 
 	/* Enable timer */
 	GALILEO_OUTL(GALILEO_ENTC0 | GALILEO_SELTC0, GT_TC_CONTROL_OFS);

--------------070103080007020100050900--
