Received:  by oss.sgi.com id <S42250AbQG0XIL>;
	Thu, 27 Jul 2000 16:08:11 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:55318 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42222AbQG0XH5>;
	Thu, 27 Jul 2000 16:07:57 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA24039
	for <linux-mips@oss.sgi.com>; Thu, 27 Jul 2000 16:00:33 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id QAA68576 for <linux-mips@oss.sgi.com>; Thu, 27 Jul 2000 16:07:31 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA31725
	for <linux@engr.sgi.com>;
	Thu, 27 Jul 2000 16:05:55 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA00101
	for <linux@engr.sgi.com>; Thu, 27 Jul 2000 16:05:54 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id QAA22234;
	Thu, 27 Jul 2000 16:05:08 -0700
Message-ID: <3980C024.8DCCA084@mvista.com>
Date:   Thu, 27 Jul 2000 16:05:08 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: strace on Linux/MIPS?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Has anybody been successful in trying to get strace running on
Linux/MIPS?  I managed to get 4.2, with a little from CVS tree, compiled
and run.  However, it does not quite right.  It only prints the first
system. See below.  Verified that this is the same behavior on both
2.3.99-pre3 and 2.4.0-test2.

sh-2.03# strace ls
execve("/bin/ls", ["ls"], [/* 14 vars */]) = 0
bin  boot  dev  etc  lib  mnt  opt  proc  sbin  share  tmp  var

Any idea?

Jun
