Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Mar 2003 19:43:14 +0000 (GMT)
Received: from mms2.broadcom.com ([IPv6:::ffff:63.70.210.59]:20999 "EHLO
	mms2.broadcom.com") by linux-mips.org with ESMTP
	id <S8225243AbTCCTnN>; Mon, 3 Mar 2003 19:43:13 +0000
Received: from 63.70.210.1 by mms2.broadcom.com with ESMTP (Broadcom
 MMS1 SMTP Relay (MMS v5.5.0)); Mon, 03 Mar 2003 11:40:10 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id LAA14390; Mon, 3 Mar 2003 11:42:52 -0800 (PST)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 h23Jh3ER024461; Mon, 3 Mar 2003 11:43:03 -0800 (PST)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id LAA04052; Mon, 3
 Mar 2003 11:43:03 -0800
Message-ID: <3E63B047.D3BA2A2C@broadcom.com>
Date: Mon, 03 Mar 2003 11:43:03 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
cc: "Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH] add CONFIG_DEBUG_INFO
References: <20030220113404.E7466@mvista.com>
X-WSS-ID: 127D70102448190-01-01
Content-Type: multipart/mixed;
 boundary=------------0FF0CCC3E4562DFE2023AC10
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------0FF0CCC3E4562DFE2023AC10
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit

Jun Sun wrote:
> 
> This patch make the following changes
> 
>         1) CONFIG_REMOTE_DEBUG -> CONFIG_KGDB
>         2) CONFIG_DEBUG -> CONFIG_RUNTIME_DEBUG
> 
> MIPS is pretty much the only one (other than the pitiful s390 :0)
> using REMOTE_DEBUG instead of KGDB.  So it is a good thing to change
> it.
> 
> As Keith pointed out, CONFIG_DEBUG is too general (which has
> already caused confusion, BTW).  RUNTIME_DEBUG is more appropriate.

I'd like to propose a further change here, which is to decouple the
inclusion of debugging symbols from building with KGDB support.  I use a
JTAG debugger all the time, and don't need/want KGDB built in (by
default it forces the remote GDB to attach and continue, and it steals
one of the serial ports on my platform).

How about adding "CONFIG_DEBUG_INFO" which simply adds '-g' to the
CFLAGS?  REMOTE_KGDB can be left independent of this option by allowing
either option to enable '-g'.  Patch for 2.4 attached.

Comments?

Kip
--------------0FF0CCC3E4562DFE2023AC10
Content-Type: text/plain;
 charset=us-ascii;
 name=debug.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=debug.diff

Index: arch/mips/config-shared.in
===================================================================
RCS file: /home/cvs/linux/arch/mips/Attic/config-shared.in,v
retrieving revision 1.1.2.48
diff -u -r1.1.2.48 config-shared.in
--- arch/mips/config-shared.in	26 Feb 2003 21:14:23 -0000	1.1.2.48
+++ arch/mips/config-shared.in	3 Mar 2003 19:41:11 -0000
@@ -976,6 +976,7 @@
 
 bool 'Are you using a crosscompiler' CONFIG_CROSSCOMPILE
 bool 'Enable run-time debugging' CONFIG_RUNTIME_DEBUG
+bool 'Debugging symbols' CONFIG_DEBUG_INFO
 bool 'Remote GDB kernel debugging' CONFIG_KGDB
 dep_bool '  Console output to GDB' CONFIG_GDB_CONSOLE $CONFIG_KGDB
 if [ "$CONFIG_SIBYTE_SB1xxx_SOC" = "y" ]; then
Index: arch/mips/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/Makefile,v
retrieving revision 1.78.2.23
diff -u -r1.78.2.23 Makefile
--- arch/mips/Makefile	26 Feb 2003 21:14:23 -0000	1.78.2.23
+++ arch/mips/Makefile	3 Mar 2003 19:41:11 -0000
@@ -41,8 +41,8 @@
 LINKFLAGS	+= -G 0 -static # -N
 MODFLAGS	+= -mlong-calls
 
-ifdef CONFIG_KGDB
-GCCFLAGS	+= -g
+ifneq ($(CONFIG_DEBUG_INFO)$(CONFIG_KGDB),)
+GCCFLAGS	+= -gstabs+
 ifdef CONFIG_SB1XXX_CORELIS
 GCCFLAGS	+= -mno-sched-prolog -fno-omit-frame-pointer
 endif
Index: arch/mips64/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips64/Makefile,v
retrieving revision 1.22.2.27
diff -u -r1.22.2.27 Makefile
--- arch/mips64/Makefile	26 Feb 2003 21:14:24 -0000	1.22.2.27
+++ arch/mips64/Makefile	3 Mar 2003 19:41:11 -0000
@@ -39,7 +39,7 @@
 LINKFLAGS	+= -G 0 -static # -N
 MODFLAGS	+= -mlong-calls
 
-ifdef CONFIG_KGDB
+ifneq ($(CONFIG_DEBUG_INFO)$(CONFIG_KGDB),)
 GCCFLAGS	+= -g
 ifdef CONFIG_SB1XXX_CORELIS
 GCCFLAGS	+= -mno-sched-prolog -fno-omit-frame-pointer

--------------0FF0CCC3E4562DFE2023AC10--
