Received:  by oss.sgi.com id <S305163AbQDQLhx>;
	Mon, 17 Apr 2000 04:37:53 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:39996 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305161AbQDQLhh>;
	Mon, 17 Apr 2000 04:37:37 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id EAA19929; Mon, 17 Apr 2000 04:32:52 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA46046
	for linux-list;
	Mon, 17 Apr 2000 04:25:14 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA53730
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 17 Apr 2000 04:25:12 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA09012
	for <linux@cthulhu.engr.sgi.com>; Mon, 17 Apr 2000 04:25:11 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id DBB6B7D9; Mon, 17 Apr 2000 13:25:12 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id BC0028FC4; Mon, 17 Apr 2000 13:17:01 +0200 (CEST)
Date:   Mon, 17 Apr 2000 13:17:01 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: sys_chown vs. sys_lchown
Message-ID: <20000417131701.A4840@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,
i have discovered some interesting things concerning the chown/lchown
syscall:

gcc -O2 -s -o usermod usermod.o ../libmisc/libmisc.a ../lib/libshadow.a -lcrypt
../libmisc/libmisc.a(chowndir.o): In function `chown_tree':
chowndir.c(.text+0x248): warning: lchown is not implemented and will always fail

I discovered a anomaly there when trying to compile current strace
which has sys_lchown which is sys_chown in current glibc and fails
to compile thereof.

I am not shure where the actual problem is but there
is someone more knowledged ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
