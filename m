Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jun 2011 18:39:41 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:64916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491132Ab1FHQjf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Jun 2011 18:39:35 +0200
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p58GcWWe021318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 8 Jun 2011 12:38:32 -0400
Received: from tranklukator.englab.brq.redhat.com (dhcp-1-166.brq.redhat.com [10.34.1.166])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id p58GcODo008729;
        Wed, 8 Jun 2011 12:38:24 -0400
Received: by tranklukator.englab.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Wed,  8 Jun 2011 18:37:01 +0200 (CEST)
Date:   Wed, 8 Jun 2011 18:36:53 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Eric Paris <eparis@redhat.com>
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
Subject: Re: [PATCH -v2] Audit: push audit success and retcode into arch
        ptrace.h
Message-ID: <20110608163653.GA9592@redhat.com>
References: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com> <20110607171952.GA25729@redhat.com> <1307472796.2052.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1307472796.2052.12.camel@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
X-archive-position: 30298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oleg@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6996

On 06/07, Eric Paris wrote:
>
> On Tue, 2011-06-07 at 19:19 +0200, Oleg Nesterov wrote:
> >
> > With or without this patch, can't we call audit_syscall_exit() twice
> > if there is something else in _TIF_WORK_SYSCALL_EXIT mask apart from
> > SYSCALL_AUDIT ? First time it is called from asm, then from
> > syscall_trace_leave(), no?
> >
> > For example. The task has TIF_SYSCALL_AUDIT and nothing else, it does
> > system_call->auditsys->system_call_fastpath. What if it gets, say,
> > TIF_SYSCALL_TRACE before ret_from_sys_call?
>
> No harm is done calling twice.  The first call will do the real work and
> cleanup.  It will set a flag in the audit data that the work has been
> done (in_syscall == 0) thus the second call will then not do any real
> work and won't have anything to clean up.

Hmm... and I assume context->previous != NULL is not possible on x86_64.
OK, thanks.

And I guess, all CONFIG_AUDITSYSCALL code in entry.S is only needed to
microoptimize the case when TIF_SYSCALL_AUDIT is the only reason for the
slow path. I wonder if it really makes the measureble difference...

Oleg.
