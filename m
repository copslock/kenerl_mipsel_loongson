Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2011 12:00:43 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:51137 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1490989Ab1EQKAj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 May 2011 12:00:39 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4HA1pe0015961;
        Tue, 17 May 2011 11:01:52 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4HA1nYA015960;
        Tue, 17 May 2011 11:01:49 +0100
Date:   Tue, 17 May 2011 11:01:49 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc: Add missing sys_ni entries for ipc/compat.c
 functions
Message-ID: <20110517100149.GA7516@linux-mips.org>
References: <cb0939f54999dd3754808f2c5fc1cf0f@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb0939f54999dd3754808f2c5fc1cf0f@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 13, 2011 at 05:07:28PM -0700, Kevin Cernekee wrote:
> Date:   Fri, 13 May 2011 17:07:28 -0700
> From: Kevin Cernekee <cernekee@gmail.com>
> To: Andrew Morton <akpm@linux-foundation.org>, Al Viro
>  <viro@zeniv.linux.org.uk>, Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
> Subject: [PATCH] ipc: Add missing sys_ni entries for ipc/compat.c functions
> Content-Type: text/plain; charset=us-ascii
> 
> When building with:
> 
> CONFIG_64BIT=y
> CONFIG_MIPS32_COMPAT=y
> CONFIG_COMPAT=y
> CONFIG_MIPS32_O32=y
> CONFIG_MIPS32_N32=y
> CONFIG_SYSVIPC is not set
> (and implicitly: CONFIG_SYSVIPC_COMPAT is not set)
> 
> the final link fails with unresolved symbols for:
> 
> compat_sys_semctl, compat_sys_msgsnd, compat_sys_msgrcv,
> compat_sys_shmctl, compat_sys_msgctl, compat_sys_semtimedop
> 
> The fix is to add cond_syscall declarations for all syscalls in
> ipc/compat.c
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks, Kevin!

  Ralf
