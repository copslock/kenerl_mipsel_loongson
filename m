Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 11:28:51 +0000 (GMT)
Received: from mx5.Informatik.Uni-Tuebingen.De ([IPv6:::ffff:134.2.12.32]:4038
	"EHLO mx5.informatik.uni-tuebingen.de") by linux-mips.org with ESMTP
	id <S8225294AbUAML2u>; Tue, 13 Jan 2004 11:28:50 +0000
Received: from localhost (loopback [127.0.0.1])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP id C418F133
	for <linux-mips@linux-mips.org>; Tue, 13 Jan 2004 12:28:44 +0100 (NFT)
Received: from mx5.informatik.uni-tuebingen.de ([127.0.0.1])
 by localhost (mx5 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 29886-05 for <linux-mips@linux-mips.org>;
 Tue, 13 Jan 2004 12:28:43 +0100 (NFT)
Received: from dual (semeai.Informatik.Uni-Tuebingen.De [134.2.15.66])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP id D7C33121
	for <linux-mips@linux-mips.org>; Tue, 13 Jan 2004 12:28:42 +0100 (NFT)
Received: from mrvn by dual with local (Exim 3.36 #1 (Debian))
	id 1AgMio-0005UW-00
	for <linux-mips@linux-mips.org>; Tue, 13 Jan 2004 12:28:34 +0100
To: linux-mips@linux-mips.org
Subject: Patch for MyCable XXS1500 for 2.4.24-pre1
From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Date: 13 Jan 2004 12:28:34 +0100
Message-ID: <878ykcm6jh.fsf@mrvn.homelinux.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Reasonable Discussion)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Virus-Scanned: by amavisd-new (McAfee AntiVirus) at informatik.uni-tuebingen.de
Return-Path: <brederlo@informatik.uni-tuebingen.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brederlo@informatik.uni-tuebingen.de
Precedence: bulk
X-list: linux-mips

Hi,

I found a minor flaw in 2.4.24-pre1 for my X-Mas present.
In 2.4.21 there where two more boards present then in
2.4.24-pre1:
#define MACH_XXS1500            6       /* Au1500-based eval board */
#define MACH_MTX1               7       /* 4G MTX-1 Au1500-based board */

I have an XXS1500 and can confirm that the kernel compiles and works
with the patch below.

MfG
        Goswin
----------------------------------------------------------------------
mips:/usr/src# diff -Nurd linux-2.4.24-pre1-cvs/include/asm/bootinfo.h.old linux-2.4.24-pre1-cvs/include/asm/bootinfo.h
--- linux-2.4.24-pre1-cvs/include/asm/bootinfo.h.old    Tue Jan 13 12:24:27 2004
+++ linux-2.4.24-pre1-cvs/include/asm/bootinfo.h        Tue Jan 13 12:24:44 2004
@@ -176,6 +176,7 @@
 #define MACH_DB1000            3       /* Au1000-based eval board */
 #define MACH_DB1100            4       /* Au1100-based eval board */
 #define MACH_DB1500            5       /* Au1500-based eval board */
+#define MACH_XXS1500            6       /* MyCable XSS1500 board */
 
 /*
  * Valid machtype for group NEC_VR41XX
