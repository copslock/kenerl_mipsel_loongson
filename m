Received:  by oss.sgi.com id <S553882AbRBFQI1>;
	Tue, 6 Feb 2001 08:08:27 -0800
Received: from mx.mips.com ([206.31.31.226]:4004 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553879AbRBFQIU>;
	Tue, 6 Feb 2001 08:08:20 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id IAA16433
	for <linux-mips@oss.sgi.com>; Tue, 6 Feb 2001 08:08:14 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id IAA14561
	for <linux-mips@oss.sgi.com>; Tue, 6 Feb 2001 08:08:12 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id RAA10688
	for <linux-mips@oss.sgi.com>; Tue, 6 Feb 2001 17:07:59 +0100 (MET)
Message-ID: <3A80215E.D13FE590@mips.com>
Date:   Tue, 06 Feb 2001 17:07:58 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: The FPU emulator doesn't work properly
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I think I have send this patch before, but it hasn't got in to the
archive, apparently.
This is needed in order to get the FPU emulator work properly.


Index: arch/mips/kernel/branch.c
===================================================================
RCS file: /home/repository/sw/linux-2.4.0/arch/mips/kernel/branch.c,v
retrieving revision 1.3
diff -u -r1.3 branch.c
--- branch.c    2000/12/05 13:46:12     1.3
+++ branch.c    2001/02/06 15:46:53
@@ -69,7 +69,7 @@
                switch (insn.i_format.rt) {
                case bltz_op:
                case bltzl_op:
-                       if (regs->regs[insn.i_format.rs] < 0)
+                       if ((long)regs->regs[insn.i_format.rs] < 0)
                                epc = epc + 4 +
(insn.i_format.simmediate << 2);
                        else
                                epc += 8;
@@ -78,7 +78,7 @@

                case bgez_op:
                case bgezl_op:
-                       if (regs->regs[insn.i_format.rs] >= 0)
+                       if ((long)regs->regs[insn.i_format.rs] >= 0)
                                epc = epc + 4 +
(insn.i_format.simmediate << 2);
                        else
                                epc += 8;
@@ -88,7 +88,7 @@
                case bltzal_op:
                case bltzall_op:
                        regs->regs[31] = epc + 8;
-                       if (regs->regs[insn.i_format.rs] < 0)
+                       if ((long)regs->regs[insn.i_format.rs] < 0)
                                epc = epc + 4 +
(insn.i_format.simmediate << 2);
                        else
                                epc += 8;
@@ -98,7 +98,7 @@
                case bgezal_op:
                case bgezall_op:
                        regs->regs[31] = epc + 8;
-                       if (regs->regs[insn.i_format.rs] >= 0)
+                       if ((long)regs->regs[insn.i_format.rs] >= 0)
                                epc = epc + 4 +
(insn.i_format.simmediate << 2);
                        else
                                epc += 8;
@@ -146,7 +146,7 @@
        case blez_op: /* not really i_format */
        case blezl_op:
                /* rt field assumed to be zero */
-               if (regs->regs[insn.i_format.rs] <= 0)
+               if ((long)regs->regs[insn.i_format.rs] <= 0)
                        epc = epc + 4 + (insn.i_format.simmediate << 2);

                else
                        epc += 8;
@@ -156,7 +156,7 @@
        case bgtz_op:
        case bgtzl_op:
                /* rt field assumed to be zero */
-               if (regs->regs[insn.i_format.rs] > 0)
+               if ((long)regs->regs[insn.i_format.rs] > 0)
                        epc = epc + 4 + (insn.i_format.simmediate << 2);

                else
                        epc += 8;


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
