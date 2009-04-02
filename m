Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2009 12:47:50 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:2541 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20025875AbZDBLrs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Apr 2009 12:47:48 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n32Blk71003874
	for <linux-mips@linux-mips.org>; Thu, 2 Apr 2009 13:47:46 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n32BlkmN003872
	for linux-mips@linux-mips.org; Thu, 2 Apr 2009 13:47:46 +0200
Date:	Thu, 2 Apr 2009 13:47:46 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH] added Loongson cpu-feature-overrides.h
Message-ID: <20090402114746.GC1678@linux-mips.org>
References: <1238658105-23260-1-git-send-email-r0bertz@gentoo.org> <20090402111607.GB1678@linux-mips.org> <20090402112739.GD28319@adriano.hkcable.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090402112739.GD28319@adriano.hkcable.com.hk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 02, 2009 at 07:27:39PM +0800, Zhang Le wrote:

> > > I have taken Wu Zhangjin's and Philippe Vachon's version as references, did a
> > > little modification and tested on 16K page size kernel. It works well.
> > > 
> > > Unfornately although it already has defined cpu_has_dc_aliases as 1, 4k page
> > > size still not working. More work needed here.
> > 
> > Adding this file is only a matter of kernel optimization.  You may have
> > saved as much as several hundred kb!  But it won't get a kernel
> > that wasn't working before to work.  If anything the opposite ...
> 
> I see. Thanks.
> BTW, I have just made another little change:
> 
> #define cpu_has_dc_aliases      (PAGE_SIZE < 0x4000)
> 
> Since waysize is 16k.
> 
> Anyway, it is good to include this file now, or postpone it a little later?
> If yes, then I will send a new version soon.

Correct - but this alone doesn't get all 4k or 64k pages to work so how
about we deal with this one later?

  Ralf
