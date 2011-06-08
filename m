Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jun 2011 20:14:47 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:42380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491149Ab1FHSOk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Jun 2011 20:14:40 +0200
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p58IDh8F024570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 8 Jun 2011 14:13:43 -0400
Received: from [10.11.235.183] (dhcp235-183.rdu.redhat.com [10.11.235.183])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p58IDaO1009617;
        Wed, 8 Jun 2011 14:13:37 -0400
Subject: Re: [PATCH -v2] Audit: push audit success and retcode into arch
 ptrace.h
From:   Eric Paris <eparis@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com,
        fenghua.yu@intel.com, monstr@monstr.eu, ralf@linux-mips.org,
        benh@kernel.crashing.org, paulus@samba.org, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, linux390@de.ibm.com,
        lethal@linux-sh.org, davem@davemloft.net, jdike@addtoit.com,
        richard@nod.at, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-ia64@vger.kernel.org,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Date:   Wed, 08 Jun 2011 14:13:36 -0400
In-Reply-To: <20110608163653.GA9592@redhat.com>
References: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
         <20110607171952.GA25729@redhat.com>
         <1307472796.2052.12.camel@localhost.localdomain>
         <20110608163653.GA9592@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Message-ID: <1307556823.2577.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
X-archive-position: 30299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eparis@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7070

On Wed, 2011-06-08 at 18:36 +0200, Oleg Nesterov wrote:
> On 06/07, Eric Paris wrote:
> >
> > On Tue, 2011-06-07 at 19:19 +0200, Oleg Nesterov wrote:
> > >
> > > With or without this patch, can't we call audit_syscall_exit() twice
> > > if there is something else in _TIF_WORK_SYSCALL_EXIT mask apart from
> > > SYSCALL_AUDIT ? First time it is called from asm, then from
> > > syscall_trace_leave(), no?
> > >
> > > For example. The task has TIF_SYSCALL_AUDIT and nothing else, it does
> > > system_call->auditsys->system_call_fastpath. What if it gets, say,
> > > TIF_SYSCALL_TRACE before ret_from_sys_call?
> >
> > No harm is done calling twice.  The first call will do the real work and
> > cleanup.  It will set a flag in the audit data that the work has been
> > done (in_syscall == 0) thus the second call will then not do any real
> > work and won't have anything to clean up.
> 
> Hmm... and I assume context->previous != NULL is not possible on x86_64.
> OK, thanks.
> 
> And I guess, all CONFIG_AUDITSYSCALL code in entry.S is only needed to
> microoptimize the case when TIF_SYSCALL_AUDIT is the only reason for the
> slow path. I wonder if it really makes the measureble difference...

All I know is what Roland put in the changelog:

Avoiding the iret return path when syscall audit is enabled helps
performance a lot.

I believe this was a result of Fedora starting auditd by default and
then Linus bitching about how slow a null syscall in a tight loop was.
It was an optimization for a microbenchmark.  How much it affects things
on a real syscall that does real work is probably going to be determined
by how much work is done in the syscall.  (or just disable auditd in
userspace)

-Eric
