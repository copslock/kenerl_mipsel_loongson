Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4UB0NnC000606
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 04:00:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4UB0NWs000605
	for linux-mips-outgoing; Thu, 30 May 2002 04:00:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4UB0KnC000602
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 04:00:20 -0700
Received: from aihana (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id EAA20747
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 04:00:33 -0700
Subject: returns corrupt value from shmctl();
From: Takeshi Aihana <takeshi_aihana@montavista.co.jp>
To: linux-mips <linux-mips@oss.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution/1.0.5-build 20020511 
Date: 30 May 2002 20:00:31 +0900
Message-Id: <1022756432.1045.37.camel@aihana>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello all,

I have a problem now about return the segment size of shared memory from
shmctl() func.

First of step was to start apache_1.3.24 on kernel-2.4.17/pb1000.
However it could not be started because it might be currput segment size
from shmctl() called in apache.
So that I tried to test with shmctl() on (A)kernel-2.4.17/pb1000 and
(B)kernel-2.4.9/x86 as the follows. 
(B) was just returned correct segment size, but (A)'s segment size was 0
(of cause memory on pb1000 was left).

This code is
-----------------------------------8<---------------------------------------
-----------------------------------8<---------------------------------------
 HOST: kernel-2.4.9/RH-7.2 on x86.
 
