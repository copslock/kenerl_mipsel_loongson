Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 09:34:24 +0100 (CET)
Received: from mx2.mips.com ([206.31.31.227]:52936 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8225224AbSLDIeX>;
	Wed, 4 Dec 2002 09:34:23 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB48Y3Nf021871;
	Wed, 4 Dec 2002 00:34:03 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA05398;
	Wed, 4 Dec 2002 00:34:04 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB48Y5b15955;
	Wed, 4 Dec 2002 09:34:05 +0100 (MET)
Message-ID: <3DEDBDFC.D87C1B84@mips.com>
Date: Wed, 04 Dec 2002 09:34:04 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Latest sources from CVS.
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

I just checked the latest sources out of cvs.

It look like you are only able to compile the kernel, if you got a
MIPS32/MIPS64 compliant compiler.
The mips32 and mips64 assembler directives are set in
include/asm-mips/mipsregs.h

I guess this will make some people out there, which doesn't use a MIPS32
compliant compiler, a little bit unhappy.
But then again, we would like to force everybody to use the SDE
compiler.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
