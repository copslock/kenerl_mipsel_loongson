Received:  by oss.sgi.com id <S42268AbQE3SXH>;
	Tue, 30 May 2000 11:23:07 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:28726 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42263AbQE3SWu>; Tue, 30 May 2000 11:22:50 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA02141; Tue, 30 May 2000 11:42:29 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA27339
	for linux-list;
	Tue, 30 May 2000 11:27:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA30651
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 30 May 2000 11:26:55 -0700 (PDT)
	mail_from (kei@arch.sony.co.jp)
Received: from ns4.sony.co.jp (ns4.Sony.CO.JP [202.238.80.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA04362
	for <linux@cthulhu.engr.sgi.com>; Tue, 30 May 2000 10:52:37 -0700 (PDT)
	mail_from (kei@arch.sony.co.jp)
Received: from mail1.sony.co.jp (gatekeeper7.Sony.CO.JP [202.238.80.21])
	by ns4.sony.co.jp (R8) with ESMTP id CAA50155
	for <linux@cthulhu.engr.sgi.com>; Wed, 31 May 2000 02:52:41 +0900 (JST)
Received: from newsa.net.arch.sony.co.jp ([43.13.251.1])
	by mail1.sony.co.jp (R8) with ESMTP id CAA20474
	for <linux@cthulhu.engr.sgi.com>; Wed, 31 May 2000 02:52:41 +0900 (JST)
Received: from arch.sony.co.jp (kei@[43.11.132.48])
	by newsa.net.arch.sony.co.jp (8.9.1a/3.7W) with ESMTP id CAA06812
	for <linux@cthulhu.engr.sgi.com>; Wed, 31 May 2000 02:52:54 +0900 (JST)
Message-Id: <200005301752.CAA06812@newsa.net.arch.sony.co.jp>
To:     linux@cthulhu.engr.sgi.com
Subject: Compile speed on SGI/Linux (like Indy)
Date:   Wed, 31 May 2000 03:15:19 +0900
From:   Hiroshi Kawashima <kei@arch.sony.co.jp>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi.

I'm one of member of Linux-VR project (porting Linux on NEC VR41xx based WinCE
machines) http://linux-vr.org/ .

I've almostly completed porting Kernel Floating Emulation of
Linux/Mips to Linux-VR, so I'm moving to building userland (hard-float).

Since VR41xx based WinCE machine is very slow, I'm now considering to
buy SGI machines to build userland binaries.

But before that, my questions is how fast Indy comparing with VR41xx based machines ?

I deeply appreciate if anyone suggest me compile time for any source packages on
Indy or other SGI machines.
Compile time of any source packages is very helpful for me.

Thank you in advance.
----
Kawashima
