Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g66LZERw027804
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 6 Jul 2002 14:35:14 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g66LZEFa027803
	for linux-mips-outgoing; Sat, 6 Jul 2002 14:35:14 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nt_server.stellartec.com (mail.stellartec.com [65.107.16.99])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g66LZ5Rw027794
	for <linux-mips@oss.sgi.com>; Sat, 6 Jul 2002 14:35:06 -0700
Received: from wssseeger ([192.168.1.53]) by nt_server.stellartec.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 568-43562U100L2S100) with SMTP id AAA573
          for <linux-mips@oss.sgi.com>; Sat, 6 Jul 2002 14:39:15 -0700
Reply-To: <sseeger@stellartec.com>
From: sseeger@stellartec.com (Steven Seeger)
To: <linux-mips@oss.sgi.com>
Subject: FW: [Linux-mips-kernel]my slab problem
Date: Sat, 6 Jul 2002 14:41:31 -0700
Message-ID: <01fe01c22535$e4fc9c90$3501a8c0@wssseeger>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ok I've narrowed down my problem with the SF tree's 2.4.18 kernel and with
the OSS 2.4.18 tree (tag linux_2_4, from about 3 weeks ago).

I'm running on an NEC Osprey board. I've confirmed that XIP in ROM isn't
causing this problem.

I have a module that kmallocs almost all of the free memory in the system on
insmod, and kfrees the memory on rmmod. Then, when I try to run a program
that needs a lot of memory it page faults somewhere in the __wake_up
function trying to wake up kswapd. kswapd actually does wake up and runs
after the page fault, but doesn't find any slabs to reap.

In my working kernel with all the slab debug stuff turned on, I'll see that
slabs from the 131072 slab size (my kmallocs were 90000 bytes each) will get
reaped as needed. This doesn't happen with the SF kernel. In fact,
kmem_cache_reap gets to the comment that says /* couldn't find anything to
reap */

I don't know if it isn't finding anything because of the page fault in
__wake_up (which oddly enough doesn't crash the system..it just kills the
process that was running, ie the memory hog)

My working kernel is the 2.4.0-test9 kernel that Brad did a lot of work on.
I really would like to get the later and greater kernel up and running. If
anybody can offer some advice please let me know.

I figure I'll figure this problem out before messing with the execve problem
in the OSS 2.5.2 and 2.4.19 kernel since for all I know if I get those
booting I'll run into this problem here. :)

If anybody can point me in the right direction I'd appreciate it.

Steve



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Got root? We do.
http://thinkgeek.com/sf
_______________________________________________
Linux-mips-kernel mailing list
Linux-mips-kernel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-mips-kernel
