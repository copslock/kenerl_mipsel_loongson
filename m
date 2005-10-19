Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2005 16:58:26 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:792 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465656AbVJSP6F (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Oct 2005 16:58:05 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9JFw0EU018007;
	Wed, 19 Oct 2005 16:58:00 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9JFvxUr018006;
	Wed, 19 Oct 2005 16:57:59 +0100
Date:	Wed, 19 Oct 2005 16:57:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: Fix zero length sys_cacheflush
Message-ID: <20051019155759.GJ2616@linux-mips.org>
References: <20051019.195714.89066462.nemoto@toshiba-tops.co.jp> <20051019132902.GE2616@linux-mips.org> <20051019.232222.59465169.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051019.232222.59465169.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 19, 2005 at 11:22:22PM +0900, Atsushi Nemoto wrote:

> BTW, sparse complains for this "unsigned long __user addr".
> 
> asmlinkage int sys_cacheflush(unsigned long __user addr,
> 	unsigned long bytes, unsigned int cache)
> 
> /work/git/linux-mips/arch/mips/mm/cache.c:59:7: warning: dereference of noderef expression
> 
> I suppose the "unsigned long __user addr" means that the "addr"
> variable itself is an userspace object.  So its usage is wrong, isn't
> it?

It didn't complain about this use in the past.  Anyway, time to do another
pass with sparse over the code; sparse developers have invented alot of new
creative warnings ;-)

  Ralf
