Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2007 23:19:59 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:9604 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022868AbXGWWT5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jul 2007 23:19:57 +0100
Received: from lagash (88-106-245-10.dynamic.dsl.as9105.com [88.106.245.10])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 1B86686E94;
	Mon, 23 Jul 2007 23:09:08 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1ID59P-00064j-I1; Mon, 23 Jul 2007 22:09:07 +0100
Date:	Mon, 23 Jul 2007 22:09:07 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Silence warning for bcm1480
Message-ID: <20070723210907.GA20558@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

The appended patch effectively syncs up the setup of sb1250 and bcm1480.

For bcm1480/setup.c:
- include <linux/module.h>, as needed for EXPORT_SYMBOL
- include <linux/init.h>, and add __init specifiers to the setup code
- remove explicit inline for those functions
- export zbbus_mhz as it is done for sb1250

For sb1250/setup.c:
- remove bogus inline keywords


Thiemo


Signed-Off-By: Thiemo Seufer <ths@networkno.de>

--- a/arch/mips/sibyte/bcm1480/setup.c
+++ b/arch/mips/sibyte/bcm1480/setup.c
@@ -15,6 +15,8 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
+#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/reboot.h>
 #include <linux/string.h>
@@ -34,17 +36,18 @@ unsigned int soc_type;
 EXPORT_SYMBOL(soc_type);
 unsigned int periph_rev;
 unsigned int zbbus_mhz;
+EXPORT_SYMBOL(zbbus_mhz);
 
 static unsigned int part_type;
 
 static char *soc_str;
 static char *pass_str;
 
-static inline int setup_bcm1x80_bcm1x55(void);
+static int setup_bcm1x80_bcm1x55(void);
 
 /* Setup code likely to be common to all SiByte platforms */
 
-static inline int sys_rev_decode(void)
+static int __init sys_rev_decode(void)
 {
 	int ret = 0;
 
@@ -77,7 +80,7 @@ static inline int sys_rev_decode(void)
 	return ret;
 }
 
-static inline int setup_bcm1x80_bcm1x55(void)
+static int __init setup_bcm1x80_bcm1x55(void)
 {
 	int ret = 0;
 
@@ -111,7 +114,7 @@ static inline int setup_bcm1x80_bcm1x55(void)
 	return ret;
 }
 
-void bcm1480_setup(void)
+void __init bcm1480_setup(void)
 {
 	uint64_t sys_rev;
 	int plldiv;
--- a/arch/mips/sibyte/sb1250/setup.c
+++ b/arch/mips/sibyte/sb1250/setup.c
@@ -40,8 +40,8 @@ static char *soc_str;
 static char *pass_str;
 static unsigned int war_pass;	/* XXXKW don't overload PASS defines? */
 
-static inline int setup_bcm1250(void);
-static inline int setup_bcm112x(void);
+static int setup_bcm1250(void);
+static int setup_bcm112x(void);
 
 /* Setup code likely to be common to all SiByte platforms */
 
