Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Oct 2002 19:35:53 +0100 (CET)
Received: from gateway-1237.mvista.com ([12.44.186.158]:32253 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1121743AbSJ2Sfw>;
	Tue, 29 Oct 2002 19:35:52 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g9TIZjY17075;
	Tue, 29 Oct 2002 10:35:45 -0800
Date: Tue, 29 Oct 2002 10:35:45 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: make xmenuconfig is broken
Message-ID: <20021029103545.K24266@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


There is an obvious typo.  

In addition, there are two SERIAL and SERIAL_CONSOLE related 
setting which should be in drivers/char/Config.in
instead of arch/mips/config-shared.in.

The following hack makes xmenuconfig work again, apparently breaking
decstation and IP22.  If nobody interested in those two machines
move the config, I will make an attempt to do so.

BTW, the symptom without the later two hacks is that you can set
SERIAL or SERIAL_CONSOLE options in xmenuconfig.

Any comments?

Jun

--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=junk

diff -Nru arch/mips/config-shared.in.orig arch/mips/config-shared.in
--- arch/mips/config-shared.in.orig	Sun Oct  6 05:28:03 2002
+++ arch/mips/config-shared.in	Tue Oct 29 10:29:14 2002
@@ -513,7 +513,7 @@
 if [ "$CONFIG_CPU_SB1" = "y" ]; then
    choice 'SB1 Pass' \
 	 "Pass1   CONFIG_CPU_SB1_PASS_1  \
-	  Pass2   CONFIG_CPU_SB1_PASS_2
+	  Pass2   CONFIG_CPU_SB1_PASS_2  \
 	  Pass2.2 CONFIG_CPU_SB1_PASS_2_2" Pass1
    if [ "$CONFIG_CPU_SB1_PASS_1" = "y" ]; then
       define_bool CONFIG_SB1_PASS_1_WORKAROUNDS y
@@ -764,18 +764,18 @@
 
 #source drivers/misc/Config.in
 
-if [ "$CONFIG_DECSTATION" = "y" ]; then
-   mainmenu_option next_comment
-   comment 'DECStation Character devices'
-
-   tristate 'Standard/generic (dumb) serial support' CONFIG_SERIAL
-   dep_bool '  DZ11 Serial Support' CONFIG_DZ $CONFIG_SERIAL
-   dep_bool '  Z85C30 Serial Support' CONFIG_ZS $CONFIG_SERIAL $CONFIG_TC
-   dep_bool '  Support for console on serial port' CONFIG_SERIAL_CONSOLE $CONFIG_SERIAL
-#   dep_bool 'MAXINE Access.Bus mouse (VSXXX-BB/GB) support' CONFIG_DTOP_MOUSE $CONFIG_ACCESSBUS
-   bool 'Enhanced Real Time Clock Support' CONFIG_RTC
-   endmenu
-fi
+#if [ "$CONFIG_DECSTATION" = "y" ]; then
+#   mainmenu_option next_comment
+#   comment 'DECStation Character devices'
+#
+#   tristate 'Standard/generic (dumb) serial support' CONFIG_SERIAL
+#   dep_bool '  DZ11 Serial Support' CONFIG_DZ $CONFIG_SERIAL
+#   dep_bool '  Z85C30 Serial Support' CONFIG_ZS $CONFIG_SERIAL $CONFIG_TC
+#   dep_bool '  Support for console on serial port' CONFIG_SERIAL_CONSOLE $CONFIG_SERIAL
+##   dep_bool 'MAXINE Access.Bus mouse (VSXXX-BB/GB) support' CONFIG_DTOP_MOUSE $CONFIG_ACCESSBUS
+#   bool 'Enhanced Real Time Clock Support' CONFIG_RTC
+#   endmenu
+#fi
 
 if [ "$CONFIG_SGI_IP22" = "y" ]; then
    mainmenu_option next_comment
@@ -814,9 +814,9 @@
 fi
 endmenu
 
-if [ "$CONFIG_SGI_IP22" = "y" ]; then
-   source drivers/sgi/Config.in
-fi
+#if [ "$CONFIG_SGI_IP22" = "y" ]; then
+#   source drivers/sgi/Config.in
+#fi
 
 source drivers/usb/Config.in
 

--7qSK/uQB79J36Y4o--
