Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 18:12:51 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:59835 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027214AbXFGRMt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 18:12:49 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l57H5i5u031360;
	Thu, 7 Jun 2007 18:05:44 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l57H5g9h031359;
	Thu, 7 Jun 2007 18:05:42 +0100
Date:	Thu, 7 Jun 2007 18:05:42 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Fuxin Zhang <zhangfx@lemote.com>
Cc:	tiansm@lemote.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] override of arch/mips/mm/cache.c: __uncached_access
Message-ID: <20070607170542.GD30044@linux-mips.org>
References: <20070606182814.GD30017@linux-mips.org> <11811962573610-git-send-email-tiansm@lemote.com> <4667A443.8060105@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4667A443.8060105@lemote.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 07, 2007 at 02:22:59PM +0800, Fuxin Zhang wrote:

> For example,if we are using this memory layout:
> 0-256MB phys mem
> 256-512M pci io/mem region
> 512-768MB phys mem
> Xorg will crash due to pci video memory mapping problem.
> 
> So this is not really only for Fulong.
> 
> BTW:
> Songmao, we'd better add a comment to justify this code.

Note I didn't fundamentally object to the patch; it was rather a a question
of _how_ to do it.  The patch I put into the -queue tree will allow you
to put all the Fulong-specifics into the Fulong code rather than the
generic code.

  Ralf
