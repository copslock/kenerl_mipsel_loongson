Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2011 22:35:00 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.17.10]:57906 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491129Ab1ETUey (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 May 2011 22:34:54 +0200
Received: from wuerfel.localnet (port-92-200-12-60.dynamic.qsc.de [92.200.12.60])
        by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
        id 0Lx7s1-1PdQ8F2tTd-016dQG; Fri, 20 May 2011 22:34:46 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH resend] ipc: Add missing sys_ni entries for ipc/compat.c functions
Date:   Fri, 20 May 2011 22:34:44 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.39-rc4+; KDE/4.5.1; x86_64; ; )
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <5a124a3b070fd1dc1f28d72e78e72534@localhost>
In-Reply-To: <5a124a3b070fd1dc1f28d72e78e72534@localhost>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201105202234.44260.arnd@arndb.de>
X-Provags-ID: V02:K0:fW7eRvK1TQgxTLZDEN7dX4wtJ7GADnO9/nGyEmFb1sl
 qpChrNt1Nuxp6Xo9ZGY7x+FCXEuFeXrMTTMsSrd1NKNKxIRxe5
 4UFzekUcpg1PNzSWvFVZbWQh7N0B1ihffUHW1Tl6M4iJ+FWbZf
 6WjvE8S8OUTReFyvVEapSBcaZc4hbeC3p8hH7pTUQHuFJ9ZTZ+
 MS3etcO4WTHGZCmJpYBhw==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips

On Tuesday 17 May 2011 19:39:58 Kevin Cernekee wrote:
> the final link fails with unresolved symbols for:
> 
> compat_sys_semctl, compat_sys_msgsnd, compat_sys_msgrcv,
> compat_sys_shmctl, compat_sys_msgctl, compat_sys_semtimedop
> 
> The fix is to add cond_syscall declarations for all syscalls in
> ipc/compat.c
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Arnd Bergmann <arnd@arndb.de>
