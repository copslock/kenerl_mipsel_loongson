Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2009 11:27:22 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58532 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492286AbZKEK1T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Nov 2009 11:27:19 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA5ASfdA015803;
	Thu, 5 Nov 2009 11:28:42 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA5AScOx015801;
	Thu, 5 Nov 2009 11:28:38 +0100
Date:	Thu, 5 Nov 2009 11:28:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
	huhb@lemote.com, yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	liujl@lemote.com
Subject: Re: [PATCH -queue v0 1/6] [loongson] add basic loongson-2f support
Message-ID: <20091105102838.GF12582@linux-mips.org>
References: <cover.1257325319.git.wuzhangjin@gmail.com> <a1bd2470bc465e505281c761adca8c2287d102b3.1257325319.git.wuzhangjin@gmail.com> <20091105091841.GC12582@linux-mips.org> <1257414523.1824.11.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257414523.1824.11.camel@falcon.domain.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 05, 2009 at 05:48:43PM +0800, Wu Zhangjin wrote:

> > I thought the Loongson 2E/2F were MIPS64 Release 1 compatible?
> > 
> 
> They told me MIPS III, but added MMX instruction set ;)

Just when I thought MIPS III was on the way out ;-)

> > You're ifdefing on Loongson 2F - doesn't that mean that you can't have a
> > kernel that supports both Loongson 2E and 2F?
> > 
> 
> Currently, not consider it yet;) It's a little hard to cope with, should
> we consider it at this moment? if yes, I will try it with the help of
> exisiting machtype asap. but I think it's better to let it be the future
> job ;)

Fair enough - though I'm sure Linux distributions would be happy to have
one kernel variant less to ship.

> > static struct irqaction __maybe_unused dma_timeout_irqaction = {
> > [...]
> > };
> > 
> 
> okay, will apply it later.

Thanks.

  Ralf
