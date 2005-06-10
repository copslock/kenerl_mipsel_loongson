Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2005 22:22:23 +0100 (BST)
Received: from orb.pobox.com ([IPv6:::ffff:207.8.226.5]:57543 "EHLO
	orb.pobox.com") by linux-mips.org with ESMTP id <S8225757AbVFJVWI>;
	Fri, 10 Jun 2005 22:22:08 +0100
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP id 9FD2D1E12
	for <linux-mips@linux-mips.org>; Fri, 10 Jun 2005 17:21:59 -0400 (EDT)
Received: from troglodyte.asianpear (c-24-21-141-200.hsd1.or.comcast.net [24.21.141.200])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 55D498B
	for <linux-mips@linux-mips.org>; Fri, 10 Jun 2005 17:21:59 -0400 (EDT)
Subject: [PATCH 2.4] inlines in au1000_eth.c
From:	Kevin Turner <kevin.m.turner@pobox.com>
To:	linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain
Date:	Fri, 10 Jun 2005 14:22:04 -0700
Message-Id: <1118438524.1513.28.camel@troglodyte.asianpear>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Return-Path: <kevin.m.turner@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevin.m.turner@pobox.com
Precedence: bulk
X-list: linux-mips

The following patch against linux_2_4 fixes this sort of compilation
error with gcc 3.4:

au1000_eth.c: In function `au1000_init_module':
au1000_eth.c:97: sorry, unimplemented: inlining failed in call to 'str2eaddr': function body not available
au1000_eth.c:1219: sorry, unimplemented: called from here

I'm not wholly sure it's the Right Thing, as I define str2eaddr in
au1000_eth.c, which makes for more code duplication.

Index: drivers/net/au1000_eth.c
===================================================================
RCS file: /home/kevint/whdd/linux-mips-cvs/linux/drivers/net/au1000_eth.c,v
retrieving revision 1.5.2.33
diff -u -r1.5.2.33 au1000_eth.c
--- drivers/net/au1000_eth.c	26 Nov 2004 08:40:13 -0000	1.5.2.33
+++ drivers/net/au1000_eth.c	10 Jun 2005 20:56:19 -0000
@@ -90,12 +90,12 @@
 static int mdio_read(struct net_device *, int, int);
 static void mdio_write(struct net_device *, int, int, u16);
 static void dump_mii(struct net_device *dev, int phy_id);
+static inline void str2eaddr(unsigned char *ea, unsigned char *str);
+static inline unsigned char str2hexnum(unsigned char c);
 
 // externs
 extern  void ack_rise_edge_irq(unsigned int);
 extern int get_ethernet_addr(char *ethernet_addr);
-extern inline void str2eaddr(unsigned char *ea, unsigned char *str);
-extern inline unsigned char str2hexnum(unsigned char c);
 extern char * __init prom_getcmdline(void);
 
 /*
@@ -146,6 +146,32 @@
 	"100BaseT", "100BaseTX", "100BaseFX"
 	};
 
+static inline void str2eaddr(unsigned char *ea, unsigned char *str)
+{
+	int i;
+
+	for (i = 0; i < 6; i++) {
+		unsigned char num;
+
+		if ((*str == '.') || (*str == ':'))
+			str++;
+		num = str2hexnum(*str++) << 4;
+		num |= (str2hexnum(*str++));
+		ea[i] = num;
+	}
+}
+
+static inline unsigned char str2hexnum(unsigned char c)
+{
+	if(c >= '0' && c <= '9')
+		return c - '0';
+	if(c >= 'a' && c <= 'f')
+		return c - 'a' + 10;
+	if(c >= 'A' && c <= 'F')
+		return c - 'A' + 10;
+	return 0; /* foo */
+}
+
 int bcm_5201_init(struct net_device *dev, int phy_addr)
 {
 	s16 data;



-- 
The moon is waxing crescent, 12.3% illuminated, 3.4 days old.
