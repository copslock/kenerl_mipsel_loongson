Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 17:20:59 +0200 (CEST)
Received: from fw-cam.cambridge.arm.com ([193.131.176.3]:56492 "EHLO
	fw-cam.cambridge.arm.com") by linux-mips.org with ESMTP
	id <S1122987AbSIQPU7>; Tue, 17 Sep 2002 17:20:59 +0200
Received: by fw-cam.cambridge.arm.com; id QAA11807; Tue, 17 Sep 2002 16:20:48 +0100 (BST)
Received: from unknown(172.16.9.107) by fw-cam.cambridge.arm.com via smap (V5.5)
	id xma010644; Tue, 17 Sep 02 16:19:59 +0100
Date: Tue, 17 Sep 2002 16:19:59 +0100
From: Gareth <g.c.bransby-99@student.lboro.ac.uk>
To: linux-mips@linux-mips.org
Subject: Delayed jumps and branches
Message-Id: <20020917161959.33787757.g.c.bransby-99@student.lboro.ac.uk>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <g.c.bransby-99@student.lboro.ac.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: g.c.bransby-99@student.lboro.ac.uk
Precedence: bulk
X-list: linux-mips

Hi,

I have been going through my mips architecture book learning about the delay
slots used in loads, jumps and branches and I am in need of some clarification.
The instruction just after the jump instruction is always executed wether the
jump is taken or not, right? So the compiler can re-aarange the assembly to
take advantage of this, but if no instruction (that can be executed wether the
jump is taken or not) can be placed after the jump, a nop is used intstead. So
take this code for example :

    jal <my_function>
    li  $s2, 3
    li  $v0, 2

If the jump is not taken, it requires 3 cycles to execute these 3 instructions.
If the jump is taken, it requires 3 cycles to execute the first instruction of
my_function, and li $s2, 3 is executed.

Is my reasoning correct?

Thanks
Gareth
