Received:  by oss.sgi.com id <S305157AbQDTMSJ>;
	Thu, 20 Apr 2000 05:18:09 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:26391 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQDTMSC>; Thu, 20 Apr 2000 05:18:02 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id FAA09613; Thu, 20 Apr 2000 05:22:03 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id FAA34956; Thu, 20 Apr 2000 05:17:30 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA88662
	for linux-list;
	Thu, 20 Apr 2000 05:05:41 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA84946
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 20 Apr 2000 05:05:26 -0700 (PDT)
	mail_from (kk@ddeorg.soft.net)
Received: from firewall.ddeorg.soft.net (firewall.ddeorg.soft.net [164.164.74.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA08993
	for <linux@cthulhu.engr.sgi.com>; Thu, 20 Apr 2000 05:05:17 -0700 (PDT)
	mail_from (kk@ddeorg.soft.net)
Received: by firewall.ddeorg.soft.net (8.8.8/9.7) 
	id RAA18483; Thu, 20 Apr 2000 17:38:29 +0530 (IST)
Received: from madras.ddeorg.soft.net by ddeorg.soft.net (8.8.8/9.6) with ESMTP 
	id RAA18470; Thu, 20 Apr 2000 17:38:22 +0530 (IST)
Received: from localhost by madras.ddeorg.soft.net (8.8.5/9.7) with SMTP 
	id RAA07021; Thu, 20 Apr 2000 17:37:57 +0530 (IST)
Message-Id: <200004201207.RAA07021@madras.ddeorg.soft.net>
X-Mailer: exmh version 2.0.1 12/23/97
To:     Hiroyuki Machida <machida@sm.sony.co.jp>
cc:     binutils@sourceware.cygnus.com, linux@cthulhu.engr.sgi.com,
        debian-mips@lists.debian.org
Subject: Re: MIPS gas problem 
In-reply-to: Your message of "Thu, 20 Apr 2000 11:13:20 +0900."
             <20000420111320Z.machida@sm.sony.co.jp> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Thu, 20 Apr 2000 17:37:56 +0530
From:   "Koundinya.K" <kk@ddeorg.soft.net>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


machida@sm.sony.co.jp said:
-> Hi
-> I found the problem  "__attribute__ ((aligned(xx))" doesn't work
-> properly on MIPS/Linux. Please try to execute the attached test.  I
-> think this problem can be reproduced on any ELF/MIPS box except
-> EMBEDED system which has OS name "elf". 

-> I tracked down and finaly found gas/config/t-mips.c:s_change_sec(sec)
-> sets  always ".rodata" section-alignment to 2**4. This should be set
-> to the maximum rodata object's alignment value.

I am seeing something different (gcc 2.95.2 and binutils from snapshot 
000213) on my mips based machine (mips-dde-sysv4.2MP)

[~] gcc -c  rotest.c -o rotest.o
rotest.c:8: warning: alignment of `global1' is greater than maximum object 
file alignment. Using 8.
rotest.c:9: warning: alignment of `global2' is greater than maximum object 
file alignment. Using 8.
rotest.c:11: warning: alignment of `local1' is greater than maximum object 
file alignment. Using 8.
rotest.c:12: warning: alignment of `local2' is greater than maximum object 
file alignment. Using 8.


koundinya
