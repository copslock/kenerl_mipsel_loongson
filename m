Received:  by oss.sgi.com id <S553798AbRCBQ5W>;
	Fri, 2 Mar 2001 08:57:22 -0800
Received: from mx.mips.com ([206.31.31.226]:2551 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553787AbRCBQ5P>;
	Fri, 2 Mar 2001 08:57:15 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id IAA11382
	for <linux-mips@oss.sgi.com>; Fri, 2 Mar 2001 08:57:15 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id IAA09692
	for <linux-mips@oss.sgi.com>; Fri, 2 Mar 2001 08:57:12 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id RAA25898
	for <linux-mips@oss.sgi.com>; Fri, 2 Mar 2001 17:56:49 +0100 (MET)
Message-ID: <3A9FD0D0.887E372F@mips.com>
Date:   Fri, 02 Mar 2001 17:56:48 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Bug in get_insn_opcode.
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

There is a bug in the function get_insn_opcode in traps.c

As 'epc' is an int pointer here, it should only be increased by 1 (4
byte) and not by 4 (4*4 = 16 bytes).
See the patch below.

/Carsten

Index: arch/mips/kernel/traps.c
===================================================================
RCS file: /home/repository/sw/linux-2.4.0/arch/mips/kernel/traps.c,v
retrieving revision 1.10
diff -u -r1.10 traps.c
--- traps.c     2001/02/28 13:46:43     1.10
+++ traps.c     2001/03/02 16:50:27
@@ -410,7 +410,7 @@

        epc = (unsigned int *) (unsigned long) regs->cp0_epc;
        if (regs->cp0_cause & CAUSEF_BD)
-               epc += 4;
+               epc++;

        if (verify_area(VERIFY_READ, epc, 4)) {
                force_sig(SIGSEGV, current);
Index: arch/mips64/kernel/traps.c
===================================================================
RCS file: /home/repository/sw/linux-2.4.0/arch/mips64/kernel/traps.c,v
retrieving revision 1.5
diff -u -r1.5 traps.c
--- traps.c     2001/02/19 16:02:52     1.5
+++ traps.c     2001/03/02 16:50:13
@@ -371,7 +371,7 @@

        epc = (unsigned int *) (unsigned long) regs->cp0_epc;
        if (regs->cp0_cause & CAUSEF_BD)
-               epc += 4;
+               epc++;

        if (verify_area(VERIFY_READ, epc, 4)) {
                force_sig(SIGSEGV, current);




--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
