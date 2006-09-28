Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2006 11:26:43 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:61726 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038581AbWI1K0l (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Sep 2006 11:26:41 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 28 Sep 2006 19:26:39 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 4CAFD414F2;
	Thu, 28 Sep 2006 19:26:38 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 381823B72F;
	Thu, 28 Sep 2006 19:26:38 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k8SAQbW0075433;
	Thu, 28 Sep 2006 19:26:37 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 28 Sep 2006 19:26:37 +0900 (JST)
Message-Id: <20060928.192637.27955275.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, mingo@redhat.com
Subject: Re: [PATCH 2/3] [MIPS] lockdep: add STACKTRACE_SUPPORT and enable
 LOCKDEP_SUPPORT
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060927.001631.78705973.anemo@mba.ocn.ne.jp>
References: <20060926.234401.08077257.anemo@mba.ocn.ne.jp>
	<20060927.001631.78705973.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 27 Sep 2006 00:16:31 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> And I got this output when I booted kernel 2.6.18 using nfsroot:

With updated stacktrace (now it shows all kernel context), I got:

--- snip ---
Mounting remote filesystems...

=======================================================
[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
mount/1383 is trying to acquire lock:
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
       [<80025d00>] ret_from_exception+0x0/0x10
       [<80189af4>] __bzero+0x38/0x80
       [<800e5554>] padzero+0x6c/0x8c
       [<800e6eb8>] load_elf_binary+0x878/0x16d0
       [<800b8b08>] search_binary_handler+0xf8/0x450
       [<800baa90>] do_execve+0x13c/0x224
       [<8002b904>] sys_execve+0x54/0x88
       [<80030cc0>] stack_done+0x20/0x3c

-> #0 (&mm->mmap_sem){----}:
       [<80075960>] __lock_acquire+0xc1c/0xe98
       [<80076098>] lock_acquire+0xa4/0xf8
       [<80070bb0>] down_read+0x38/0x58
       [<80032370>] do_page_fault+0xf0/0x3e0
       [<80025d00>] ret_from_exception+0x0/0x10
       [<8018910c>] both_aligned+0x2c/0x64
       [<802712b4>] memcpy_toiovec+0x8c/0xbc
       [<80271d74>] skb_copy_datagram_iovec+0x208/0x2a4
       [<802a5bdc>] tcp_recvmsg+0x674/0x920
       [<80269e5c>] sock_common_recvmsg+0x4c/0x70
       [<80266a58>] do_sock_read+0xb0/0xd8
       [<80267668>] sock_aio_read+0x80/0x88
       [<800a8bfc>] do_sync_read+0xe4/0x14c
       [<800a99f4>] vfs_read+0x1a8/0x1b0
       [<800a9f9c>] sys_read+0x5c/0xb0
       [<80030cc0>] stack_done+0x20/0x3c

other info that might help us debug this:

1 lock held by mount/1383:
 #0:  (sk_lock-AF_INET){--..}, at: [<802a55ac>] tcp_recvmsg+0x44/0x920

stack backtrace:
Call Trace:
[<8002de48>] dump_stack+0x10/0x44
[<80074d28>] print_circular_bug_tail+0x70/0x8c
[<80075960>] __lock_acquire+0xc1c/0xe98
[<80076098>] lock_acquire+0xa4/0xf8
[<80070bb0>] down_read+0x38/0x58
[<80032370>] do_page_fault+0xf0/0x3e0
[<80025d00>] ret_from_exception+0x0/0x10

--- snip ---


Does this output say socket I/O and a page-fault on NFS can cause a
deadlock?

---
Atsushi Nemoto
