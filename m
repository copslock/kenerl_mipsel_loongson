Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6PDqwRw004286
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Jul 2002 06:52:58 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6PDqw1g004285
	for linux-mips-outgoing; Thu, 25 Jul 2002 06:52:58 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ripple.nh.metrolink.com (h00907f103321.ne.client2.attbi.com [66.31.4.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6PDqrRw004276
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 06:52:54 -0700
Received: (from lembree@localhost)
	by ripple.nh.metrolink.com (8.11.6/8.11.6) id g6PDrTR19947;
	Thu, 25 Jul 2002 09:53:29 -0400
X-Authentication-Warning: ripple.nh.metrolink.com: lembree set sender to lembree@metrolink.com using -f
Subject: Xilleon port from 2.4.5 to top of tree, asm("$28") problem
From: Rob Lembree <lembree@metrolink.com>
To: linux-mips@oss.sgi.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Jul 2002 09:53:29 -0400
Message-Id: <1027605209.1395.130.camel@ripple.nh.metrolink.com>
Mime-Version: 1.0
X-Spam-Status: No, hits=0.8 required=5.0 tests=SIGNATURE_DELIM version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi there,

	I'm the person who did the initial port of Linux 
to the ATI Xilleon chip (4KC based, little endian).  At the
time, we did the port to 2.4.5, and everything works
swimmingly. I'm now preparing to submit this for inclusion
to this source tree, and have come across a weird problem. 
During boot-up, 'current' (which eventually evaluates to
an offset of register struct thread_info *__current_thread_info 
__asm__("$28");) is null plus the offset, in sock_alloc, 
obviously making the kernel take a big dive.

	Are there any obvious reasons why this would evaluate
to null?

thanks,
rob

-- 

Rob Lembree                        Metro Link Incorporated
29 Milk St.			     lembree@metrolink.com
Nashua, NH 03064-1651             http://www.metrolink.com
Phone:  954.660.2460               Alternate: 603.577.9714
PGP: 1F EE F8 58 30 F1 B1 20       C5 4F 12 21 AD 0D 6B 29
