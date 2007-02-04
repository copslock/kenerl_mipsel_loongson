Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Feb 2007 04:18:43 +0000 (GMT)
Received: from tomts36.bellnexxia.net ([209.226.175.93]:5113 "EHLO
	tomts36-srv.bellnexxia.net") by ftp.linux-mips.org with ESMTP
	id S20027627AbXBDESi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 Feb 2007 04:18:38 +0000
Received: from krystal.dyndns.org ([67.68.196.179])
          by tomts36-srv.bellnexxia.net
          (InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP
          id <20070204041651.LQAF1862.tomts36-srv.bellnexxia.net@krystal.dyndns.org>
          for <linux-mips@linux-mips.org>; Sat, 3 Feb 2007 23:16:51 -0500
Received: from localhost (localhost [127.0.0.1])
  (uid 1000)
  by krystal.dyndns.org with local; Sat, 03 Feb 2007 23:16:51 -0500
  id 001C247E.45C55E33.000022E4
Date:	Sat, 3 Feb 2007 23:16:51 -0500
From:	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To:	linux-mips@linux-mips.org
Cc:	linux-kernel@vger.kernel.org
Subject: [PATCH] ifdef missing in arch/mips/pmc-sierra/yosemite/setup.c
Message-ID: <20070204041651.GA8732@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info:	http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.34-grsec (i686)
X-Uptime: 23:15:02 up 1 day, 18:23,  2 users,  load average: 1.18, 1.05, 1.01
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <compudj@krystal.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mathieu.desnoyers@polymtl.ca
Precedence: bulk
X-list: linux-mips

ifdef missing in arch/mips/pmc-sierra/yosemite/setup.c

early_serial_setup is only defined when CONFIG_SERIAL_8250 is set.
Applies on 2.6.20-rc7.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/arch/mips/pmc-sierra/yosemite/setup.c
+++ b/arch/mips/pmc-sierra/yosemite/setup.c
@@ -171,6 +171,7 @@ static void __init py_map_ocd(void)
 
 static void __init py_uart_setup(void)
 {
+#ifdef CONFIG_SERIAL_8250
 	struct uart_port up;
 
 	/*
@@ -188,6 +189,7 @@ static void __init py_uart_setup(void)
 
 	if (early_serial_setup(&up))
 		printk(KERN_ERR "Early serial init of port 0 failed\n");
+#endif //CONFIG_SERIAL_8250
 }
 
 static void __init py_rtc_setup(void)
-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
