Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2003 16:47:26 +0000 (GMT)
Received: from mms3.broadcom.com ([IPv6:::ffff:63.70.210.38]:43524 "EHLO
	mms3.broadcom.com") by linux-mips.org with ESMTP
	id <S8225204AbTCFQrZ>; Thu, 6 Mar 2003 16:47:25 +0000
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 MMS1 SMTP Relay (MMS v5.5.0)); Thu, 06 Mar 2003 08:47:22 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id IAA07273; Thu, 6 Mar 2003 08:47:05 -0800 (PST)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 h26GlGER017178; Thu, 6 Mar 2003 08:47:16 -0800 (PST)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id IAA11769; Thu, 6
 Mar 2003 08:47:16 -0800
Message-ID: <3E677B94.AE22C65D@broadcom.com>
Date: Thu, 06 Mar 2003 08:47:16 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
cc: "Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] add CONFIG_DEBUG_INFO
References: <20030220113404.E7466@mvista.com>
 <3E63B047.D3BA2A2C@broadcom.com> <86d6l8fcvv.fsf@trasno.mitica>
X-WSS-ID: 1279A41047361-01-01
Content-Type: multipart/mixed;
 boundary=------------DD1721530DCE298F1BC44E84
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------DD1721530DCE298F1BC44E84
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit


Any more comments on this topic?  Here's a patch that incorporates
Juan's suggestion.  I'm content to do away with the multiple-dependence
syntax in the Makefiles...  having KGDB on defines "CONFIG_DEBUG_INFO",
otherwise you can explicitly turn it on.  If no one objects, I'll do the
same for 2.5.

Kip
--------------DD1721530DCE298F1BC44E84
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
+++ arch/mips/config-shared.in	6 Mar 2003 16:43:59 -0000
@@ -977,6 +977,11 @@
 bool 'Are you using a crosscompiler' CONFIG_CROSSCOMPILE
 bool 'Enable run-time debugging' CONFIG_RUNTIME_DEBUG
 bool 'Remote GDB kernel debugging' CONFIG_KGDB
+if [ "$CONFIG_KGDB" = "y" ]; then
+   define_bool CONFIG_DEBUG_INFO y
+else
+   bool 'Debugging symbols' CONFIG_DEBUG_INFO
+fi
 dep_bool '  Console output to GDB' CONFIG_GDB_CONSOLE $CONFIG_KGDB
 if [ "$CONFIG_SIBYTE_SB1xxx_SOC" = "y" ]; then
    bool 'Compile for Corelis Debugger' CONFIG_SB1XXX_CORELIS
Index: arch/mips/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/Makefile,v
retrieving revision 1.78.2.23
diff -u -r1.78.2.23 Makefile
--- arch/mips/Makefile	26 Feb 2003 21:14:23 -0000	1.78.2.23
+++ arch/mips/Makefile	6 Mar 2003 16:43:59 -0000
@@ -41,11 +41,11 @@
 LINKFLAGS	+= -G 0 -static # -N
 MODFLAGS	+= -mlong-calls
 
-ifdef CONFIG_KGDB
+ifdef CONFIG_DEBUG_INFO
 GCCFLAGS	+= -g
+endif
 ifdef CONFIG_SB1XXX_CORELIS
 GCCFLAGS	+= -mno-sched-prolog -fno-omit-frame-pointer
-endif
 endif
 
 check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
Index: arch/mips64/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips64/Makefile,v
retrieving revision 1.22.2.27
diff -u -r1.22.2.27 Makefile
--- arch/mips64/Makefile	26 Feb 2003 21:14:24 -0000	1.22.2.27
+++ arch/mips64/Makefile	6 Mar 2003 16:43:59 -0000
@@ -39,11 +39,11 @@
 LINKFLAGS	+= -G 0 -static # -N
 MODFLAGS	+= -mlong-calls
 
-ifdef CONFIG_KGDB
+ifdef CONFIG_DEBUG_INFO
 GCCFLAGS	+= -g
+endif
 ifdef CONFIG_SB1XXX_CORELIS
 GCCFLAGS	+= -mno-sched-prolog -fno-omit-frame-pointer
-endif
 endif
 
 check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)

--------------DD1721530DCE298F1BC44E84--
