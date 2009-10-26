Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2009 08:27:24 +0100 (CET)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:39624 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492207AbZJZH1Q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2009 08:27:16 +0100
Received: by pzk32 with SMTP id 32so9040250pzk.21
        for <multiple recipients>; Mon, 26 Oct 2009 00:27:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=FSRSIU+Srkq747njMUm31nfKmDmTTM/gmS5BnHKm0sE=;
        b=uem5ciqTfDC8rAfHFl5AnuKXDS/k7baxT5uxa+0yBNsvD6PD0sHVyFzq76N1n7e7Jx
         S0iHXZVMYSSWKgONtMzNA34ZqSKeiQNh4zaGKSBJwrPdubyF4QpGvFHrR4qRIv/v83SU
         UjPXrwc0bNvGzUbLxqbFaoU+8uM6Ao71UGBG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=KKhKuZtKHjiTZmJ2stNWACM7JBzjgZTXrCNGlvDrYmBUKt2j9JVJT5y88u2kp0Duq6
         Gc7B20RHcsvp7UeTL7Lgepa4BCcB+8+rmwmedV7/DP8s7MY9qnrutgHVckOQ0Pkr5/ay
         6g39wZ8b/VQJfulgFiObjtFayfClfn9+7HIKs=
Received: by 10.115.133.39 with SMTP id k39mr22220759wan.94.1256542025753;
        Mon, 26 Oct 2009 00:27:05 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm1001583pxi.7.2009.10.26.00.26.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 00:27:05 -0700 (PDT)
Subject: Re: [PATCH -v5 09/11] tracing: add IRQENTRY_EXIT for MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Frederic Weisbecker <fweisbec@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
In-Reply-To: <c62985530910251736ye7551c4l1a62a1ba242a191f@mail.gmail.com>
References: <cover.1256482555.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256483735.git.wuzhangjin@gmail.com>
	 <3e0c2d7d8b8f196a8153beb41ea7f3cbf42b3d84.1256483735.git.wuzhangjin@gmail.com>
	 <54c417629e91f40b2bbb4e08cda2a4e6527824c0.1256483735.git.wuzhangjin@gmail.com>
	 <29bccff04932e993ecd9f516d8b6dcf84e2ceecf.1256483735.git.wuzhangjin@gmail.com>
	 <72f2270f7b6e01ca7a4cdf4ac8c21778e5d9652f.1256483735.git.wuzhangjin@gmail.com>
	 <6140dd8f4e1783e5ac30977cf008bb98e4698322.1256483735.git.wuzhangjin@gmail.com>
	 <cover.1256483735.git.wuzhangjin@gmail.com>
	 <49b3c441a57f4db423732f81432a3450ccb3240e.1256483735.git.wuzhangjin@gmail.com>
	 <6ad82af0c2ec8ef7b9f536b0a97bf65d385c3945.1256483735.git.wuzhangjin@gmail.com>
	 <c62985530910251736ye7551c4l1a62a1ba242a191f@mail.gmail.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Mon, 26 Oct 2009 15:26:40 +0800
Message-Id: <1256542000.5642.118.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, 2009-10-26 at 01:36 +0100, Frederic Weisbecker wrote:
> 2009/10/25 Wu Zhangjin <wuzhangjin@gmail.com>:
> > This patch fix the following error with FUNCTION_GRAPH_TRACER=y:
> >
> > kernel/built-in.o: In function `print_graph_irq':
> > trace_functions_graph.c:(.text+0x6dba0): undefined reference to `__irqentry_text_start'
> > trace_functions_graph.c:(.text+0x6dba8): undefined reference to `__irqentry_text_start'
> > trace_functions_graph.c:(.text+0x6dbd0): undefined reference to `__irqentry_text_end'
> > trace_functions_graph.c:(.text+0x6dbd4): undefined reference to `__irqentry_text_end'
> >
> > (This patch is need to support function graph tracer of MIPS)
> 
> 
> If you want to enjoy this section, you'd need to tag the
> mips irq entry functions with "__irq_entry"  :)
> 
> I guess there is a do_IRQ() in mips that is waiting for that (and
> probably some others).
> The effect is that interrupt areas are cut with a pair of arrows
> in the trace, so that you more easily spot interrupts in the traces
> 
> May be I missed this part in another patch in this series though...

ooh, Sorry, only this patch added(I stopped after fixing the compiling
errors, no more check! so lazy a guy!).

Just checked the source code of MIPS, the do_IRQ() is defined as a
macro, so, I must move the macro to a C file, and also, there is a
irq_enter...irq_exit block in a "big" function, I need to split it out.

[...]
/*
 * do_IRQ handles all normal device IRQ's (the special
 * SMP cross-CPU interrupts have their own specific
 * handlers).
 *
 * Ideally there should be away to get this into kernel/irq/handle.c to
 * avoid the overhead of a call for just a tiny function ...
 */
#define do_IRQ(irq)
\
do {
\
        irq_enter();
\
        __DO_IRQ_SMTC_HOOK(irq);
\
        generic_handle_irq(irq);
\
        irq_exit();
\
} while (0)
[...]

But The comment told us: do not make this tiny function be a standalone
function, so???

the same to do_IRQ_no_affinity.

and, about the following function, I need to split the
irq_enter()...irq_exit() block out.

void ipi_decode(struct smtc_ipi *pipi)
{
	[...]
        switch (type_copy) {
        case SMTC_CLOCK_TICK:
                irq_enter();
                kstat_incr_irqs_this_cpu(irq, irq_to_desc(irq));
                cd = &per_cpu(mips_clockevent_device, cpu);
                cd->event_handler(cd);
                irq_exit();
                break;

        case LINUX_SMP_IPI:
                switch ((int)arg_copy) {
                case SMP_RESCHEDULE_YOURSELF:
                        ipi_resched_interrupt();
                        break;
                case SMP_CALL_FUNCTION:
                        ipi_call_interrupt();
                        break;
	[...]

Regards,
	Wu Zhangjin
