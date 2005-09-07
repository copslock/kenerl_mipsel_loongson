Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2005 15:36:19 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:3067 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225264AbVIGOgE>; Wed, 7 Sep 2005 15:36:04 +0100
Received: from localhost (p5166-ipad204funabasi.chiba.ocn.ne.jp [222.146.92.166])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CA8C28640; Wed,  7 Sep 2005 23:43:01 +0900 (JST)
Date:	Wed, 07 Sep 2005 23:44:13 +0900 (JST)
Message-Id: <20050907.234413.108737010.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: unkillable process due to setup_frame() failure
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050907134717.GA3493@linux-mips.org>
References: <20050906184118.GC3102@linux-mips.org>
	<Pine.LNX.4.61L.0509071011560.4591@blysk.ds.pg.gda.pl>
	<20050907134717.GA3493@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 7 Sep 2005 14:47:17 +0100, Ralf Baechle <ralf@linux-mips.org> said:

ralf> That said, I definately prefer the approach of Atushi's
ralf> suggested fix #2.  The other question is why we try to continue
ralf> if delivering a signal failed and we already know that repeated
ralf> attempts would fail again.

The question is for my fix #1 ?

Well, let me explain more.  With that fix, things will go like this:

1.  The "break" instruction raises a exception.
2.  The exception handler queues SIGTRAP(5).
3.  dequeue_signal() dequeue a signal with LOWEST number (i.e. SIGTRAP).
4.  setup_frame() fails due to bad stack pointer and queues SIGSEGV(11).
5.  do_signal() called again (by fix #1)
6.  dequeue_signal() dequeue a signal (i.e. SIGSEGV).
7.  If SIGSEGV did not have a signal handler, default action (coredump
    and exit) is taken.  End.
8.  If SIGSEGV had a signal handler, setup_frame() fails and queues
    SIGSEGV again.  It resets SIGSEGV's handler to SIG_DFL.
9.  returns to user process (pc unchanged).
10.  goto 1.  Then ended at 7.

My fix #2 is more generic approach, but even with the fix, the test
program eats CPU until killed by SIGKILL.  With my fix #1, the test
program will exit immediately.  

So my "which is preferred" question was inappropriate.  I had to ask
"#1 or #2 or both or other ?"

---
Atsushi Nemoto
