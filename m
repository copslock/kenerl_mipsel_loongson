Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g23IouD22252
	for linux-mips-outgoing; Sun, 3 Mar 2002 10:50:56 -0800
Received: from darth.paname.org (root@ns0.paname.org [212.27.32.70])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g23Ioq922249
	for <linux-mips@oss.sgi.com>; Sun, 3 Mar 2002 10:50:52 -0800
Received: from darth.paname.org (localhost [127.0.0.1])
	by darth.paname.org (8.12.1/8.12.1/Debian -2) with ESMTP id g23HooZB001860
	for <linux-mips@oss.sgi.com>; Sun, 3 Mar 2002 18:50:50 +0100
Received: (from rani@localhost)
	by darth.paname.org (8.12.1/8.12.1/Debian -2) id g23HonFN001859
	for linux-mips@oss.sgi.com; Sun, 3 Mar 2002 18:50:49 +0100
From: Rani Assaf <rani@paname.org>
Date: Sun, 3 Mar 2002 18:50:49 +0100
To: linux-mips@oss.sgi.com
Subject: Changes to head.S
Message-ID: <20020303185049.A1788@paname.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux darth 2.4.17-pre8 
X-NCC-RegID: fr.proxad
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I'm  working  on  support  for  IDT  RC32355  CPU  on  a  board  we're
developping and  when trying to port  my code to a  recent snapshot of
the cvs  tree (up  to now,  I was using  a snapshot  dated of  dec 15,
2001),  the kernel  crashed at  boot  while starting  the init  thread
(unaligned access).

Looking at the diffs, I noticed  that putting back the following lines
at  the end  of head.S  (they've  been removed  in revision  1.29.2.4)
resolves the problem:

/*
 * Align to 8kb boundary for init_task_union which follows in the
 * .text segment.
 */
		.text
                .align  13

Any idea why they have been removed?

BTW,  print_memory_map()  (in  kernel.c)  now uses  long  long  format
without casting (which obviously gives wrong numbers on 32bits archs).

Regards,
Rani
