Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Sep 2002 21:06:17 +0200 (CEST)
Received: from p508B6B85.dip.t-dialin.net ([80.139.107.133]:46976 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122961AbSIOTGQ>; Sun, 15 Sep 2002 21:06:16 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g8FJ62b24844;
	Sun, 15 Sep 2002 21:06:02 +0200
Date: Sun, 15 Sep 2002 21:06:01 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Ryan Murray <rmurray@debian.org>
Cc: linux-mips@linux-mips.org, libc-alpha@sources.redhat.com
Subject: Re: [patch] userspace mcontext_t doesn't match what kernel returns
Message-ID: <20020915210601.A24588@linux-mips.org>
References: <20020911032832.GA1500@cyberhqz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020911032832.GA1500@cyberhqz.com>; from rmurray@debian.org on Tue, Sep 10, 2002 at 08:28:32PM -0700
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 10, 2002 at 08:28:32PM -0700, Ryan Murray wrote:

> The definition of mcontext_t in sysdeps/unix/sysv/linux/mips/sys/ucontext.h
> does not match what the kernel copies to userspace (struct sigcontext).
> alpha, ia64, and hppa have fixed this by typedefing one to the other in
> sys/ucontext.h  The following patch accomplishes the same thing for mips.

I choose to fix the kernel instead which will keep as closer to the MIPS
ABI and also prevent having to recompile zillions of user apps.  Below my
working version of <asm/ucontext.h>.

  Ralf

/*
 * This file is subject to the terms and conditions of the GNU General Public
 * License.  See the file "COPYING" in the main directory of this archive
 * for more details.
 *
 * Low level exception handling
 *
 * Copyright (C) 1998, 1999 by Ralf Baechle
 */
#ifndef _ASM_UCONTEXT_H
#define _ASM_UCONTEXT_H

typedef struct {
	gregset_t gregs;
	fpregset_t fpregs;
} mcontext_t;

struct ucontext {
	unsigned long	uc_flags;
	struct ucontext	*uc_link;
	stack_t		uc_stack;
	mcontext_t	uc_mcontext;
	sigset_t	uc_sigmask;	/* mask last for extensibility */
};

#endif /* _ASM_UCONTEXT_H */
