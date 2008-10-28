Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 06:47:56 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:18641 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22548753AbYJ1Grs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2008 06:47:48 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9S6like018974;
	Tue, 28 Oct 2008 06:47:44 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9S6lhP7018971;
	Tue, 28 Oct 2008 06:47:43 GMT
Date:	Tue, 28 Oct 2008 06:47:43 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 07/36] Don't assume boot CPU is CPU0 if
	MIPS_DISABLE_BOOT_CPU_ZERO set.
Message-ID: <20081028064743.GA18610@linux-mips.org>
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 27, 2008 at 05:02:39PM -0700, David Daney wrote:

> MIPS SMP code currently assumes that the boot CPU will be CPU0
> of the system.  For some systems, this may not be the case.

It always the logic CPU 0 though the physical number might be different.

> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index b79ea70..e2597ef 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -195,12 +195,14 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  /* preload SMP state for boot cpu */
>  void __devinit smp_prepare_boot_cpu(void)
>  {
> +#ifndef MIPS_DISABLE_BOOT_CPU_ZERO
>  	/*
>  	 * This assumes that bootup is always handled by the processor
>  	 * with the logic and physical number 0.
>  	 */
>  	__cpu_number_map[0] = 0;
>  	__cpu_logical_map[0] = 0;
> +#endif

This assignment is redundant anyway - the kernel is starting with the array
zeroed.  So just remove this entire initialization and do your array
initialization in your mp_ops->smp_setup.

And to tell another dirty secret - the arrays currently happen to be unused
though we should use them at some point ...

  Ralf
