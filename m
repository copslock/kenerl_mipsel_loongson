Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jun 2011 21:22:02 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:21206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491190Ab1FHTVz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Jun 2011 21:21:55 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p58JKnLT020232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 8 Jun 2011 15:20:50 -0400
Received: from tranklukator.englab.brq.redhat.com (dhcp-1-166.brq.redhat.com [10.34.1.166])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id p58JKfox006474;
        Wed, 8 Jun 2011 15:20:41 -0400
Received: by tranklukator.englab.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Wed,  8 Jun 2011 21:19:18 +0200 (CEST)
Date:   Wed, 8 Jun 2011 21:19:10 +0200
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
Message-ID: <20110608191910.GA18698@redhat.com>
References: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com> <20110607171952.GA25729@redhat.com> <1307472796.2052.12.camel@localhost.localdomain> <20110608163653.GA9592@redhat.com> <1307556823.2577.5.camel@localhost.localdomain> <20110608183720.GA16883@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110608183720.GA16883@redhat.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-archive-position: 30301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oleg@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7122

On 06/08, Oleg Nesterov wrote:
>
> OK. Thanks a lot Eric for your explanations.

Yes. but may I ask another one?

Shouldn't copy_process()->audit_alloc(tsk) path do
clear_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT) if it doesn't
set tsk->audit_context?

I can be easily wrong, but afaics otherwise the child can run
with TIF_SYSCALL_AUDIT bit copied from parent's thread_info by
dup_task_struct()->setup_thread_stack() and without ->audit_context,
right? For what?

Any other reason why audit_syscall_entry() checks context != NULL?

IOW. Any reason the patch below is wrong?

I am just curious, thanks.

Oleg.

--- x/kernel/auditsc.c
+++ x/kernel/auditsc.c
@@ -885,6 +885,8 @@ int audit_alloc(struct task_struct *tsk)
 	if (likely(!audit_ever_enabled))
 		return 0; /* Return if not auditing. */
 
+	clear_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
+
 	state = audit_filter_task(tsk, &key);
 	if (likely(state == AUDIT_DISABLED))
 		return 0;
@@ -1591,9 +1593,7 @@ void audit_syscall_entry(int arch, int m
 	struct audit_context *context = tsk->audit_context;
 	enum audit_state     state;
 
-	if (unlikely(!context))
-		return;
-
+	BUG_ON(!context);
 	/*
 	 * This happens only on certain architectures that make system
 	 * calls in kernel_thread via the entry.S interface, instead of
