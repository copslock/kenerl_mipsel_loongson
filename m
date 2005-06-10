Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2005 22:06:14 +0100 (BST)
Received: from orb.pobox.com ([IPv6:::ffff:207.8.226.5]:11718 "EHLO
	orb.pobox.com") by linux-mips.org with ESMTP id <S8225757AbVFJVF6>;
	Fri, 10 Jun 2005 22:05:58 +0100
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP id D46161E9D
	for <linux-mips@linux-mips.org>; Fri, 10 Jun 2005 17:05:48 -0400 (EDT)
Received: from troglodyte.asianpear (c-24-21-141-200.hsd1.or.comcast.net [24.21.141.200])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C7FD8B
	for <linux-mips@linux-mips.org>; Fri, 10 Jun 2005 17:05:48 -0400 (EDT)
Subject: [PATCH 2.4] cleanup printk __FUNCTION__ in clocks.c
From:	Kevin Turner <kevin.m.turner@pobox.com>
To:	linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain
Date:	Fri, 10 Jun 2005 14:05:53 -0700
Message-Id: <1118437553.1513.22.camel@troglodyte.asianpear>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Return-Path: <kevin.m.turner@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevin.m.turner@pobox.com
Precedence: bulk
X-list: linux-mips

The following patch against linux_2_4 cleans up this little compilation error:

clocks.c: In function `set_au1x00_lcd_clock':
clocks.c:89: error: parse error before string constant
clocks.c:90: warning: left-hand operand of comma expression has no effect
clocks.c:90: error: parse error before ')' token


Index: arch/mips/au1000/common/clocks.c
===================================================================
RCS file: /home/kevint/whdd/linux-mips-cvs/linux/arch/mips/au1000/common/clocks.c,v
retrieving revision 1.2.2.5
diff -u -r1.2.2.5 clocks.c
--- arch/mips/au1000/common/clocks.c	12 May 2004 07:31:08 -0000	1.2.2.5
+++ arch/mips/au1000/common/clocks.c	10 Jun 2005 20:55:59 -0000
@@ -85,9 +85,8 @@
 		lcd_clock = sys_busclk / 4;
 
 	if (lcd_clock > 50000) /* Epson MAX */
-			printk(__FUNCTION__
-			       ": warning: LCD clock too high (%d KHz)\n",
-			       lcd_clock);
+			printk("%s: warning: LCD clock too high (%d KHz)\n",
+			       __FUNCTION__, lcd_clock);
 }
 
 unsigned int get_au1x00_lcd_clock(void)


-- 
The moon is waxing crescent, 12.3% illuminated, 3.4 days old.
