Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 May 2006 17:32:25 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:3807 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133520AbWEJPcS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 May 2006 17:32:18 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4AFWGZd016165;
	Wed, 10 May 2006 16:32:16 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4AFWGsx016164;
	Wed, 10 May 2006 16:32:16 +0100
Date:	Wed, 10 May 2006 16:32:16 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Mark.Zhan" <rongkai.zhan@windriver.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] Wind River 4KC PPMC Eval Board Support
Message-ID: <20060510153215.GB11961@linux-mips.org>
References: <445C6694.6010901@windriver.com> <20060509164127.GA10647@linux-mips.org> <446152CC.6020904@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446152CC.6020904@windriver.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 10, 2006 at 10:41:16AM +0800, Mark.Zhan wrote:

> After looking into the changeset ac58afdfac792c0583af30dbd9eae53e24c78b, 
>  I find what I want to do has been done by you:-)

I don't have this changeset in my tree; I assume you're refering to the
patch titled "[MIPS] Rewrite all the assembler interrupt handlers to C".

> For those MIPS32 boards which only use IRQ_CPU, I think, we can provide 
> a default plat_irq_dispatch() implemention, maybe like this:
> 
> asmlinkage plat_irq_dispatch(struct pt_regs *regs)
> {
> 	unsigned int pending = read_c0_status() & read_c0_cause();
> 	int irq;
> 
> 	irq = ffs(pending >> 8) - 1;
> 	return do_IRQ(irq, regs);
> }
> 
> I this it will clean up more codes......

There are only few such extremly simple platforms in the tree.  The purpose
of me rewriting all the handlers to assembler was that many of the handlers
has bugs that would not exist in a high level language and much of the code
was not scheduled very well - something which gcc does pretty well these
days.

  Ralf
