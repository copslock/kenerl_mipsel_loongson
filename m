Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 21:25:21 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:53287 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491864AbZGATZN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Jul 2009 21:25:13 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n61JJZtT026862;
	Wed, 1 Jul 2009 20:19:35 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n61JJY8J026861;
	Wed, 1 Jul 2009 20:19:34 +0100
Date:	Wed, 1 Jul 2009 20:19:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yong Zhang <yong.zhang@windriver.com>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: o32 application running on 64bit kernel core dump
Message-ID: <20090701191934.GE23121@linux-mips.org>
References: <16bd35f2910f585740f4764fa1e80bf31c80d576.1242178813.git.yong.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16bd35f2910f585740f4764fa1e80bf31c80d576.1242178813.git.yong.zhang@windriver.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 01, 2009 at 09:35:39AM +0800, Yong Zhang wrote:

> +/* These MUST be defined before elf.h gets included */

This sort of ordering bug seems to become a tradition.  I think it may be
a good idea to insert a check like this:

#ifdef ELF_CORE_COPY_REGS
#error ELF_CORE_COPY_REGS should not be defined yet!
#endif

> +extern void elf32_core_copy_regs(elf_gregset_t grp, struct pt_regs *regs);
> +#define ELF_CORE_COPY_REGS(_dest, _regs) elf32_core_copy_regs(_dest, _regs);
> +#define ELF_CORE_COPY_TASK_REGS(_tsk, _dest)				\
> +({									\
> +	int __res = 1;							\
> +	elf32_core_copy_regs((*_dest), (task_pt_regs(_tsk)));		\

Be very careful with parentheses in macros.  This line should probably
become:

	elf32_core_copy_regs(*(_dest), task_pt_regs(_tsk));		\

The changes to the first argument to bullet prof the macro and the change
to the second one for cosmetic reasons.

  Ralf
