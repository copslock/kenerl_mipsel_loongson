Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BGToRw008079
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 09:29:50 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BGTnT1008078
	for linux-mips-outgoing; Thu, 11 Jul 2002 09:29:49 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from columba.www.eur.3com.com (ip-161-71-171-238.corp-eur.3com.com [161.71.171.238])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BGTeRw008066;
	Thu, 11 Jul 2002 09:29:41 -0700
Received: from toucana.eur.3com.com (toucana.EUR.3Com.COM [140.204.220.50])
	by columba.www.eur.3com.com  with ESMTP id g6BGZnE09609;
	Thu, 11 Jul 2002 17:35:49 +0100 (BST)
Received: from notesmta.eur.3com.com (eurmta1.EUR.3Com.COM [140.204.220.206])
	by toucana.eur.3com.com  with SMTP id g6BGYdR27830;
	Thu, 11 Jul 2002 17:34:39 +0100 (BST)
Received: by notesmta.eur.3com.com(Lotus SMTP MTA v4.6.3  (733.2 10-16-1998))  id 80256BF3.005B650B ; Thu, 11 Jul 2002 17:38:16 +0100
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: "Gleb O. Raiko" <raiko@niisi.msk.ru>, linux-mips@oss.sgi.com,
   carstenl@mips.com
Message-ID: <80256BF3.005B6446.00@notesmta.eur.3com.com>
Date: Thu, 11 Jul 2002 17:33:53 +0100
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



> Ralf wrote:
>Have you tried to insert a large number of nops instead?

My investigation suggests that a single extra nop is sufficient. I have also
tried inserting extra nops before the cache routine to see if the relative
alignment of the instructions with respect to the cacheline has an influence,
but it has no effect. I am suspicious that if this occurs with the instruction
following the loop then something odd might be occuring on every loop iteration
as well. I might try adjusting the instructions in the loop to see if that has
any effect.

>  Or preferably,
>how about replacing the __restore_flags() in your example with the
>following piece of inline assembler:
>
>  __asm__ __volatile__("mtc0\t%0, $12" ::"r" (flags) : "memory");

I am happy that the current assembler code looks correct, but this change would
make it simpler.

     Jon
