Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2004 18:08:47 +0100 (BST)
Received: from port535.ds1-van.adsl.cybercity.dk ([IPv6:::ffff:217.157.140.228]:24935
	"EHLO brian.localnet") by linux-mips.org with ESMTP
	id <S8225727AbUD2RIq>; Thu, 29 Apr 2004 18:08:46 +0100
Received: from brm by brian.localnet with local (Exim 3.36 #1 (Debian))
	id 1BJF1Z-0000zc-00; Thu, 29 Apr 2004 19:08:38 +0200
To: ralf@linux-mips.org
Subject: [PATCH 2.4] LASAT rtc fix
Cc: linux-mips@linux-mips.org
Message-Id: <E1BJF1Z-0000zc-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Thu, 29 Apr 2004 19:08:38 +0200
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf,
this makes the LASAT systems not spend 10 minutes fscking every bootup
because the rtc is read wrongly.

Please Apply.

/Brian

Index: arch/mips/lasat/ds1603.c
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/ds1603.c,v
retrieving revision 1.1.2.3
diff -u -r1.1.2.3 ds1603.c
--- arch/mips/lasat/ds1603.c	24 Feb 2003 21:26:19 -0000	1.1.2.3
+++ arch/mips/lasat/ds1603.c	29 Apr 2004 16:21:48 -0000
@@ -51,14 +51,14 @@
 {
 	data |= ds1603->clk;
 	rtc_reg_write(data);
-	ndelay(250);
+	lasat_ndelay(250);
 	if (ds1603->data_reversed)
 		data &= ~ds1603->data;
 	else
 		data |= ds1603->data;
 	data &= ~ds1603->clk;
 	rtc_reg_write(data);
-	ndelay(250 + ds1603->huge_delay);
+	lasat_ndelay(250 + ds1603->huge_delay);
 }
 
 static void rtc_write_databit(unsigned int bit)
@@ -72,7 +72,7 @@
 		data &= ~ds1603->data;
 
 	rtc_reg_write(data);
-	ndelay(50 + ds1603->huge_delay);
+	lasat_ndelay(50 + ds1603->huge_delay);
 	rtc_cycle_clock(data);
 }
 
@@ -125,13 +125,13 @@
 
 	rtc_reg_write(rtc_reg_read() & ~ds1603->clk);
 
-	ndelay(50);
+	lasat_ndelay(50);
 }
 
 static void rtc_end_op(void)
 {
 	rtc_nrst_low();
-	ndelay(1000);
+	lasat_ndelay(1000);
 }
 
 /* interface */
