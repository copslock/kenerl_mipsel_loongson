Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2003 19:08:17 +0000 (GMT)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:24074 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8224827AbTC1TIP>;
	Fri, 28 Mar 2003 19:08:15 +0000
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP id F1CB0B4DB
	for <linux-mips@linux-mips.org>; Fri, 28 Mar 2003 20:08:12 +0100 (CET)
Message-ID: <3E849F22.7BC4EDE@ekner.info>
Date: Fri, 28 Mar 2003 20:14:42 +0100
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Au1000 ethernet patch
Content-Type: multipart/mixed;
 boundary="------------60A5F95BF5B2DA5B7D3F1B34"
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------60A5F95BF5B2DA5B7D3F1B34
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The following patch fixes an error where ethernet minimum packets are 4 bytes too long. This caused certain
devices not to respond to ARP requests (which is a bug on their side as well, but.....).

/Hartvig



--------------60A5F95BF5B2DA5B7D3F1B34
Content-Type: text/plain; charset=us-ascii;
 name="eth_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="eth_patch"

Index: au1000_eth.h
===================================================================
RCS file: /home/cvs/linux/drivers/net/au1000_eth.h,v
retrieving revision 1.2.2.8
diff -u -r1.2.2.8 au1000_eth.h
--- au1000_eth.h	3 Mar 2003 06:40:30 -0000	1.2.2.8
+++ au1000_eth.h	28 Mar 2003 19:05:48 -0000
@@ -36,7 +36,7 @@
 #define MAX_BUF_SIZE 2048
 
 #define ETH_TX_TIMEOUT HZ/4
-#define MAC_MIN_PKT_SIZE 64
+#define MAC_MIN_PKT_SIZE 60
 
 #if defined(CONFIG_MIPS_PB1000) || defined(CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_PB1100) || defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100) || defined(CONFIG_MIPS_DB1500)
 #define PHY_ADDRESS              0

--------------60A5F95BF5B2DA5B7D3F1B34--
