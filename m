Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6D0s8g03398
	for linux-mips-outgoing; Thu, 12 Jul 2001 17:54:08 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6D0s6V03393
	for <linux-mips@oss.sgi.com>; Thu, 12 Jul 2001 17:54:06 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f6CNs0W27406;
	Thu, 12 Jul 2001 16:54:00 -0700
Message-ID: <3B4E45D9.8DBE84E7@mvista.com>
Date: Thu, 12 Jul 2001 17:50:33 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: RFC: run-time defining serial ports
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


As more and more boards are added to Linux-mips tree, many places are getting
crowdier and uglier, including serial.h.  The same thing is true for PPC and
other architectures.

It turns out an easy solution is to let every board sets the serial port
definitions at run-time through calling early_serial_setup() routine.

An easy fix for now is to give a default table size when no serial definition
is given, which at least reserves some slots in the rs_table array.  See the
patch below.

A better solution is probably to provide a config option to define the serial
table size.

A by-product of this arrangement is that you can configure a kernel for
multiple machines.

What do you think?

Jun

diff -Nru include/asm-mips/serial.h.orig include/asm-mips/serial.h
--- include/asm-mips/serial.h.orig      Wed May 16 15:58:29 2001
+++ include/asm-mips/serial.h   Thu Jul 12 17:06:05 2001
@@ -271,3 +271,6 @@
        AU1000_SERIAL_PORT_DEFNS        \
        DDB5477_SERIAL_PORT_DEFNS
 
+#ifnef SERIAL_PORT_DFNS
+#define RS_TABLE_SIZE          4
+#endif
