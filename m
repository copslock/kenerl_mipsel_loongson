Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 16:14:30 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:13797 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038960AbWIZPO2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2006 16:14:28 +0100
Received: from localhost (p5240-ipad201funabasi.chiba.ocn.ne.jp [222.146.68.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C2CBDA94E; Wed, 27 Sep 2006 00:14:22 +0900 (JST)
Date:	Wed, 27 Sep 2006 00:16:31 +0900 (JST)
Message-Id: <20060927.001631.78705973.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, mingo@redhat.com
Subject: Re: [PATCH 2/3] [MIPS] lockdep: add STACKTRACE_SUPPORT and enable
 LOCKDEP_SUPPORT
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060926.234401.08077257.anemo@mba.ocn.ne.jp>
References: <20060926.234401.08077257.anemo@mba.ocn.ne.jp>
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
X-archive-position: 12679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 26 Sep 2006 23:44:01 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Implement stacktrace interface by using unwind_stack().
> And enable lockdep support.

And I got this output when I booted kernel 2.6.18 using nfsroot:

--- snip ---
Mounting remote filesystems...

=======================================================
[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
mount/1381 is trying to acquire lock:
 (&mm->mmap_sem){----}, at: [<80032370>] do_page_fault+0xf0/0x3e0

but task is already holding lock:
 (sk_lock-AF_INET){--..}, at: [<802a55ac>] tcp_recvmsg+0x44/0x920

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sk_lock-AF_INET){--..}:
       [<80075ac0>] __lock_acquire+0xd7c/0xe98
       [<80076098>] lock_acquire+0xa4/0xf8
       [<8026a9ec>] lock_sock+0xec/0x11c
       [<802be8cc>] udp_sendmsg+0x20c/0x5cc
       [<802c772c>] inet_sendmsg+0x58/0x9c
       [<80267270>] sock_sendmsg+0xb0/0x104
       [<802672f0>] kernel_sendmsg+0x2c/0x48
       [<802e9924>] xs_udp_send_request+0x1d8/0x354
       [<802e65dc>] xprt_transmit+0x70/0x284
       [<802e3140>] call_transmit+0x204/0x2e4
       [<802eb16c>] __rpc_execute+0xa8/0x2bc
       [<802eb3e8>] rpc_execute+0x40/0x54
       [<8013434c>] nfs_execute_read+0x50/0x84
       [<80134c60>] nfs_pagein_one+0x2e4/0x388
       [<80134e18>] nfs_readpages+0x114/0x21c
       [<8008ce7c>] __do_page_cache_readahead+0x214/0x33c
       [<8008d550>] do_page_cache_readahead+0x6c/0x9c
       [<80087498>] filemap_nopage+0x178/0x560
       [<800953e4>] __handle_mm_fault+0x178/0xb70
       [<80032504>] do_page_fault+0x284/0x3e0
       [<800339c0>] tlb_do_page_fault_1+0x104/0x114

-> #0 (&mm->mmap_sem){----}:
       [<80075960>] __lock_acquire+0xc1c/0xe98
       [<80076098>] lock_acquire+0xa4/0xf8
       [<80070bb0>] down_read+0x38/0x58
       [<80032370>] do_page_fault+0xf0/0x3e0
       [<800339c0>] tlb_do_page_fault_1+0x104/0x114

other info that might help us debug this:

1 lock held by mount/1381:
 #0:  (sk_lock-AF_INET){--..}, at: [<802a55ac>] tcp_recvmsg+0x44/0x920

stack backtrace:
Call Trace:
[<8002de48>] dump_stack+0x10/0x44
[<80074d28>] print_circular_bug_tail+0x70/0x8c
[<80075960>] __lock_acquire+0xc1c/0xe98
[<80076098>] lock_acquire+0xa4/0xf8
[<80070bb0>] down_read+0x38/0x58
[<80032370>] do_page_fault+0xf0/0x3e0
[<800339c0>] tlb_do_page_fault_1+0x104/0x114
--- snip ---


I'm not familiar with lockdep output.  Is this a real dependency bug
or lack of annotation on somewhere, or something other ?

---
Atsushi Nemoto
