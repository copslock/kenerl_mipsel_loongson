Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Sep 2002 22:31:09 +0200 (CEST)
Received: from mail.scram.de ([195.226.127.117]:2503 "EHLO mail.scram.de")
	by linux-mips.org with ESMTP id <S1121744AbSI1UbJ>;
	Sat, 28 Sep 2002 22:31:09 +0200
Received: from alpha.bocc.de (p5080D5A5.dip.t-dialin.net [80.128.213.165])
	(authenticated)
	by mail.scram.de (8.11.6+3.4W/8.11.0) with ESMTP id g8SKV2A28090
	for <linux-mips@linux-mips.org>; Sat, 28 Sep 2002 22:31:02 +0200 (CEST)
Date: Sat, 28 Sep 2002 22:30:56 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@alpha.bocc.de
To: linux-mips@linux-mips.org
Subject: R4600 status?
Message-ID: <Pine.LNX.4.44.0209282228160.30409-100000@alpha.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <jochen@scram.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jochen@scram.de
Precedence: bulk
X-list: linux-mips

Hi,

i tried to boot the current (unstable) Debian kernel (2.4.18-r4k-ip22) and
get the infamous hangs on my Indy at various stages, but very early,
during boot.

ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
CPU: MIPS-R4600 FPU<MIPS-R4600FPC> ICACHE DCACHE
CPU revision is: 00002010
FPU revision is: 00002000
Primary instruction cache 16kb, linesize 32 bytes.
Primary data cache 16kb, linesize 32 bytes.
Linux version 2.4.17-r4k-ip22 (root@nocontrol) (gcc version 2.95.4
20011002 (Deb
ian prerelease)) #1 Mon Apr 29 12:10:32 CEST 2002
MC: SGI memory controller Revision 3

Does this machine suffer from the V1.7 problems, as well? Where can i find
the current patch?

Thanks,
--jochen
