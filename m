Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 10:32:19 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:27483 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038463AbWI2JcR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Sep 2006 10:32:17 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 29 Sep 2006 18:32:15 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 76A4041500;
	Fri, 29 Sep 2006 18:32:13 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 632BE41331;
	Fri, 29 Sep 2006 18:32:13 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k8T9WCW0080118;
	Fri, 29 Sep 2006 18:32:13 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 29 Sep 2006 18:32:12 +0900 (JST)
Message-Id: <20060929.183212.45177847.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, mingo@redhat.com
Subject: Re: [PATCH 2/3] [MIPS] lockdep: add STACKTRACE_SUPPORT and enable
 LOCKDEP_SUPPORT
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060928104247.GA3857@linux-mips.org>
References: <20060927.001631.78705973.anemo@mba.ocn.ne.jp>
	<20060928.192637.27955275.nemoto@toshiba-tops.co.jp>
	<20060928104247.GA3857@linux-mips.org>
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
X-archive-position: 12732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 28 Sep 2006 11:42:47 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > > And I got this output when I booted kernel 2.6.18 using nfsroot:
> > 
> > With updated stacktrace (now it shows all kernel context), I got:
> 
> Thanks.  Now the lockdep output makes sense.  At a glance it also looks
> like this case isn't a false positive ...

And here is a updated lockdep output with "nfsroot=host:dir,tcp"
option.  In previous output, I used NFS over TCP but not specified
",tcp" on nfsroot.

Also I found this happens only NFS over TCP on Debian 3.1 (sarge).  If
I used NFS over UDP or Debian 4.0 (etch), lockdep does not show
anything.  I can not tell why the version of Debian affect this...


--- snip ---
Mounting remote filesystems...

=======================================================
[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
mount/1425 is trying to acquire lock:
 (&mm->mmap_sem){----}, at: [<80031b70>] do_page_fault+0xf0/0x3c0

but task is already holding lock:
 (sk_lock-AF_INET){--..}, at: [<802a7170>] tcp_recvmsg+0x44/0x920

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sk_lock-AF_INET){--..}:
       [<8007383c>] __lock_acquire+0xd80/0xe9c
       [<80073e14>] lock_acquire+0xa4/0xf8
       [<8026bc98>] lock_sock+0xec/0x11c
       [<802a62f8>] tcp_sendmsg+0x40/0xc60
       [<802c9194>] inet_sendmsg+0x58/0x9c
       [<8026858c>] sock_sendmsg+0xb0/0x104
       [<8026860c>] kernel_sendmsg+0x2c/0x48
       [<802ebd70>] xs_tcp_send_request+0x134/0x3f8
       [<802ea408>] xprt_transmit+0x70/0x284
       [<802e70b0>] call_transmit+0x1fc/0x2dc
       [<802ef194>] __rpc_execute+0xa8/0x2bc
       [<802ef410>] rpc_execute+0x40/0x54
       [<8013411c>] nfs_execute_read+0x50/0x84
       [<80134a64>] nfs_pagein_one+0x2e4/0x388
       [<80134ec0>] nfs_readpages+0x128/0x230
       [<8008a2b4>] __do_page_cache_readahead+0x20c/0x328
       [<8008a97c>] do_page_cache_readahead+0x6c/0x9c
       [<800848e8>] filemap_nopage+0x17c/0x564
       [<8009285c>] __handle_mm_fault+0x178/0xc18
       [<80031d00>] do_page_fault+0x280/0x3c0
       [<80025c00>] ret_from_exception+0x0/0x10
       [<8018b7b4>] __bzero+0x38/0x80
       [<800e2e24>] padzero+0x6c/0x8c
       [<800e4864>] load_elf_binary+0x8ac/0x16e8
       [<800b61c8>] search_binary_handler+0xe8/0x420
       [<800b805c>] do_execve+0x13c/0x224
       [<8002b554>] sys_execve+0x54/0x88
       [<80030780>] stack_done+0x20/0x3c

-> #0 (&mm->mmap_sem){----}:
       [<800736dc>] __lock_acquire+0xc20/0xe9c
       [<80073e14>] lock_acquire+0xa4/0xf8
       [<8006e930>] down_read+0x38/0x58
       [<80031b70>] do_page_fault+0xf0/0x3c0
       [<80025c00>] ret_from_exception+0x0/0x10
       [<8018adcc>] both_aligned+0x2c/0x64
       [<80272504>] memcpy_toiovec+0x8c/0xbc
       [<80272fc4>] skb_copy_datagram_iovec+0x208/0x2a4
       [<802a77a0>] tcp_recvmsg+0x674/0x920
       [<8026b0dc>] sock_common_recvmsg+0x4c/0x70
       [<80267a88>] do_sock_read+0xb0/0xd8
       [<80268984>] sock_aio_read+0x80/0x88
       [<800a633c>] do_sync_read+0xe4/0x14c
       [<800a7134>] vfs_read+0x1a8/0x1b0
       [<800a76e0>] sys_read+0x5c/0xb0
       [<80030780>] stack_done+0x20/0x3c

other info that might help us debug this:

1 lock held by mount/1425:
 #0:  (sk_lock-AF_INET){--..}, at: [<802a7170>] tcp_recvmsg+0x44/0x920

stack backtrace:
Call Trace:
[<8002da54>] dump_stack+0x10/0x44
[<80072aa0>] print_circular_bug_tail+0x70/0x8c
[<800736dc>] __lock_acquire+0xc20/0xe9c
[<80073e14>] lock_acquire+0xa4/0xf8
[<8006e930>] down_read+0x38/0x58
[<80031b70>] do_page_fault+0xf0/0x3c0
[<80025c00>] ret_from_exception+0x0/0x10
[<8018adcc>] both_aligned+0x2c/0x64
[<80272504>] memcpy_toiovec+0x8c/0xbc
[<80272fc4>] skb_copy_datagram_iovec+0x208/0x2a4
[<802a77a0>] tcp_recvmsg+0x674/0x920
[<8026b0dc>] sock_common_recvmsg+0x4c/0x70
[<80267a88>] do_sock_read+0xb0/0xd8
[<80268984>] sock_aio_read+0x80/0x88
[<800a633c>] do_sync_read+0xe4/0x14c
[<800a7134>] vfs_read+0x1a8/0x1b0
[<800a76e0>] sys_read+0x5c/0xb0
[<80030780>] stack_done+0x20/0x3c
--- snip ---


Any idea?

---
Atsushi Nemoto
