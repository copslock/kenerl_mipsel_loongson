Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA53957 for <linux-archive@neteng.engr.sgi.com>; Thu, 6 Aug 1998 00:14:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA73983
	for linux-list;
	Thu, 6 Aug 1998 00:13:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgitokyo.nsg.sgi.com (sgitokyo.nsg.sgi.com [134.14.128.2])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA71793
	for <linux@engr.sgi.com>;
	Thu, 6 Aug 1998 00:13:27 -0700 (PDT)
	mail_from (hakamada@nsg.sgi.com)
Received: from meteor.nsg.sgi.com (meteor.nsg.sgi.com [134.14.162.53])
	by sgitokyo.nsg.sgi.com (8.8.8/3.6W-98051410)
	id QAA23469
	for <@sgitokyo.nsg.sgi.com:linux@engr.sgi.com>; Thu, 6 Aug 1998 16:13:25 +0900 (JST)
Received: from localhost (localhost [127.0.0.1]) by meteor.nsg.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA65586 for <linux@engr.sgi.com>; Thu, 6 Aug 1998 16:13:25 +0900 (JST)
To: linux@cthulhu.engr.sgi.com
Subject: Compiling kernel on HardHat
X-Face: >$%-E_%BaR5YR&eW,GS3:]Cxv7ANEn%~'H!9L+1r[D<9qG/,WD4]L%#;`Nqb#^xc_*gG#o7
 j.@E>?09*)XTd}W5}^F*0K^suO|]f{'gAsluG~0(S-BSM96Ev@N9Rmf"{(0=7&ivn9n<-LS,sWB7W/
 H\[
X-Mailer: Mew version 1.92.4 on XEmacs 20.4 (Emerald)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <19980806161325E.hakamada@nsg.sgi.com>
Date: Thu, 06 Aug 1998 16:13:25 +0900 (JST)
From: Takeshi Hakamada <hakamada@nsg.sgi.com>
X-Dispatcher: imput version 971024
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I have installed HardHat on R5000 Indy and it is very cool.
Installation procedure becomes much easier than previous release.
I admire all your effort to port Linux for SGI system.

I tried to compile kernel on HardHat using RPM kernel(2.1.100) source,
I can't build kernel due to following error.
In arch/mips/sgi/kernel/setup.c, 

setup.c:18: asm/vector.h: No such file or directory

Error message shows that I need to have include/asm/vector.h.
How can I get vector.h? Do I have to get latest kernel source from
ftp.linux.sgi.com?

Cheers,
Takeshi

--
Takeshi Hakamada                  
Nihon Silicon Graphics
E-mail: hakamada@nsg.sgi.com, URL: http://reality.sgi.com/hakamada_nsg/
Voice mail: (internal)822-1300, (external)+81-3-5488-1863-1300
