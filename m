Received:  by oss.sgi.com id <S305180AbQELV5n>;
	Fri, 12 May 2000 21:57:43 +0000
Received: from deliverator.sgi.com ([204.94.214.10]:24685 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQELV5V>;
	Fri, 12 May 2000 21:57:21 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA27828; Fri, 12 May 2000 14:52:31 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA93927
	for linux-list;
	Fri, 12 May 2000 14:51:57 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA14172
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 12 May 2000 14:51:55 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA01570
	for <linux@cthulhu.engr.sgi.com>; Fri, 12 May 2000 14:51:53 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 3ACC37F3; Fri, 12 May 2000 23:51:51 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 6328C8FA8; Fri, 12 May 2000 23:47:26 +0200 (CEST)
Date:   Fri, 12 May 2000 23:47:26 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: Kernel crash 2.3.99pre6 on Little Endian Decstation
Message-ID: <20000512234725.A805@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
while installing the Decstation new i have problems getting the 
system to start - Which is very interesting as it would boot with
the same kernel ...

It crashes here:

Starting INET services: Unable to handle kernel paging request at virtual address 00000008, epc == 800a967c, ra == 800a966c
$0 : 00000000 80150010 fffffffe 8117a480
$4 : 00000000 811e0384 811e0384 00000001
$8 : 00000008 80144968 00000003 00000002
$12: fffffffc 3739f15a 7ffffa38 83f0bec0
$16: 811790e0 83cbbec0 83cc1680 83c9c00b
$20: 83cbbec0 00000009 00000005 10014218
$24: 00000001 2ab3ff90
$28: 83cba000 83cbbe28 00000020 800a966c
epc   : 800a967c
Status: 30052c03
Cause : 30000008
Process pidof (pid: 52, stackpage=83cba000)
Stack: 8008fc08 83c9c00b 83cbbec0 00000009 00000000 00000000 83cc1680 800aa14c
       83cc14e0 83c9c00b 83cbbec0 00000009 83f0be60 83f0bde0 800901b4 8009b830
       80192820 00003000 83f0bde0 83dad120 83c9c008 00000003 000062e5 00003000
       83f0be60 00000000 00000000 83c9c000 00000001 100147f8 1001459c 7ffffc08
       80090520 80090510 80070344 80070330 fffffff4 7ffffb08 83f0bde0 00000000
       1001459c ...
Call Trace: [<8008fc08>] [<800aa14c>] [<800901b4>] [<8009b830>] [<80090520>] [<80090510>] [<80070344>] [<80070330>] [<8008f7d4>] [<800906b4>] [<8007040c>] [<8008c104>] [<8004aec8>]
Code: 2402fffe  8fa40010  8e030008 <8c820008> 8c6300a0  8c4500a0  10a30009  00000000  8ca20028
Warning: trailing garbage ignored on Code: line
  Text: 'Code: 2402fffe  8fa40010  8e030008 <8c820008> 8c6300a0  8c4500a0  10a30009  00000000  8ca20028 '
  Garbage: ' '
/usr/bin/objdump: Can't disassemble for architecture UNKNOWN!

ksymoops: Oops_decode pclose failed 0x100

>>RA : 800a966c <proc_permission+34/b8>
>>PC: 800a967c <proc_permission+44/b8>
Trace: 8008fc08 <real_lookup+d0/1f0>
Trace: 800aa14c <proc_pid_follow_link+2c/58>
Trace: 800901b4 <walk_name+48c/5cc>
Trace: 8009b830 <iput+2bc/2d4>
Trace: 80090520 <lookup_dentry+30/54>
Trace: 80090510 <lookup_dentry+20/54>
Trace: 80070344 <do_munmap+290/2c4>
Trace: 80070330 <do_munmap+27c/2c4>
Trace: 8008f7d4 <getname+54/154>
Trace: 800906b4 <__namei+38/b8>
Trace: 8007040c <sys_munmap+94/10c>
Trace: 8008c104 <sys_newstat+20/94>
Trace: 8004aec8 <stack_done+1c/38>


I did the disasm myself with objdump as one might not pass the
architecture to ksymoops ...

00000000800a9638 <proc_permission>:
    800a9638:   27bdffe0        addiu   $sp,$sp,-32
    800a963c:   afb00018        sw      $s0,24($sp)
    800a9640:   afbf001c        sw      $ra,28($sp)
    800a9644:   0c02a534        jal     800a94d0 <standard_permission>
    800a9648:   00808021        move    $s0,$a0
    800a964c:   14400024        bnez    $v0,800a96e0 <proc_permission+a8>
    800a9650:   2402fff3        li      $v0,-13
    800a9654:   02002021        move    $a0,$s0
    800a9658:   27a50010        addiu   $a1,$sp,16
    800a965c:   8f820320        lw      $v0,800($gp)
    800a9660:   8c500008        lw      $s0,8($v0)
RA->800a9664:   0c02a49f        jal     800a927c <proc_root_link>
    800a9668:   27a60014        addiu   $a2,$sp,20
    800a966c:   1440001c        bnez    $v0,800a96e0 <proc_permission+a8>
    800a9670:   2402fffe        li      $v0,-2
    800a9674:   8fa40010        lw      $a0,16($sp)
    800a9678:   8e030008        lw      $v1,8($s0)
PC->800a967c:   8c820008        lw      $v0,8($a0)
    800a9680:   8c6300a0        lw      $v1,160($v1)
    800a9684:   8c4500a0        lw      $a1,160($v0)
    800a9688:   10a30009        beq     $a1,$v1,800a96b0 <proc_permission+78>

Somebody got an idea ?

Ah - egcs 1.0.3a - binutils 2.8.1 - Kernel 2.3.99pre6

Running NFS Root

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
