Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Sep 2002 13:55:45 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:1977 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122960AbSIJLzp>;
	Tue, 10 Sep 2002 13:55:45 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g8ABtMUD008902;
	Tue, 10 Sep 2002 04:55:22 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id EAA18146;
	Tue, 10 Sep 2002 04:55:23 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g8ABtKb03509;
	Tue, 10 Sep 2002 13:55:20 +0200 (MEST)
Message-ID: <3D7DDDA6.7327CA34@mips.com>
Date: Tue, 10 Sep 2002 13:55:18 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: FP emulator patch
Content-Type: multipart/mixed;
 boundary="------------21F78C6EBA981D15B3EF21F1"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------21F78C6EBA981D15B3EF21F1
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

This patch fix a bug in the FP emulator, when used in the 64-bit kernel.

Ralf, could you please apply.

/Carsten



--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------21F78C6EBA981D15B3EF21F1
Content-Type: text/plain; charset=iso-8859-15;
 name="fpe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fpe.patch"

Index: arch/mips/math-emu/cp1emu.c
===================================================================
RCS file: /cvs/linux/arch/mips/math-emu/cp1emu.c,v
retrieving revision 1.13.2.9
diff -u -r1.13.2.9 cp1emu.c
--- arch/mips/math-emu/cp1emu.c	2002/08/05 23:53:34	1.13.2.9
+++ arch/mips/math-emu/cp1emu.c	2002/09/10 11:47:22
@@ -168,8 +168,8 @@
 
 #define SIFROMREG(si,x)	((si) = \
 			(xcp->cp0_status & FR_BIT) || !(x & 1) ? \
-			ctx->regs[x] : \
-			ctx->regs[x & ~1] >> 32 )
+			(int)ctx->regs[x] : \
+			(int)(ctx->regs[x & ~1] >> 32 ))
 #define SITOREG(si,x)	(ctx->regs[x & ~((xcp->cp0_status & FR_BIT) == 0)] = \
 			(xcp->cp0_status & FR_BIT) || !(x & 1) ? \
 			ctx->regs[x & ~1] >> 32 << 32 | (u32)(si) : \

--------------21F78C6EBA981D15B3EF21F1--
