Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0KEGJp25267
	for linux-mips-outgoing; Sun, 20 Jan 2002 06:16:19 -0800
Received: from ns5.sony.co.jp (NS5.Sony.CO.JP [146.215.0.105])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0KEGDP25264
	for <linux-mips@oss.sgi.com>; Sun, 20 Jan 2002 06:16:14 -0800
Received: from mail2.sony.co.jp (GateKeeper11.Sony.CO.JP [146.215.0.74])
	by ns5.sony.co.jp (R8/Sony) with ESMTP id g0KDG8L00886;
	Sun, 20 Jan 2002 22:16:08 +0900 (JST)
Received: from mail2.sony.co.jp (localhost [127.0.0.1])
	by mail2.sony.co.jp (R8) with ESMTP id g0KDG8H22182;
	Sun, 20 Jan 2002 22:16:08 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail2.sony.co.jp (R8) with ESMTP id g0KDG7A22178;
	Sun, 20 Jan 2002 22:16:08 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.2.217.16]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id WAA14993; Sun, 20 Jan 2002 22:20:55 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.2.226.27]) by imail.sm.sony.co.jp (8.9.3+3.2W/3.7W) with ESMTP id WAA20801; Sun, 20 Jan 2002 22:16:07 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.11.0/8.11.0) with ESMTP id g0KDG7J00815; Sun, 20 Jan 2002 22:16:07 +0900 (JST)
To: kevink@mips.com
Cc: hjl@lucon.org, drepper@redhat.com, libc-hacker@sources.redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
In-Reply-To: <002c01c1a1a9$b9f0de40$0deca8c0@Ulysses>
References: <20020118201139.A847@lucon.org>
	<20020120193843M.machida@sm.sony.co.jp>
	<002c01c1a1a9$b9f0de40$0deca8c0@Ulysses>
X-Mailer: Mew version 1.94.2 on Emacs 19.28 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020120221607T.machida@sm.sony.co.jp>
Date: Sun, 20 Jan 2002 22:16:07 +0900
From: Machida Hiroyuki <machida@sm.sony.co.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



From: "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: thread-ready ABIs
Date: Sun, 20 Jan 2002 12:58:00 +0100

> I don't read Japanese, but I've worked on similar
> methods for semaphores using k1, so I can guess
> roughly what you've done.   We'll have to be very
> careful if we want to have both a thread-register
> extended ABI *and* this approach to semaphores.
> The TLB miss handler must inevitably destroy one
> or the other of k0/k1, though it can avoid destroying
> both.  Thus the merge of thread-register+semaphore
> must not require that both be preserved on an
> arbitrary memory reference.  That may or may not
> be possible, so it would be good if you guys at
> Sony could post your code ASAP so we can see
> what can and cannot be merged.

We released source codes to the public with PS2 Linux (beta
version) DISC. But I think you can't get the DISC in outside of
japan. Patches included in those SRPMs are not separeted by
function. That meanes single big patche includes r5900 porting
codes, r5900 specific devices drivers and other enhancements. 
I can put kernel and glibc SRPMs in that DISC to you ftp site, if
you really want to get SRPMs with such a dirty patch.
Please send me your ftp site and how to put, if you want to SRPMs.

I'll write short descriptions about what our test-and-set does,
and try to make a separate patch for the method, anyway.


> This situation also behooves us to verify that
> k0/k1 are really and truly the only candidates
> for a thread register in MIPS.  I haven't been
	<snip>

Sorry, I don't read libc-hackers's archives yet...

---
Hiroyuki Machida
Sony Corp.
