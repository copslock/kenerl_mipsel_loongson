Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 11:27:01 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:62364 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22906544AbYKAL0x (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 1 Nov 2008 11:26:53 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mA1BQi5T002815;
	Sat, 1 Nov 2008 11:26:44 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mA1BQhhE002813;
	Sat, 1 Nov 2008 11:26:43 GMT
Date:	Sat, 1 Nov 2008 11:26:43 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
Cc:	libc-ports@sources.redhat.com, Daniel Jacobowitz <drow@false.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Glibc
Message-ID: <20081101112643.GA2249@linux-mips.org>
References: <490A912A.8030901@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <490A912A.8030901@gentoo.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 31, 2008 at 01:01:30AM -0400, Kumba wrote:

> +#ifndef (_MIPS_ARCH_R10000)
> +#define R10K_BEQZ_INSN "beqz	%1,1b\n"
> +#else
> +#define R10K_BEQZ_INSN "beqzl	%1,1b\n"
> +#endif

In the kernel we have very good knowledge about what types of processors
are being used for what configuration; much less in userland and the code
as suggested by you would result in a silent failure on affected R10000
machines if version built not for the R10000 was being used - iow no
improvment over what we have right now.  So for userland I'd prefer to

 o MIPS I builds: use the some 28 nops.
 o Builds for MIPS II or better: always use the branch likely
 o A runtime test would have to be implemented pessimisticall because it
   would have to rely on /proc being mounted which isn't available early in
   the boot process.  It's probably going to add more overhead than it
   saves anyway.

There is a price for using branch likely - but not that high.  In the grand
picture it'll almost certainly vanish in the benchmarking noise.

  Ralf
