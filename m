Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0KBcwo18558
	for linux-mips-outgoing; Sun, 20 Jan 2002 03:38:58 -0800
Received: from ns4.sony.co.jp (NS4.Sony.CO.JP [146.215.0.102])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0KBcqP18555
	for <linux-mips@oss.sgi.com>; Sun, 20 Jan 2002 03:38:52 -0800
Received: from mail2.sony.co.jp (GateKeeper11.Sony.CO.JP [146.215.0.74])
	by ns4.sony.co.jp (R8/Sony) with ESMTP id g0KAckY75219;
	Sun, 20 Jan 2002 19:38:46 +0900 (JST)
Received: from mail2.sony.co.jp (localhost [127.0.0.1])
	by mail2.sony.co.jp (R8) with ESMTP id g0KAcjH03835;
	Sun, 20 Jan 2002 19:38:45 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail2.sony.co.jp (R8) with ESMTP id g0KAcjA03831;
	Sun, 20 Jan 2002 19:38:45 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.2.217.16]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id TAA14007; Sun, 20 Jan 2002 19:43:32 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.2.226.27]) by imail.sm.sony.co.jp (8.9.3+3.2W/3.7W) with ESMTP id TAA19168; Sun, 20 Jan 2002 19:38:44 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.11.0/8.11.0) with ESMTP id g0KAciJ00710; Sun, 20 Jan 2002 19:38:44 +0900 (JST)
To: hjl@lucon.org
Cc: kevink@mips.com, drepper@redhat.com, libc-hacker@sources.redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
In-Reply-To: <20020118201139.A847@lucon.org>
References: <20020118101908.C23887@lucon.org>
	<01b801c1a081$3f6518e0$0deca8c0@Ulysses>
	<20020118201139.A847@lucon.org>
X-Mailer: Mew version 1.94.2 on Emacs 19.28 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020120193843M.machida@sm.sony.co.jp>
Date: Sun, 20 Jan 2002 19:38:43 +0900
From: Machida Hiroyuki <machida@sm.sony.co.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

From: "H . J . Lu" <hjl@lucon.org>
Subject: Re: thread-ready ABIs
Date: Fri, 18 Jan 2002 20:11:39 -0800

> I like the read-only k0 idea. We just need to make a system call to
> tell kernel what value to put in k0 before returning to the user space.
> It shouldn't be too hard to implement. I will try it next week.
> 
> 
> H.J.

Please don't use k1, we already use k1 to implement fast
test-and-set method for MIPS1 machine.  We plan to mereg
the method into main glibc and kernel tree.

You can use test-and-set without systemcall on MIPS1 machines using
this method. You can find the paper described about it in
	http://lc.linux.or.jp/lc2001/papers/tas-ps2-paper.pdf
	(sorry in japanese only)

The abstract of the paper attached below;

The Implementation of user level test-and-set on PS2 Linux In the
multi-thread environment like Linux, a fast user-level mutual
exclusion mechanism is strongly required. But MIPS chips designed
for embedded and single processor, like the Emotion Engine, have
no atomic test-and-set instruction. We implemented the fast
user-level mutual exclusion without invoking system-call and its
costs, on the PS2 Linux. This method utilizes the memory protection
facility of Operating System, to detect preemption and nullify the
operation. In this paper, we present the method and its evaluation. 


---
Hiroyuki Machida
Sony Corp.
