Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 20:27:34 +0200 (CEST)
Received: from gk2-ext.lineo.com ([64.50.107.253]:6926 "HELO
	stereotomy.lineo.com") by linux-mips.org with SMTP
	id <S1122958AbSIDS1d>; Wed, 4 Sep 2002 20:27:33 +0200
Received: from Lineo.COM (vpn1 [10.9.8.1])
	by stereotomy.lineo.com (Postfix) with ESMTP id 9AD2F4C2C0
	for <linux-mips@linux-mips.org>; Wed,  4 Sep 2002 12:27:21 -0600 (MDT)
Message-ID: <3D765072.60208@Lineo.COM>
Date: Wed, 04 Sep 2002 12:26:58 -0600
From: Quinn Jensen <jensenq@Lineo.COM>
Organization: Lineo, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: patch to kaweth.c to align IP header
Content-Type: multipart/mixed;
 boundary="------------010208040308010206050609"
Return-Path: <jensenq@Lineo.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 88
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jensenq@Lineo.COM
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010208040308010206050609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

All,

The Kawasaki LSI USB Ethernet driver was causing a crash
in ipt_do_table() on mips because the address fields in
the IP header were not word aligned.  Many (all?) other
ethernet drivers do an skb_reserve of 2 to word align
the address fields, and doing this in kaweth.c fixed
my crash.

kernel: 2.4.17
hardware: Netgear EA101 USB Ethernet

Quinn



--------------010208040308010206050609
Content-Type: text/plain;
 name="linuxtx-kaweth.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linuxtx-kaweth.patch"

diff -puN -r -X - linux/drivers/usb/kaweth.c linux.modified/drivers/usb/kaweth.c
--- linux/drivers/usb/kaweth.c	Tue Nov 13 10:19:41 2001
+++ linux.modified/drivers/usb/kaweth.c	Tue Sep  3 16:07:08 2002
@@ -514,6 +514,7 @@ static void kaweth_usb_receive(struct ur
 
 		skb->dev = net;
 
+		skb_reserve(skb, 2);    /* Align IP on 16 byte boundaries */
 		eth_copy_and_sum(skb, kaweth->rx_buf + 2, pkt_len, 0);
 		
 		skb_put(skb, pkt_len);


--------------010208040308010206050609--
