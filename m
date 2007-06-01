Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jun 2007 18:40:43 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:33205 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022944AbXFARkk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Jun 2007 18:40:40 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l51HeNtm028504;
	Fri, 1 Jun 2007 18:40:23 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l51HeMMk028503;
	Fri, 1 Jun 2007 18:40:22 +0100
Date:	Fri, 1 Jun 2007 18:40:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Fix modpost warnings by making start_secondary __cpuinit
Message-ID: <20070601174021.GA28461@linux-mips.org>
References: <S28573756AbXEaP7t/20070531155949Z+115@ftp.linux-mips.org> <20070602.013022.52128810.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070602.013022.52128810.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.3i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jun 02, 2007 at 01:30:22AM +0900, Atsushi Nemoto wrote:

> Looking at arch/mips/kernel/smp.c, I suppose there should be much more
> functions to be marked as __cpuinit.  For example,
> prom_init_secondary(), prom_smp_finish(), prom_smp_finish(),
> prom_boot_secondary(), etc.
> 
> And then, smtc_init_secondary(), smtc_smp_finish(), etc. ...

That is absolutely correct but beyond the minimal fix needed to deal with
the warning for 2.6.22.  Longer term I'd like to get CPU hotplugging
working, it could be a handy feature with multi-threaded kernel models such
as VSMP and SMTC.

  Ralf
