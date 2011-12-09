Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2011 22:49:10 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:44670 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903738Ab1LIVtC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Dec 2011 22:49:02 +0100
Received: from akpm.mtv.corp.google.com (216-239-45-4.google.com [216.239.45.4])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4E71441;
        Fri,  9 Dec 2011 21:48:06 +0000 (UTC)
Date:   Fri, 9 Dec 2011 13:48:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chris Metcalf <cmetcalf@tilera.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christoph Hellwig <hch@lst.de>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "J. Bruce Fields" <bfields@redhat.com>, NeilBrown <neilb@suse.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v2] ipc: provide generic compat versions of IPC syscalls
Message-Id: <20111209134852.f5b5bcbc.akpm@linux-foundation.org>
In-Reply-To: <201112091903.pB9J39pd031553@farm-0002.internal.tilera.com>
References: <201112091536.pB9Fa5f7002738@farm-0002.internal.tilera.com>
        <201112091602.31325.arnd@arndb.de>
        <201112091903.pB9J39pd031553@farm-0002.internal.tilera.com>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 32078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8102

On Fri, 9 Dec 2011 10:29:07 -0500
Chris Metcalf <cmetcalf@tilera.com> wrote:

> When using the "compat" APIs, architectures will generally want to
> be able to make direct syscalls to msgsnd(), shmctl(), etc., and
> in the kernel we would want them to be handled directly by
> compat_sys_xxx() functions, as is true for other compat syscalls.
> 
> However, for historical reasons, several of the existing compat IPC
> syscalls do not do this.  semctl() expects a pointer to the fourth
> argument, instead of the fourth argument itself.  msgsnd(), msgrcv()
> and shmat() expect arguments in different order.
> 
> This change adds an __ARCH_WANT_OLD_COMPAT_IPC define that can be
> set in <asm/compat.h> to preserve this behavior for ports that use it
> (x86, sparc, powerpc, s390, and mips).  No actual semantics are changed
> for those architectures, and there is only a minimal amount of code
> refactoring in ipc/compat.c.
> 
> Newer architectures like tile (and perhaps future architectures such
> as arm64 and unicore64) should not supply this define, and thus can
> avoid having any IPC-specific code at all in their architecture-specific
> compat layer.  In the same vein, if this define is omitted, IPC_64 mode
> is assumed, since that's what the <asm-generic> headers expect.
> 
> The workaround code in "tile" for msgsnd() and msgrcv() is removed
> with this change; it also fixes the bug that shmat() and semctl() were
> not being properly handled.

What would we need to do to get all architectures using the new
interfaces, and remove __ARCH_WANT_OLD_COMPAT_IPC?

Regarding the implementation: rather than patching the header
files, it would be more conventional (and arguably better) to add

	select ARCH_WANT_OLD_COMPAT_IPC

to arch/*/Kconfig, then use CONFIG_ARCH_WANT_OLD_COMPAT_IPC.
