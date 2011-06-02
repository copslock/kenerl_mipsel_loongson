Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2011 23:19:40 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:49857 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491860Ab1FBVTf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Jun 2011 23:19:35 +0200
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
        (authenticated bits=0)
        by mail.zytor.com (8.14.4/8.14.4) with ESMTP id p52LIYOU019153
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Thu, 2 Jun 2011 14:18:35 -0700
Message-ID: <4DE7FE2A.10107@zytor.com>
Date:   Thu, 02 Jun 2011 14:18:34 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Eric Paris <eparis@redhat.com>
CC:     linux-kernel@vger.kernel.org, tony.luck@intel.com,
        fenghua.yu@intel.com, monstr@monstr.eu, ralf@linux-mips.org,
        benh@kernel.crashing.org, paulus@samba.org, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, linux390@de.ibm.com,
        lethal@linux-sh.org, davem@davemloft.net, jdike@addtoit.com,
        richard@nod.at, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, viro@zeniv.linux.org.uk, oleg@redhat.com,
        akpm@linux-foundation.org, linux-ia64@vger.kernel.org,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH] Audit: push audit success and retcode into arch ptrace.h
References: <20110602210458.23613.24076.stgit@paris.rdu.redhat.com>
In-Reply-To: <20110602210458.23613.24076.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 30198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2126

On 06/02/2011 02:04 PM, Eric Paris wrote:
> The audit system previously expected arches calling to audit_syscall_exit to
> supply as arguments if the syscall was a success and what the return code was.
> Audit also provides a helper AUDITSC_RESULT which was supposed to simplify by
> converting from negative retcodes to an audit internal magic value stating
> success or failure.  This helper was wrong and could indicate that a valid
> pointer returned to userspace was a failed syscall.  The fix is to fix the
> layering foolishness.  We now pass audit_syscall_exit a struct pt_reg and it
> in turns calls back into arch code to collect the return value and to
> determine if the syscall was a success or failure.
> 
> In arch/sh/kernel/ptrace_64.c I see that we were using regs[9] in the old
> audit code.  But the ptrace_64.h code was previously using regs[3] for the
> regs_return_value().  I have no idea which one is correct, but this patch now
> uses regs[3].
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

For the x86 portions:

Acked-by: H. Peter Anvin <hpa@zytor.com>

	-hpa
