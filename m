Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2003 22:12:05 +0100 (BST)
Received: from [IPv6:::ffff:207.215.131.7] ([IPv6:::ffff:207.215.131.7]:55528
	"EHLO ns.pioneer-pdt.com") by linux-mips.org with ESMTP
	id <S8225248AbTF0VMD>; Fri, 27 Jun 2003 22:12:03 +0100
Received: from philt.mrp.pioneer-pdt.com ([172.30.2.110])
          by ns.pioneer-pdt.com (Post.Office MTA v3.5.3 release 223
          ID# 0-68491U100L2S100V35) with ESMTP id com
          for <linux-mips@linux-mips.org>; Fri, 27 Jun 2003 14:14:19 -0700
From: patrick.hilt@pioneer-pdt.com (Patrick Hilt)
Organization: Pioneer
To: linux-mips@linux-mips.org
Subject: KGDB problem
Date: Fri, 27 Jun 2003 14:11:18 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306271411.18555.philt@pioneer-pdt.com>
Return-Path: <patrick.hilt@pioneer-pdt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: patrick.hilt@pioneer-pdt.com
Precedence: bulk
X-list: linux-mips

Hello!
I just recently started working on Broadcom MIPS32 architecture (7115 chipset 
based STB, Broadcom modified 2.4.18 kernel) and have been trying to get kgdb 
setup to do some kernel source level debugging... with little success I might 
add ;-|. I compiled remote debug support in to the kernel, added kernel 
command line parameters and tried a dozen different configurations... but 
never got a "Wait for gdb client connection..." message at boot time. The box 
happily continues to boot on. On the other hand, there seems to be support 
for debugging in the kernel source since there is a .../dbg_io.c 
implementation.

I guess I am not really sure what to do with it at this point... I read 
documentation and mailing list archives... no joy!

If anyone on this list would have some pointers and/or suggestions I'd greatly 
appreciate that :-)!!!

Thanks a lot,

Patrick
