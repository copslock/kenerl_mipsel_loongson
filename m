Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2007 15:57:16 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:63441 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030018AbXI0O5O (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Sep 2007 15:57:14 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8REvD1K010493;
	Thu, 27 Sep 2007 15:57:13 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8REvCBq010492;
	Thu, 27 Sep 2007 15:57:12 +0100
Date:	Thu, 27 Sep 2007 15:57:12 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	nigel@mips.com, linux-mips <linux-mips@linux-mips.org>
Subject: Re: Useless stack randomization patch
Message-ID: <20070927145712.GA10377@linux-mips.org>
References: <46FA6846.2080704@gmail.com> <20070926150433.GA28017@linux-mips.org> <46FA78AA.9050104@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46FA78AA.9050104@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 26, 2007 at 05:20:10PM +0200, Franck Bui-Huu wrote:

> Ralf Baechle wrote:
> > On Wed, Sep 26, 2007 at 04:10:14PM +0200, Franck Bui-Huu wrote:
> > I suppose we should give it a sane definition.  Not sure what would be
> > useful, if it should be like an ASCII string with the processor type or
> > more corse grained like just "mips32r2", should ASEs be mentioned ...
> > 
> 
> Well before giving any sane definition, shouldn't we know why this
> dependency (ELF_PLATFORM/sp-randomization) exists at all...
> 
> Is something like the patch below better ?

Yes, I think that makes more sense.

  Ralf
