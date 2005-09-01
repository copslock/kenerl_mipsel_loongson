Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2005 21:10:31 +0100 (BST)
Received: from postfix3-2.free.fr ([IPv6:::ffff:213.228.0.169]:54741 "EHLO
	postfix3-2.free.fr") by linux-mips.org with ESMTP
	id <S8224914AbVIAUKK>; Thu, 1 Sep 2005 21:10:10 +0100
Received: from home (vig38-1-82-67-77-237.fbx.proxad.net [82.67.77.237])
	by postfix3-2.free.fr (Postfix) with ESMTP id D6759C231
	for <linux-mips@linux-mips.org>; Thu,  1 Sep 2005 22:16:29 +0200 (CEST)
From:	Nicolas Sauzede <nsauzede@online.fr>
To:	linux-mips@linux-mips.org
Subject: Compiling 2.6.13 CVS on Indy R4K
Date:	Thu, 1 Sep 2005 22:16:24 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509012216.25711.nsauzede@online.fr>
Return-Path: <nsauzede@online.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nsauzede@online.fr
Precedence: bulk
X-list: linux-mips

... fails like this :

.........
  CC      arch/mips/kernel/module.o
  AS      arch/mips/kernel/r4k_fpu.o
  AS      arch/mips/kernel/r4k_switch.o
  CC      arch/mips/kernel/irq_cpu.o
{standard input}: Assembler messages:
{standard input}:231: Error: unrecognized opcode `ehb '
{standard input}:257: Error: unrecognized opcode `ehb '
{standard input}:305: Error: unrecognized opcode `ehb '
{standard input}:338: Error: unrecognized opcode `ehb '
make[1]: *** [arch/mips/kernel/irq_cpu.o] Error 1
make: *** [arch/mips/kernel] Error 2

Any ideas ??
