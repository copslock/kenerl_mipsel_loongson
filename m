Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2007 13:18:46 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:41102 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021857AbXJEMSn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Oct 2007 13:18:43 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l95CIgdk022302;
	Fri, 5 Oct 2007 13:18:42 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l95CIfoq022301;
	Fri, 5 Oct 2007 13:18:41 +0100
Date:	Fri, 5 Oct 2007 13:18:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	"Steven J. Hill" <sjhill@realitydiluted.com>,
	veerasena reddy <veerasena_b@yahoo.co.in>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: unresoved symbol _gp_disp
Message-ID: <20071005121841.GC1404@linux-mips.org>
References: <230962.51223.qm@web8408.mail.in.yahoo.com> <20071004173928.GA32033@real.realitydiluted.com> <4705272D.7050801@avtrex.com> <20071004175305.GB32033@real.realitydiluted.com> <470531DB.6090507@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470531DB.6090507@avtrex.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 04, 2007 at 11:32:59AM -0700, David Daney wrote:

> Steven J. Hill wrote:
> >>Unless you compile your code with -msoft-float *and* also have a version 
> >>of libgcc compiled with -mlong-calls -mno-abicalls -G0.  If you do it 
> >>that way, floating point works fine in the kernel (as long as you don't 
> >>try to call sprintf with floating point parameters).
> >>
> >I won't even concede that solution. It's bad practice and design to have
> >floating point in the kernel.
> 
> I agree that floating point in the kernel is bad practice.  However 
> under some circumstances, the most expedient solution does not conform 
> to best practice.

I also feel deeply unfriendly if I send somebody along a path that's
full of interesting corner cases ...

  Ralf
