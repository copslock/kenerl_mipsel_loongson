Received:  by oss.sgi.com id <S42247AbQEVCsg>;
	Sun, 21 May 2000 19:48:36 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:43353 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42239AbQEVCsS>;
	Sun, 21 May 2000 19:48:18 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id TAA01166; Sun, 21 May 2000 19:43:26 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA32281
	for linux-list;
	Sun, 21 May 2000 19:32:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA79670
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 21 May 2000 19:32:52 -0700 (PDT)
	mail_from (machida@sm.sony.co.jp)
Received: from ns4.sony.co.jp (ns4.Sony.CO.JP [202.238.80.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA03327
	for <linux@cthulhu.engr.sgi.com>; Sun, 21 May 2000 19:32:50 -0700 (PDT)
	mail_from (machida@sm.sony.co.jp)
Received: from mail2.sony.co.jp (gatekeeper7.Sony.CO.JP [202.238.80.21])
	by ns4.sony.co.jp (R8) with ESMTP id LAA48263;
	Mon, 22 May 2000 11:32:45 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail2.sony.co.jp (R8) with ESMTP id LAA07146;
	Mon, 22 May 2000 11:32:45 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.27.209.5]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id LAA10273; Mon, 22 May 2000 11:32:42 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.27.210.135]) by imail.sm.sony.co.jp (8.8.8/3.7W) with ESMTP id LAA24249; Mon, 22 May 2000 11:32:14 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.8.8/FreeBSD) with ESMTP id LAA09143; Mon, 22 May 2000 11:32:14 +0900 (JST)
To:     agx@bert.physik.uni-konstanz.de
Cc:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: SIGIO Handler
In-Reply-To: <20000518161135.A26055@bert.physik.uni-konstanz.de>
References: <20000518161135.A26055@bert.physik.uni-konstanz.de>
X-Mailer: Mew version 1.94.1 on Emacs 19.34 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20000522113213A.machida@sm.sony.co.jp>
Date:   Mon, 22 May 2000 11:32:13 +0900
From:   Hiroyuki Machida <machida@sm.sony.co.jp>
X-Dispatcher: imput version 990905(IM130)
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi, Guido

From: Guido Guenther <agx@bert.physik.uni-konstanz.de>
Subject: SIGIO Handler
Date: Thu, 18 May 2000 16:11:36 +0200

> I'm still trying to get the mouse to work under X. The problem seems not
> to be related to X itself but to a kernel/glibc problem. X uses a SIGIO
> handler to "get notified" about mouse events. I wrote my own small SIGIO
> handler(see attached program) which works fine on my intel box but not
> on an indy (glibc-2.0.6-3lm/linux-2.2.13-20000211). 

I had experienced same SIGIO problem. It that time, the definitions
of glibc's FASYNC (in fnctbits.h) and kernel's FASYNC (in
asm/fcnt..h) were not same. 

Check those values in your system, first.

---
Hiroyuki Machida
