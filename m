Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jan 2003 07:43:29 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:8986 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225229AbTAVHn2>;
	Wed, 22 Jan 2003 07:43:28 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id 04C14B55B; Wed, 22 Jan 2003 08:43:26 +0100 (CET)
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [RFC & PATCH]  fixing tlb flush race problem on smp
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030121143726.C16939@mvista.com> (Jun Sun's message of "Tue,
 21 Jan 2003 14:37:26 -0800")
References: <20030121143726.C16939@mvista.com>
Date: Wed, 22 Jan 2003 08:43:26 +0100
Message-ID: <86bs297hpd.fsf@trasno.mitica>
User-Agent: Gnus/5.090012 (Oort Gnus v0.12) Emacs/21.2.92
 (i386-mandrake-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "jun" == Jun Sun <jsun@mvista.com> writes:

Hi
        just nickpitting.


jun> +		} else {
jun> +			/* drop the current context completely */
jun> +			CPU_CONTEXT(cpu, mm) = 0;
jun> }
jun> }
jun> __restore_flags(flags);

Perhaps creating a inline function for this, as the code is identical
in both branches?


jun> diff -Nru link/include/asm-mips/mmu_context.h.orig link/include/asm-mips/mmu_context.h
jun> --- link/include/asm-mips/mmu_context.h.orig	Tue Jan 21 13:55:43 2003
jun> +++ link/include/asm-mips/mmu_context.h	Tue Jan 21 14:01:19 2003
jun> @@ -89,12 +89,25 @@
jun> static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
jun> struct task_struct *tsk, unsigned cpu)
jun> {
jun> +	unsigned long flags;
jun> +
jun> +	__save_and_cli(flags);

s/__save_and_cli()/local_irq_save()/

jun> +	__restore_flags(flags);

s/__restore_flags()/local_irq_restore()/

Same in the other occurence, please.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
