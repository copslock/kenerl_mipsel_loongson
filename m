Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 11:14:20 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:48181 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20034533AbXJOKOM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2007 11:14:12 +0100
Received: by mo.po.2iij.net (mo32) id l9FACinO007374; Mon, 15 Oct 2007 19:12:44 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox301) id l9FAChGC007295
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 15 Oct 2007 19:12:43 +0900
Message-Id: <200710151012.l9FAChGC007295@po-mbox301.hop.2iij.net>
Date:	Mon, 15 Oct 2007 19:06:20 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp,
	linux-mips <linux-mips@linux-mips.org>,
	Jeff Garzik <jeff@garzik.org>
Subject: [PATCH][1/2][MIPS] update AU1000 get_ethernet_addr()
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Update AU1000 get_ethernet_addr().
Three functions were brought together in one.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/common/prom.c mips/arch/mips/au1000/common/prom.c
--- mips-orig/arch/mips/au1000/common/prom.c	2007-10-14 16:30:32.472075500 +0900
+++ mips/arch/mips/au1000/common/prom.c	2007-10-14 16:31:58.797470500 +0900
@@ -98,7 +98,7 @@ char *prom_getenv(char *envname)
 	return NULL;
 }
 
-inline unsigned char str2hexnum(unsigned char c)
+static inline unsigned char str2hexnum(unsigned char c)
 {
 	if(c >= '0' && c <= '9')
 		return c - '0';
@@ -109,7 +109,7 @@ inline unsigned char str2hexnum(unsigned
 	return 0; /* foo */
 }
 
-inline void str2eaddr(unsigned char *ea, unsigned char *str)
+static inline void str2eaddr(unsigned char *ea, unsigned char *str)
 {
 	int i;
 
@@ -124,35 +124,29 @@ inline void str2eaddr(unsigned char *ea,
 	}
 }
 
-int get_ethernet_addr(char *ethernet_addr)
+int prom_get_ethernet_addr(char *ethernet_addr)
 {
-        char *ethaddr_str;
+	char *ethaddr_str;
+	char *argptr;
 
-        ethaddr_str = prom_getenv("ethaddr");
+	/* Check the environment variables first */
+	ethaddr_str = prom_getenv("ethaddr");
 	if (!ethaddr_str) {
-	        printk("ethaddr not set in boot prom\n");
-		return -1;
-	}
-	str2eaddr(ethernet_addr, ethaddr_str);
+		/* Check command line */
+		argptr = prom_getcmdline();
+		ethaddr_str = strstr(argptr, "ethaddr=");
+		if (!ethaddr_str)
+			return -1;
 
-#if 0
-	{
-		int i;
-
-	printk("get_ethernet_addr: ");
-	for (i=0; i<5; i++)
-		printk("%02x:", (unsigned char)*(ethernet_addr+i));
-	printk("%02x\n", *(ethernet_addr+i));
+		ethaddr_str += strlen("ethaddr=");
 	}
-#endif
+
+	str2eaddr(ethernet_addr, ethaddr_str);
 
 	return 0;
 }
+EXPORT_SYMBOL(prom_get_ethernet_addr);
 
 void __init prom_free_prom_memory(void)
 {
 }
-
-EXPORT_SYMBOL(prom_getcmdline);
-EXPORT_SYMBOL(get_ethernet_addr);
-EXPORT_SYMBOL(str2eaddr);
diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/net/au1000_eth.c mips/drivers/net/au1000_eth.c
--- mips-orig/drivers/net/au1000_eth.c	2007-10-14 16:30:32.488076500 +0900
+++ mips/drivers/net/au1000_eth.c	2007-10-14 16:31:58.797470500 +0900
@@ -97,9 +97,7 @@ static void au1000_adjust_link(struct ne
 static void enable_mac(struct net_device *, int);
 
 // externs
-extern int get_ethernet_addr(char *ethernet_addr);
-extern void str2eaddr(unsigned char *ea, unsigned char *str);
-extern char * prom_getcmdline(void);
+extern int prom_get_ethernet_addr(char *ethernet_addr);
 
 /*
  * Theory of operation
@@ -619,7 +617,6 @@ static struct net_device * au1000_probe(
 	struct au1000_private *aup = NULL;
 	struct net_device *dev = NULL;
 	db_dest_t *pDB, *pDBfree;
-	char *pmac, *argptr;
 	char ethaddr[6];
 	int irq, i, err;
 	u32 base, macen;
@@ -677,21 +674,12 @@ static struct net_device * au1000_probe(
 	au_macs[port_num] = aup;
 
 	if (port_num == 0) {
-		/* Check the environment variables first */
-		if (get_ethernet_addr(ethaddr) == 0)
+		if (prom_get_ethernet_addr(ethaddr) == 0)
 			memcpy(au1000_mac_addr, ethaddr, sizeof(au1000_mac_addr));
 		else {
-			/* Check command line */
-			argptr = prom_getcmdline();
-			if ((pmac = strstr(argptr, "ethaddr=")) == NULL)
-				printk(KERN_INFO "%s: No MAC address found\n",
-						 dev->name);
+			printk(KERN_INFO "%s: No MAC address found\n",
+					 dev->name);
 				/* Use the hard coded MAC addresses */
-			else {
-				str2eaddr(ethaddr, pmac + strlen("ethaddr="));
-				memcpy(au1000_mac_addr, ethaddr,
-				       sizeof(au1000_mac_addr));
-			}
 		}
 
 		setup_hw_rings(aup, MAC0_RX_DMA_ADDR, MAC0_TX_DMA_ADDR);
