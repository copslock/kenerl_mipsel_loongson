Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2006 13:44:49 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:25040 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038413AbWJaNor (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Oct 2006 13:44:47 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id k9VDjHo4007873;
	Tue, 31 Oct 2006 13:45:17 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id k9VDjGvx007872;
	Tue, 31 Oct 2006 13:45:16 GMT
Date:	Tue, 31 Oct 2006 13:45:16 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix wrong prom_getcmdline() definition
Message-ID: <20061031134516.GA7795@linux-mips.org>
References: <200610310445.k9V4jFXT012552@mbox33.po.2iij.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610310445.k9V4jFXT012552@mbox33.po.2iij.net>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 31, 2006 at 01:40:07PM +0900, Yoichi Yuasa wrote:

> This patch has fixed wrong prom_getcmdline() definition.

Fortunately an __init declaration of a function leaves the compiler
entirely unimpressed.  Your patch only scratched the surface of the
problem; so I went for below patch.  Further cleanup should be done but
that would be unsuitable for 2.6.19 now that -rc4 is out.

  Ralf

diff --git a/arch/mips/au1000/common/prom.c b/arch/mips/au1000/common/prom.c
index b4b010a..6fce60a 100644
--- a/arch/mips/au1000/common/prom.c
+++ b/arch/mips/au1000/common/prom.c
@@ -47,7 +47,7 @@ extern int prom_argc;
 extern char **prom_argv, **prom_envp;
 
 
-char * prom_getcmdline(void)
+char * __init_or_module prom_getcmdline(void)
 {
 	return &(arcs_cmdline[0]);
 }
diff --git a/arch/mips/au1000/common/setup.c b/arch/mips/au1000/common/setup.c
index 377ae0d..919172d 100644
--- a/arch/mips/au1000/common/setup.c
+++ b/arch/mips/au1000/common/setup.c
@@ -43,7 +43,7 @@ #include <asm/pgtable.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/time.h>
 
-extern char * __init prom_getcmdline(void);
+extern char * prom_getcmdline(void);
 extern void __init board_setup(void);
 extern void au1000_restart(char *);
 extern void au1000_halt(void);
diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
index 4873dc6..7db3c8a 100644
--- a/drivers/net/au1000_eth.c
+++ b/drivers/net/au1000_eth.c
@@ -102,7 +102,7 @@ static void enable_mac(struct net_device
 // externs
 extern int get_ethernet_addr(char *ethernet_addr);
 extern void str2eaddr(unsigned char *ea, unsigned char *str);
-extern char * __init prom_getcmdline(void);
+extern char * prom_getcmdline(void);
 
 /*
  * Theory of operation
diff --git a/drivers/net/gt64240eth.c b/drivers/net/gt64240eth.c
index f543930..7859202 100644
--- a/drivers/net/gt64240eth.c
+++ b/drivers/net/gt64240eth.c
@@ -127,7 +127,7 @@ static void gt64240_tx_timeout(struct ne
 static void gt64240_set_rx_mode(struct net_device *dev);
 static struct net_device_stats *gt64240_get_stats(struct net_device *dev);
 
-extern char *__init prom_getcmdline(void);
+extern char * prom_getcmdline(void);
 extern int prom_get_mac_addrs(unsigned char
 			      station_addr[NUM_INTERFACES][6]);
 
