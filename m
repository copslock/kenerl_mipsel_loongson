Received:  by oss.sgi.com id <S305185AbQDXFSI>;
	Sun, 23 Apr 2000 22:18:08 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:87 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305161AbQDXFRl>;
	Sun, 23 Apr 2000 22:17:41 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id WAA16793; Sun, 23 Apr 2000 22:12:55 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id WAA26138
	for linux-list;
	Sun, 23 Apr 2000 22:04:38 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA36848
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 23 Apr 2000 22:04:35 -0700 (PDT)
	mail_from (kk@ddeorg.soft.net)
Received: from firewall.ddeorg.soft.net (firewall.ddeorg.soft.net [164.164.74.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id WAA07969
	for <linux@cthulhu.engr.sgi.com>; Sun, 23 Apr 2000 22:04:19 -0700 (PDT)
	mail_from (kk@ddeorg.soft.net)
Received: by firewall.ddeorg.soft.net (8.8.8/9.7) 
	id KAA04138; Mon, 24 Apr 2000 10:37:29 +0530 (IST)
Received: from madras.ddeorg.soft.net by ddeorg.soft.net (8.8.8/9.6) with ESMTP 
	id KAA20530; Mon, 24 Apr 2000 10:37:24 +0530 (IST)
Received: from localhost by madras.ddeorg.soft.net (8.8.5/9.7) with SMTP 
	id KAA01485; Mon, 24 Apr 2000 10:36:38 +0530 (IST)
Message-Id: <200004240506.KAA01485@madras.ddeorg.soft.net>
X-Mailer: exmh version 2.0.1 12/23/97
To:     Hiroyuki Machida <machida@sm.sony.co.jp>
cc:     flo@rfc822.org, ian@zembu.com, binutils@sourceware.cygnus.com,
        linux@cthulhu.engr.sgi.com, debian-mips@lists.debian.org
Subject: Re: MIPS gas problem 
In-reply-to: Your message of "Fri, 21 Apr 2000 10:52:25 +0900."
             <20000421105225J.machida@sm.sony.co.jp> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Mon, 24 Apr 2000 10:36:37 +0530
From:   "Koundinya.K" <kk@ddeorg.soft.net>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,
machida@sm.sony.co.jp said:
-> I rewrite the test program which is not depending your gcc version or
-> config. Please try this.

-> #define P1  10 #define P2  12

Sorry for the delay in trying out this test case. I was over the edge for 
the past 3 days :-)

O.K, There were no warnings with this test case unlike the previous one.

[~] gcc -c rotest1.c -o rotest1.o

[~] objdump -h objtest1.o

otest1.o:     file format elf32-tradbigmips

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00000320  00000000  00000000  00000040  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 .data         00000010  00000000  00000000  00000360  2**4
                  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          00000000  00000000  00000000  00000370  2**4
                  ALLOC
  3 .reginfo      00000018  00000000  00000000  00000370  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA, LINK_ONCE_SAME_SIZE
  4 .mdebug       00000240  00000000  00000000  00000388  2**2
                  CONTENTS, READONLY, DEBUGGING
  5 .note         00000014  00000000  00000000  000005c8  2**0
                  CONTENTS, READONLY
  6 .comment      00000035  00000000  00000000  000005dc  2**0
                  CONTENTS, READONLY
  7 .rodata       00001060  00000000  00000000  00000620  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, DATA



koundinya
