Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 08:51:58 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:40601 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023340AbZEUHvv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 May 2009 08:51:51 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4L7p98p019457;
	Thu, 21 May 2009 08:51:09 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4L7p4qb019455;
	Thu, 21 May 2009 08:51:04 +0100
Date:	Thu, 21 May 2009 08:51:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: Re: [loongson-PATCH-v1 03/27] fix-error: incompatiable argument
	type of clear_user
Message-ID: <20090521075104.GB32295@linux-mips.org>
References: <cover.1242855716.git.wuzhangjin@gmail.com> <8f44bd7169af8d4fdafa42ce4750943ef4da439f.1242855716.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f44bd7169af8d4fdafa42ce4750943ef4da439f.1242855716.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 21, 2009 at 05:50:01AM +0800, wuzhangjin@gmail.com wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> there are lots of warnings about the macro: clear_user in linux-mips.
> 
> the type of the second argument of access_ok should be (void __user *),
> but there is an un-needed (unsigned long) conversion before __cl_addr,
> so, remove the (unsigned long) will fix this problem.

I assume you're talking about sparse warnings, not gcc warnings?

Either way, access_ok() is defined to take pointer arguments, so patch
applied.  Thanks!

  Ralf
