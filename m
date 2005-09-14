Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 23:59:40 +0100 (BST)
Received: from father.pmc-sierra.com ([IPv6:::ffff:216.241.224.13]:18397 "HELO
	father.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8224992AbVINW7V>; Wed, 14 Sep 2005 23:59:21 +0100
Received: (qmail 306 invoked by uid 101); 14 Sep 2005 22:59:14 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by father.pmc-sierra.com with SMTP; 14 Sep 2005 22:59:14 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id j8EMxA45007683
	for <linux-mips@linux-mips.org>; Wed, 14 Sep 2005 15:59:14 -0700
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <RMQMT5N0>; Wed, 14 Sep 2005 15:59:18 -0700
Message-ID: <5C1FD43E5F1B824E83985A74F396286E5E9475@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Don Hiatt <Don_Hiatt@pmc-sierra.com>
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Cc:	Don Hiatt <Don_Hiatt@pmc-sierra.com>
Subject: Trival shell script crashes under 2.4.25
Date:	Wed, 14 Sep 2005 16:00:40 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Don_Hiatt@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Don_Hiatt@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hello,

  Sorry if this is the wrong list to post to; if it is, could you
please suggest an alternative? :)

  Below you will find a very simple shell script that crashes under
2.4.25 running on a RM9000 (PMC rm7935) with busybox 1.0. This script
just demonstrates the actual problem but I do not believe it is 
isolated to busybox. In fact I wrote a simple program that just does
this:
	* for(;;)
		* fork()
			* mmap file "foo"
			* compare "foo" to an array image
		* waitpid()

and it will run for a while and then SEGFAULT at various times. According
to GDB the stack is corrupted and looking at the PC it does seem bogus
(0x2acf2e50). 

  The program crashes after a random amount of time but generally no more
that a minute or so. I can speed up the process if I ping-flood the target.

  Now what is really wierd is that if I run the program under gdbserver
it doesn't crash (or at least has not in the last 1/2 hour). Does gdbserver
change the execution context differently that gdb??

  Any suggestions would be greatly appreciated. :)

Cheers,

don


# cat die.sh 
#!/bin/sh
while :
do
  echo 1
done


*** RUN #1 ***
1
1
....
./die.sh: 5: echo: Bad address

*** RUN # 2 ***
1
1
1
..
Segmentation fault

*** GDB (6.3) DUMP ***
...
----------
fork()
P(16814) : C(17343) : Count (468)

Program received signal SIGSEGV, Segmentation fault.
0x2acf2e50 in ?? ()
(gdb) .
(gdb) bt
#0  0x2acf2e50 in ?? ()
warning: GDB can't find the start of the function at 0x2acf2e50.

    GDB is unable to find the start of the function at 0x2acf2e50
and thus can't determine the size of that function's stack frame.
This means that GDB may be unable to access that stack frame, or
the frames below it.
    This problem is most likely caused by an invalid program counter or
stack pointer.
    However, if you think GDB should simply search farther back
from 0x2acf2e50 for code which looks like the beginning of a
function, you can increase the range of the search using the `set
heuristic-fence-post' command.
#1  0x2acf2e50 in ?? ()
warning: GDB can't find the start of the function at 0x2acf2e50.
Previous frame identical to this frame (corrupt stack?)
(gdb)


*** CPU INFO ***
~ # cat /proc/cpuinfo 
system type             : ITE QED-4N-S01B
processor               : 0
cpu model               : RM9000 V2.2  FPU V2.0
BogoMIPS                : 897.84
wait instruction        : no
microsecond timers      : yes
tlb_entries             : 64
extra interrupt vector  : no
hardware watchpoint     : no
VCED exceptions         : not available
VCEI exceptions         : not available
