Received:  by oss.sgi.com id <S553809AbRCJRuP>;
	Sat, 10 Mar 2001 09:50:15 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:19976 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553795AbRCJRuJ>;
	Sat, 10 Mar 2001 09:50:09 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 920817F6; Sat, 10 Mar 2001 18:49:57 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 9D511EFA8; Sat, 10 Mar 2001 20:50:28 +0100 (CET)
Date:   Sat, 10 Mar 2001 20:50:28 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: Failure 2.4.2 + glibc 2.2 still illegal instruction
Message-ID: <20010310205028.B16121@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi,
i am still seeing illegal instruction stuff with current cvs kernel
and glibc 2.2 


Basically all glibc 2.2 compiled binary crash with illegal instruction:

resume.rfc822.org login: root
Password: 
Last login: Sat Mar 10 17:42:25 2001 on ttyS0
Linux resume.rfc822.org 2.4.2 #2 Sat Mar 10 20:37:49 CET 2001 mips unknown

Most of the programs included with the Debian GNU/Linux system are
freely redistributable; the exact distribution terms for each program
are described in the individual files in /usr/share/doc/*/copyright

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.

warning: things are broken at the moment.  Fixes in progress.
you'd be best to try again later.  :)

You have mail.
resume:~# find
[find:190] Illegal instruction 7f454c46 at 2ac9e000 ra=2ab166c4
Illegal instruction
resume:~# ls
[ls:191] Illegal instruction 0100017c at 2ac9688c ra=00000000
Illegal instruction
resume:~# sleep 1
[sleep:192] Illegal instruction 0100017c at 2ad0788c ra=00000000
Illegal instruction
resume:~# find
[find:193] Illegal instruction 7f454c46 at 2ac9e000 ra=2ab166c4
Illegal instruction
resume:~# find
[find:194] Illegal instruction 7f454c46 at 2ac9e000 ra=2ab166c4
Illegal instruction
resume:~# sleep
[sleep:195] Illegal instruction 0100017c at 2ad0788c ra=00000000
Illegal instruction
resume:~# sleep
[sleep:196] Illegal instruction 0100017c at 2ad0788c ra=00000000
Illegal instruction
resume:~# sleep
[sleep:197] Illegal instruction 0100017c at 2ad0788c ra=00000000
Illegal instruction
resume:~# 

strace shows that the last system call called is
"sysmips(MIPS_ATOMIC_SET, ...)"

So long

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
