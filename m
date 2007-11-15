Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2007 00:49:26 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:48090 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20031102AbXKOAtY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Nov 2007 00:49:24 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAF0mMR9032364;
	Thu, 15 Nov 2007 00:48:47 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAF0mLLw032363;
	Thu, 15 Nov 2007 00:48:21 GMT
Date:	Thu, 15 Nov 2007 00:48:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kaz Kylheku <kaz@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: "exportfs -a" -> stale NFS filehandle
Message-ID: <20071115004821.GA32332@linux-mips.org>
References: <DDFD17CC94A9BD49A82147DDF7D545C547AF5B@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C547AF5B@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 14, 2007 at 03:19:43PM -0800, Kaz Kylheku wrote:

> I have an NFS problem on a multi-node MIPS system running kernel
> 2.6.17.7. NFS utils is 1.1.0. ABI is n32.
> 
> One node (call it primary) exports a directory which is mounted by
> several others (the secondaries) as their root filesystem.
> 
> If I run "exportfs -a" on the primary, the secondary nodes lose their
> root filesystem and so everything stops working.
> 
> I turned on all NFS debugging on a secondary node (sysctl -w
> sunrpc.nfs_debug=65535). What is happening is that NFS operations
> suddenly start returning error -151 (stale NFS filehandle).
> 
> I don't see exportfs causing this problem on other systems. If I run
> "exportfs -a" on a big NFS server (Fedora Core 5, i686) which has lots
> of diskless clients, nothing bad happens. (And some of those diskless
> clients are MIPS systems just like this one!)
> 
> I'm pretty sure that exportfs -a shouldn't screw up the existing mounted
> clients.
> 
> Could there be some ABI problem that corrupts up the effect of the
> re-exporting operation on the server?

Can you test below patch?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 118be24..01993ec 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -293,7 +293,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_ni_syscall			/* 6170, was get_kernel_syms */
 	PTR	sys_ni_syscall			/* was query_module */
 	PTR	sys_quotactl
-	PTR	sys_nfsservctl
+	PTR	compat_sys_nfsservctl
 	PTR	sys_ni_syscall			/* res. for getpmsg */
 	PTR	sys_ni_syscall			/* 6175  for putpmsg */
 	PTR	sys_ni_syscall			/* res. for afs_syscall */
