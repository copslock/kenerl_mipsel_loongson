Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Mar 2004 17:13:39 +0000 (GMT)
Received: from p508B763E.dip.t-dialin.net ([IPv6:::ffff:80.139.118.62]:29994
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225507AbUCTRNi>; Sat, 20 Mar 2004 17:13:38 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2KHDaMk006348;
	Sat, 20 Mar 2004 18:13:36 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2KHDZ2O006347;
	Sat, 20 Mar 2004 18:13:35 +0100
Date: Sat, 20 Mar 2004 18:13:35 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Martin C. Barlow" <mips@martin.barlow.name>
Cc: linux-mips@linux-mips.org
Subject: Re: hwclock and df seg fault
Message-ID: <20040320171335.GA5764@linux-mips.org>
References: <20040320122201.GA32242@linux-mips.org> <000101c40e9b$18d887e0$6500a8c0@colombia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101c40e9b$18d887e0$6500a8c0@colombia>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

The RTC bug was trivial, patch below and in CVS,

  Ralf

Index: drivers/char/ds1286.c
===================================================================
RCS file: /home/cvs/linux/drivers/char/ds1286.c,v
retrieving revision 1.9
diff -u -r1.9 ds1286.c
--- drivers/char/ds1286.c	22 Jan 2004 02:15:40 -0000	1.9
+++ drivers/char/ds1286.c	20 Mar 2004 17:09:39 -0000
@@ -254,7 +254,7 @@
 
 	ds1286_status |= RTC_IS_OPEN;
 
-	spin_lock_irq(&ds1286_lock);
+	spin_unlock_irq(&ds1286_lock);
 	return 0;
 
 out_busy:
