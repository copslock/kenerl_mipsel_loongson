Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 13:00:08 +0000 (GMT)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:46120 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8225305AbVAJNAB>;
	Mon, 10 Jan 2005 13:00:01 +0000
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j0AD00414617
	for <linux-mips@linux-mips.org>; Mon, 10 Jan 2005 14:00:00 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j0AD00i09573
	for <linux-mips@linux-mips.org>; Mon, 10 Jan 2005 14:00:00 +0100
Message-ID: <41E27C4F.5080509@schenk.isar.de>
Date: Mon, 10 Jan 2005 13:59:59 +0100
From: Rojhalat Ibrahim <ibrahim@schenk.isar.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Titan ethernet driver and little endian
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020706030901080607040405"
Return-Path: <ibrahim@schenk.isar.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ibrahim@schenk.isar.de
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------020706030901080607040405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
the attached patch makes the titan_ge driver
work also in little-endian configuration.
Thanks
Rojhalat Ibrahim



--------------020706030901080607040405
Content-Type: text/plain;
 name="titan_ge_little_endian_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="titan_ge_little_endian_patch"

Index: titan_ge.h
===================================================================
RCS file: /home/cvs/linux/drivers/net/titan_ge.h,v
retrieving revision 1.17
diff -u -r1.17 titan_ge.h
--- titan_ge.h	4 Dec 2004 23:42:53 -0000	1.17
+++ titan_ge.h	10 Jan 2005 12:59:20 -0000
@@ -153,8 +153,10 @@
 
 /* Define the Rx descriptor */
 typedef struct eth_rx_desc {
-	u32	buffer_addr;	/* Buffer address inclusive of checksum */
-	u32     cmd_sts;	/* Command and Status info */
+	u32     buffer_addr;	/* CPU buffer address 	*/
+	u32     reserved;	/* Unused 		*/
+	u32	buffer;		/* XDMA buffer address	*/
+	u32	cmd_sts;	/* Command and Status	*/
 } titan_ge_rx_desc;
 
 /* Define the Tx descriptor */

--------------020706030901080607040405--
