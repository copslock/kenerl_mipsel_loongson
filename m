Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g75IbrRw018024
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 5 Aug 2002 11:37:53 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g75IbqBw018023
	for linux-mips-outgoing; Mon, 5 Aug 2002 11:37:52 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g75IbkRw018012
	for <linux-mips@oss.sgi.com>; Mon, 5 Aug 2002 11:37:46 -0700
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA03006
	for <linux-mips@oss.sgi.com>; Mon, 5 Aug 2002 11:39:34 -0700
Subject: DECSTATION breaks xconfig
From: Pete Popov <ppopov@mvista.com>
To: linux-mips <linux-mips@oss.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 05 Aug 2002 11:41:49 -0700
Message-Id: <1028572909.19215.61.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Spam-Status: No, hits=0.7 required=5.0 tests=TO_LOCALPART_EQ_REAL,PORN_10 version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This "if" in arch/mips/config-shared.in breaks xconfig because there are
duplicate variables, such as CONFIG_RTC, which are used elsewhere.  Why
does the DECSTATION RTC and SERIAL_CONSOLE selection have to be in this
file instead of selecting it from drivers/char/Config.in?

Pete


if [ "$CONFIG_DECSTATION" = "y" ]; then
   mainmenu_option next_comment
   comment 'DECStation Character devices'

   tristate 'Standard/generic (dumb) serial support' CONFIG_SERIAL
   dep_bool '  DZ11 Serial Support' CONFIG_DZ $CONFIG_SERIAL
   dep_bool '  Z85C30 Serial Support' CONFIG_ZS $CONFIG_SERIAL
$CONFIG_TC
   dep_bool '  Support for console on serial port' CONFIG_SERIAL_CONSOLE
$CONFIG_SERIAL
#   dep_bool 'MAXINE Access.Bus mouse (VSXXX-BB/GB) support'
CONFIG_DTOP_MOUSE $CONFIG_ACCESSBUS
   bool 'Enhanced Real Time Clock Support' CONFIG_RTC
   endmenu
fi
