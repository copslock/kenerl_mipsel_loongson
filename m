Received:  by oss.sgi.com id <S305171AbQALUQc>;
	Wed, 12 Jan 2000 12:16:32 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:55818 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQALUQL>; Wed, 12 Jan 2000 12:16:11 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA01883; Wed, 12 Jan 2000 12:19:48 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA03036
	for linux-list;
	Wed, 12 Jan 2000 12:05:11 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA89305
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 12 Jan 2000 12:05:07 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from po4.glue.umd.edu (po4.glue.umd.edu [128.8.10.124]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA08945
	for <linux@cthulhu.engr.sgi.com>; Wed, 12 Jan 2000 12:04:31 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from z.glue.umd.edu (root@z.glue.umd.edu [128.8.10.71])
	by po4.glue.umd.edu (8.9.3/8.9.3) with ESMTP id PAA25301
	for <linux@cthulhu.engr.sgi.com>; Wed, 12 Jan 2000 15:04:22 -0500 (EST)
Received: from z.glue.umd.edu (sendmail@localhost [127.0.0.1])
	by z.glue.umd.edu (8.9.3/8.9.3) with SMTP id PAA04428
	for <linux@cthulhu.engr.sgi.com>; Wed, 12 Jan 2000 15:04:21 -0500 (EST)
Received: from localhost (weave@localhost)
	by z.glue.umd.edu (8.9.3/8.9.3) with ESMTP id PAA04418
	for <linux@cthulhu.engr.sgi.com>; Wed, 12 Jan 2000 15:04:20 -0500 (EST)
X-Authentication-Warning: z.glue.umd.edu: weave owned process doing -bs
Date:   Wed, 12 Jan 2000 15:04:20 -0500 (EST)
From:   Vince Weaver <weave@eng.umd.edu>
X-Sender: weave@z.glue.umd.edu
To:     linux@cthulhu.engr.sgi.com
Subject: Re: cross-compile fails
In-Reply-To: <Pine.GSO.4.21.0001121124200.14194-100000@z.glue.umd.edu>
Message-ID: <Pine.GSO.4.21.0001121447120.3077-100000@z.glue.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hello again

OK, I got things to compile [I hadn't done enough "make clean"'s it would
seem]

after copying the created vmlinux file to / on the machine [it is running
Irix 6.5] I then rebooted into the BootProm and told it to
"boot vmlinux"

It then gave this:

[------------------------------------]

134480+22592+3216+341792+49040d+4460+6704 entry: 0x8dfa5fa0

Exception: <vector=Normal>
Status register: 0x30044803<CU1,CU0,CH,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
Cause register: 0x3010<LE=0,IP6,IP5,EXL=RADE>
Exception PC: 0x88147eec
Read address error exception, bad address: 0x2b
Local I/O interrupt register 1: 0x80 <VR/GIO2>
Local I/O interrupt register 2: 0xc0 <SLOT0,SLOT1>
  Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
  tmp: 881be090 881be090 a 88150864 13 8dfabd30 0 48
  sve: 8dfde8e4 8dfff908 8dfb0b00 8dfff300 a8747590 9fc4a744 0 9fc4a744
  t8 48 t9 8dfffb8f at 88150000 v0 0 v1 8dfff2e0 k1 bad11bad
  gp 88008000 fp 9fc4a88c sp 88009fd0 ra 880025d0

PANIC: Unexpected exception

[-------------------------------]

Typed that in by hand, hope there are no mistakes

if I look up the PC in the System.map file I find

0000000088147eec T sgi_sysinit

and if I do an objdump I find:

0000000088147eec <sgi_sysinit>:
    88147eec:   27bdffd0        addiu   $sp,$sp,-48
    88147ef0:   afb20018        sw      $s2,24($sp)
    88147ef4:   00009021        move    $s2,$zero
    88147ef8:   afb10014        sw      $s1,20($sp)
    88147efc:   2411ffff        li      $s1,-1
    88147f00:   02402021        move    $a0,$s2
    88147f04:   afbf0028        sw      $ra,40($sp)
    88147f08:   afb50024        sw      $s5,36($sp)
    88147f0c:   afb40020        sw      $s4,32($sp)
    88147f10:   afb3001c        sw      $s3,28($sp)
    88147f14:   0e0522de        jal     88148b78 <prom_getchild>
    .....
    continues for a while

any hints what might be wrong?  I can send a .config to anyone who might
want it.

The cross compiler tools are from the i386/mips-linux .rpm file on
oss.sgi.com....

The system I am trying this on is an Indigo2:

orws1:/disk3/usr/people/vince$ hinv
CPU: MIPS R4000 Processor Chip Revision: 3.0
FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0
1 100 MHZ IP22 Processor
Main memory size: 96 Mbytes
Secondary unified instruction/data cache size: 1 Mbyte on Processor 0
Instruction cache size: 8 Kbytes
Data cache size: 8 Kbytes
Integral SCSI controller 0: Version WD33C93B, revision D
  Disk drive: unit 1 on SCSI controller 0
  Tape drive: unit 2 on SCSI controller 0: DAT
  Disk drive: unit 3 on SCSI controller 0
Integral SCSI controller 1: Version WD33C93B, revision D
On-board serial ports: 2
On-board bi-directional parallel port
Graphics board: GU1-Extreme
Integral Ethernet: ec0, version 1
Iris Audio Processor: version A2 revision 0.1.0
EISA bus: adapter 0

Vince

____________
\  /\  /\  /  Vince Weaver          
 \/__\/__\/   weave@eng.umd.edu     http://www.glue.umd.edu/~weave
