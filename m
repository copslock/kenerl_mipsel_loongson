Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Apr 2006 20:22:39 +0100 (BST)
Received: from static-71-243-117-205.bos.east.verizon.net ([71.243.117.205]:17349
	"HELO gw.treese.org") by ftp.linux-mips.org with SMTP
	id S8133509AbWDZTW1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Apr 2006 20:22:27 +0100
Received: from [10.0.0.227] (static-71-243-124-123.bos.east.verizon.net [71.243.124.123])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by gw.treese.org (Postfix) with ESMTP id 5D8A45AB5F
	for <linux-mips@linux-mips.org>; Wed, 26 Apr 2006 15:32:16 -0400 (EDT)
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Transfer-Encoding: 7bit
Message-Id: <9B3838B8-4950-40BA-B386-0D45819C168D@acm.org>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To:	linux-mips@linux-mips.org
From:	Win Treese <treese@acm.org>
Subject: [PATCH] fix branch emulation for floating-point exceptions
Date:	Wed, 26 Apr 2006 15:22:22 -0400
X-Mailer: Apple Mail (2.749.3)
Return-Path: <treese@acm.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: treese@acm.org
Precedence: bulk
X-list: linux-mips

In the branch emulation for floating-point exceptions,  
__compute_return_epc
must determine for bc1f et al which condition code bit to test. This  
is based on bits <4:2>
of the rt field. The switch statement to distinguish bc1f et al needs  
to use only the
two low bits of rt, but the old code tests on the whole rt field.  
This patch masks off
the proper bits.

Signed-off-by: Win Treese <treese@acm.org>

Index: a/arch/mips/kernel/branch.c
===================================================================
--- a/arch/mips/kernel/branch.c (revision 18809)
+++ a/arch/mips/kernel/branch.c (working copy)
@@ -184,7 +184,7 @@
                 bit = (insn.i_format.rt >> 2);
                 bit += (bit != 0);
                 bit += 23;
-               switch (insn.i_format.rt) {
+               switch (insn.i_format.rt & 3) {
                 case 0: /* bc1f */
                 case 2: /* bc1fl */
                         if (~fcr31 & (1 << bit))
