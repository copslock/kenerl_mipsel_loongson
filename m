Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jun 2004 14:17:28 +0100 (BST)
Received: from skl1.ukl.uni-freiburg.de ([IPv6:::ffff:193.196.199.1]:1179 "EHLO
	relay1.uniklinik-freiburg.de") by linux-mips.org with ESMTP
	id <S8225249AbUFHNRX>; Tue, 8 Jun 2004 14:17:23 +0100
Received: from wh85.ukl.uni-freiburg.de (ktl77.ukl.uni-freiburg.de [193.196.226.77])
	by relay1.uniklinik-freiburg.de (Email) with ESMTP id 8A4672F2B8
	for <linux-mips@linux-mips.org>; Tue,  8 Jun 2004 15:17:11 +0200 (CEST)
From: Max Zaitsev <maksik@gmx.co.uk>
Organization: Mutella Dev co.
To: Linux MIPS <linux-mips@linux-mips.org>
Subject: howto compile bootable O2 kernel with FB support?
Date: Tue, 8 Jun 2004 15:17:15 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406081517.15059.maksik@gmx.co.uk>
Return-Path: <maksik@gmx.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksik@gmx.co.uk
Precedence: bulk
X-list: linux-mips

Hi list,

can anybody give me quite a straightforward directions how to build or where 
to acquire a bootable IP32 kernel with framebuffer support? I've been trying 
to do that with both self-compilation using gcc 3.3 (stage3 from kumba) or 
cross-compile toolchain from linux-mips (gcc 2.95 & co) with no success. 
neither of my kernels was able to even start booting. The two possible 
scenarios I've observed were (a) quiet hang after displaying the entry point 
or (b) illegal instruction. 

Interestingly enough, I'm able to boot binary kernel from Vivien (http://
www.linux-mips.org/~glaurung/O2/linux-2.6.1/kernel/vmlinux64) or from Ilya 
(http://www.total-knowledge.com/progs/mips/kernels/vmlinux.64-20040315). 
However, kernel from Vivien has some problems and for Ilya's kernel I have 
neither sources/config nor modules... 

Now, let me formulate the question: I don't want a bleeding edge top 
performance feature-rich kernel, I just need something that works reasonably 
well, boots from the hard drive alone and has support for graphics. Is there 
something like that for r5000 o2 or it does not exists?

Regards,
Max
