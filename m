Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2011 01:06:17 +0200 (CEST)
Received: from a.ns.miles-group.at ([95.130.255.143]:51100 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491867Ab1FBXGM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jun 2011 01:06:12 +0200
Received: (qmail 6862 invoked by uid 89); 2 Jun 2011 23:06:06 -0000
Received: by simscan 1.3.1 ppid: 6855, pid: 6858, t: 0.1563s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:53
Received: from unknown (HELO raccoon.localnet) (richard@nod.at@212.183.97.123)
  by radon.swed.at with ESMTPA; 2 Jun 2011 23:06:06 -0000
From:   Richard Weinberger <richard@nod.at>
To:     Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] Audit: push audit success and retcode into arch ptrace.h
Date:   Fri, 3 Jun 2011 01:03:46 +0200
User-Agent: KMail/1.13.7 (Linux/2.6.37.6-0.5-desktop; KDE/4.6.3; x86_64; ; )
Cc:     Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, monstr@monstr.eu, ralf@linux-mips.org,
        benh@kernel.crashing.org, paulus@samba.org, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, linux390@de.ibm.com,
        lethal@linux-sh.org, davem@davemloft.net, jdike@addtoit.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, viro@zeniv.linux.org.uk, oleg@redhat.com,
        akpm@linux-foundation.org, linux-ia64@vger.kernel.org,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
References: <20110602210458.23613.24076.stgit@paris.rdu.redhat.com> <201106030032.17398.richard@nod.at> <BANLkTik9kCs_06=7HKo44cWqpS0zB9fr+A@mail.gmail.com>
In-Reply-To: <BANLkTik9kCs_06=7HKo44cWqpS0zB9fr+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 8BIT
Message-Id: <201106030103.46742.richard@nod.at>
X-archive-position: 30201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@nod.at
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2196

Am Freitag 03 Juni 2011, 01:00:51 schrieb Tony Luck:
> > But there seems to be another problem.
> > Why is pt_regs of type void *?
> > 
> > gcc complains:
> > In file included from include/linux/fsnotify.h:15:0,
> >                 from include/linux/security.h:26,
> >                 from init/main.c:32:
> > include/linux/audit.h: In function ‘audit_syscall_exit’:
> > include/linux/audit.h:440:17: warning: dereferencing ‘void *’ pointer
> > include/linux/audit.h:440:3: error: invalid use of void expression
> > include/linux/audit.h:441:21: warning: dereferencing ‘void *’ pointer
> > include/linux/audit.h:441:21: error: void value not ignored as it ought
> > to be
> 
> Perhaps same issue on ia64 - but symptoms are different:

The void * pointer is the problem.
On UML it builds fine when I cast it:
#define regs_return_value(r) UPT_SYSCALL_RET((struct uml_pt_regs *)r)

I'll test it tomorrow in detail, for now I'm too sleepy.

Thanks,
//richard
