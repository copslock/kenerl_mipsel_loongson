Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7D3cYL28522
	for linux-mips-outgoing; Sun, 12 Aug 2001 20:38:34 -0700
Received: from surfers.oz.agile.tv (fw.oz.agile.tv [210.9.52.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7D3cVj28519
	for <linux-mips@oss.sgi.com>; Sun, 12 Aug 2001 20:38:32 -0700
Received: from oz.agile.tv (IDENT:simong@pacific.oz.agile.tv [192.168.16.16])
	by surfers.oz.agile.tv (8.11.0/8.11.0) with ESMTP id f7D3cUj02355
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 13:38:30 +1000
Message-ID: <3B774FA9.A96C838B@oz.agile.tv>
Date: Mon, 13 Aug 2001 13:55:21 +1000
From: Simon Gee <simong@oz.agile.tv>
Organization: AgileTV Corporation Australia
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: PATCH: missing call-graph data and profiling
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

When attempting to use profiling under mips-linux the produced gmon.out
file was reported as "missing call -raph data". The problem lay in the
fact that the following from machine-gmon.h:

        "move $5,$31;" \
        "jal __mcount;" \
        "move $4,$1;" \

was assembled as:

0x432458 <_mcount+40>: move $a1,$ra
0x43245c <_mcount+44>: lw $t9,-32724($gp)
0x432460 <_mcount+48>: nop
0x432464 <_mcount+52>: addiu $t9,$t9,8816
0x432468 <_mcount+56>: jalr $t9
0x43246c <_mcount+60>: nop
0x432470 <_mcount+64>: lw $gp,0($s8)
0x432474 <_mcount+68>: move $a0,$at

by gas. Basically, the fact that "jal __mcount" was being expanded
forced "move $4,$1;" out of the delay slot which resulted in the first
argument to __mcount to be incorrect. The following patch against glibc
corrects this problem.

*** sysdeps/mips/machine-gmon.h.orig    Mon Aug 13 12:17:39 2001
--- sysdeps/mips/machine-gmon.h Mon Aug 13 12:18:00 2001
***************
*** 43,50 ****
          "sw $1,16($29);" \
          "sw $31,20($29);" \
          "move $5,$31;" \
-         "jal __mcount;" \
          "move $4,$1;" \
          "lw $4,24($29);" \
          "lw $5,28($29);" \
          "lw $6,32($29);" \
--- 43,51 ----
          "sw $1,16($29);" \
          "sw $31,20($29);" \
          "move $5,$31;" \
          "move $4,$1;" \
+         "jal __mcount;" \
+         "nop;" \
          "lw $4,24($29);" \
          "lw $5,28($29);" \
          "lw $6,32($29);" \

Simon
