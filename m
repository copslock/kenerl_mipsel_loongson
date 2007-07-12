Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 17:39:49 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:40684 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022564AbXGLQjr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 17:39:47 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6CGOi1a016950;
	Thu, 12 Jul 2007 17:24:44 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6CGOhwg016949;
	Thu, 12 Jul 2007 17:24:43 +0100
Date:	Thu, 12 Jul 2007 17:24:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix a sparse warning in arch/mips/pci/pci.c
Message-ID: <20070712162443.GB16740@linux-mips.org>
References: <20070713.012652.130851739.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070713.012652.130851739.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 13, 2007 at 01:26:52AM +0900, Atsushi Nemoto wrote:

> Fixes this warning:
> 
> arch/mips/pci/pci.c:284:18: warning: symbol 'dev' shadows an earlier one
> arch/mips/pci/pci.c:272:17: originally declared here

Thanks, applied.

  Ralf
