Received:  by oss.sgi.com id <S305157AbQDUDlI>;
	Thu, 20 Apr 2000 20:41:08 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:60462 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQDUDky>;
	Thu, 20 Apr 2000 20:40:54 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id UAA18613; Thu, 20 Apr 2000 20:36:09 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id UAA58931; Thu, 20 Apr 2000 20:40:23 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA51972
	for linux-list;
	Thu, 20 Apr 2000 20:31:02 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA56123
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 20 Apr 2000 20:30:50 -0700 (PDT)
	mail_from (machida@sm.sony.co.jp)
Received: from ns4.sony.co.jp (ns4.Sony.CO.JP [202.238.80.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA06679
	for <linux@cthulhu.engr.sgi.com>; Thu, 20 Apr 2000 20:30:45 -0700 (PDT)
	mail_from (machida@sm.sony.co.jp)
Received: from mail3.sony.co.jp (gatekeeper7.Sony.CO.JP [202.238.80.21])
	by ns4.sony.co.jp (04/18/00) with ESMTP id MAA07619;
	Fri, 21 Apr 2000 12:30:46 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail3.sony.co.jp (3.7W99051310c) with ESMTP id MAA23187;
	Fri, 21 Apr 2000 12:30:46 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.27.209.5]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id MAA15639; Fri, 21 Apr 2000 12:30:04 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.27.210.135]) by imail.sm.sony.co.jp (8.8.8/3.7W) with ESMTP id MAA02297; Fri, 21 Apr 2000 12:30:15 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.8.8/FreeBSD) with ESMTP id MAA11253; Fri, 21 Apr 2000 12:30:14 +0900 (JST)
To:     ian@zembu.com
Cc:     kk@ddeorg.soft.net, binutils@sourceware.cygnus.com,
        linux@cthulhu.engr.sgi.com, debian-mips@lists.debian.org
Subject: Re: MIPS gas problem
In-Reply-To: <20000420164812.17210.qmail@daffy.airs.com>
References: <200004201207.RAA07021@madras.ddeorg.soft.net>
	<20000420164812.17210.qmail@daffy.airs.com>
X-Mailer: Mew version 1.94.1 on Emacs 19.34 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20000421123014J.machida@sm.sony.co.jp>
Date:   Fri, 21 Apr 2000 12:30:14 +0900
From:   Hiroyuki Machida <machida@sm.sony.co.jp>
X-Dispatcher: imput version 990905(IM130)
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi Ian,

From: Ian Lance Taylor <ian@zembu.com>
Subject: Re: MIPS gas problem
Date: 20 Apr 2000 09:48:12 -0700

>    [~] gcc -c  rotest.c -o rotest.o
>    rotest.c:8: warning: alignment of `global1' is greater than maximum object 
>    file alignment. Using 8.

This message is a gcc issue, as you said. 

But, my reported plobelm is really binutils issue. Sorry to confuse
you. I will describe the problem using only asm file, again. 

Assmbling and linking attached al.S, I got the following result.

% cc -o al -save-temps al.S

% nm al.o | grep global
0000000000000400 R global1
0000000000001000 R global2
0000000000000000 R globalc

% nm al | grep global
0000000000400dc0 R global1
00000000004019c0 R global2
00000000004009c0 R globalc

Alignments of global1 and global2  in "al.o" looks good. But in "al" 
not.

% objdump -h al.o | grep rodata
  5 .rodata       00001010  0000000000000000  0000000000000000 00000250  2**4

% objdump -h al | grep rodata
  9 .rodata       00001010  00000000004009c0  00000000004009c0 000009c0  2**4


I think when ld gathers read only section, the alignment will be broken.
Because .rodata section alignment of al.o is not the maximum rodata
object's alignment value(in this case 2**12).

I tracked down and found that s_change_sec():gas/config/tc-mips.c
resets section alignment to 2**4. 
So, the maximum rodata object's alignment value will be lost in the
following sequence. 

	.rdata		// reset  section-alignment to 2**4
	.algin	10	// update section-alignment to 2**10
        .type    global1,@object;
        .size    global1,4;
global1:
        .word   0;

	.rdata		// reset  section-alignment to 2**4, Why??
	.align	2	// not update ( 2 <= current section-alignment)
string:
        .ascii  "test\n"
	

I want to know the reason why s_change_sec() always reset
section-alignment to 2**4. I think this is wrong.



--- al.S
        .abicalls

        .globl  globalc;
        .rdata;
        .type    globalc,@object;
        .size    globalc,1;
globalc:
        .byte   97;

// rodata aligned 10 (1024)
        .globl  global1;
        .align  10;
        .type    global1,@object;
        .size    global1,4;
global1:
        .word   0;

// rodata aligned 12 (4096)
        .globl  global2;
        .align  12;
        .type    global2,@object;
        .size    global2,4;
global2:
        .word   1;

// data
        .globl  total_ng
        .data
        .align  2
        .type    total_ng,@object
        .size    total_ng,4
total_ng:
        .word   0

// rodata again
        .rdata
        .align  2
string:
        .ascii  "test\n"
        .text
        .align  3
        .globl  main
        .ent    main
main:
        nop;
        nop
        nop
        .end main
--- endof al.S

---
Hiroyuki Machida
Creative Station		SCE Inc./Sony Corp.
