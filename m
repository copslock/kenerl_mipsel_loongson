Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 09:37:47 +0000 (GMT)
Received: from mail.hot.ee ([194.126.101.116]:14043 "EHLO mail.hot.ee")
	by ftp.linux-mips.org with ESMTP id S8133357AbWAQJhT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 09:37:19 +0000
x-mailer: Elion E-kohvik Webmail (http://www.hot.ee)
From:	Riisisulg <riisisulg@hot.ee>
Date:	Tue, 17 Jan 2006 11:40:53 +0200
To:	linux-mips@linux-mips.org
Subject: atomic_add function on memory allocated with dma_alloc_coherent hangs
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
Message-Id: <20060117094053.D0DFBAF060@mh3-4.hot.ee>
X-Virus-Scanned: by amavisd-new-2.2.1 (20041222) (Debian) at hot.ee
Return-Path: <riisisulg@hot.ee>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: riisisulg@hot.ee
Precedence: bulk
X-list: linux-mips

Hello. I'm using AMD Alchemy db1550 with au1550, it has 2.6.15 kernel
patched with linux-2.6.14.5-mips-1.patch, i have compiled cross compiler
for the platform (but not checked it for correctness)

since db1550 does not have USB2.0 but instead has two PCI slots, i
installed NEC's PCI to USB 2.0 host controller board to it. I was able
to load ehci-hcd driver with success but after the usb mass storage
device was inserted the system hanged. 
After debugging a while i found out that function atomic_add did not
return. I run few tests where atomic add asm code was alerted and got
confidence that sc instruction did not never succeed so the cycle was
repeating forever.
72                 unsigned long temp;
73 
74                 __asm__ __volatile__(
75                 "1:     ll      %0, %1          # atomic_add         
  \n"
76                 "       addu    %0, %2                               
  \n"
77                 "       sc      %0, %1                               
  \n"
78                 "       beqz    %0, 1b                               
  \n"
79                 : "=&r" (temp), "=m" (v->counter)
80                 : "Ir" (i), "m" (v->counter));
At this point it seems like atomic_add problem but that code is old for
ages. Next i started to make tests where atomic_add was used to get the
cpu hanged. 

It appears that the atomic_add function will not work when certain
memory allocation scheme is used. If the atomic variable is allocated
from stack, with kmalloc or with dma_allock_noncoherent it will work
fine, but when dma_allock_coherent or memory taken form memory pool
atomic_add will fail (i think that all ll sc instructions can fail but i
tested only with atomic_add)

To easy the testing i wrote driver that anybody should be able to
compile and run. For testing i used also an x86 machine and driver
worked (Test function is in module's init functioin)

Test driver available at
http://frogman.gf.ttu.ee/kernel_test.tar.bz2

to view the contents of the driver
http://frogman.gf.ttu.ee/kernel_test/

Since i have only one MIPS based system i dont know wether this problem
is specefic to amd alchemy 1550 or the entire amd alchemy family or some
other MIPS32 based system or is it just my cross compiler or else that
made mistake somewhere.

On irc i found one guy who did use my test driver on his MIPS and the
driver crashed (Of course probability is that the driver itself has bug
on it, but that driver worked fine on x86)
By saying driver works i mean kernel was able to load it without
"crashing" (looping infinitely).

jyr
