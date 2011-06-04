Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jun 2011 00:39:37 +0200 (CEST)
Received: from a.ns.miles-group.at ([95.130.255.143]:33623 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491870Ab1FDWjc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 5 Jun 2011 00:39:32 +0200
Received: (qmail 31674 invoked by uid 89); 4 Jun 2011 22:39:26 -0000
Received: by simscan 1.3.1 ppid: 31652, pid: 31670, t: 0.1799s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:53
Received: from unknown (HELO raccoon.localnet) (richard@nod.at@212.183.99.133)
  by radon.swed.at with ESMTPA; 4 Jun 2011 22:39:26 -0000
From:   Richard Weinberger <richard@nod.at>
To:     Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH -v2] Audit: push audit success and retcode into arch ptrace.h
Date:   Sun, 5 Jun 2011 00:36:44 +0200
User-Agent: KMail/1.13.7 (Linux/2.6.37.6-0.5-desktop; KDE/4.6.3; x86_64; ; )
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com,
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
References: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
In-Reply-To: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201106050036.44852.richard@nod.at>
X-archive-position: 30213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@nod.at
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3354

Am Samstag 04 Juni 2011, 00:04:51 schrieb Eric Paris:
> The audit system previously expected arches calling to audit_syscall_exit
> to supply as arguments if the syscall was a success and what the return
> code was. Audit also provides a helper AUDITSC_RESULT which was supposed
> to simplify things by converting from negative retcodes to an audit
> internal magic value stating success or failure.  This helper was wrong
> and could indicate that a valid pointer returned to userspace was a failed
> syscall.  The fix is to fix the layering foolishness.  We now pass
> audit_syscall_exit a struct pt_reg and it in turns calls back into arch
> code to collect the return value and to determine if the syscall was a
> success or failure.  We also define a generic is_syscall_success() macro
> which determines success/failure based on if the value is < -MAX_ERRNO. 
> This works for arches like x86 which do not use a separate mechanism to
> indicate syscall failure.
> 
> In arch/sh/kernel/ptrace_64.c I see that we were using regs[9] in the old
> audit code as the return value.  But the ptrace_64.h code defined the macro
> regs_return_value() as regs[3].  I have no idea which one is correct, but
> this patch now uses the regs_return_value() function, so it now uses
> regs[3].
> 
> We make both the is_syscall_success() and regs_return_value() static
> inlines instead of macros.  The reason is because the audit function must
> take a void* for the regs.  (uml calls theirs struct uml_pt_regs instead
> of just struct pt_regs so audit_syscall_exit can't take a struct pt_regs).
>  Since the audit function takes a void* we need to use static inlines to
> cast it back to the arch correct structure to dereference it.
> 
> The other major change is that on some arches, like ia64, we change
> regs_return_value() to give us the negative value on syscall failure.  The
> only other user of this macro, kretprobe_example.c, won't notice and it
> makes the value signed consistently for the audit functions across all
> archs.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> Acked-by: Acked-by: H. Peter Anvin <hpa@zytor.com> [for x86 portion]

The UML part is now fine for me. :-)

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
