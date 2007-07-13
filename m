Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2007 09:53:12 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:14825 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022680AbXGPIxK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jul 2007 09:53:10 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6G8r89S009550;
	Mon, 16 Jul 2007 09:53:09 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6DHxFXm030592;
	Fri, 13 Jul 2007 18:59:15 +0100
Date:	Fri, 13 Jul 2007 18:59:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Enable support for the userlocal hardware register
Message-ID: <20070713175915.GA30076@linux-mips.org>
References: <S20023433AbXGIOIU/20070709140820Z+13176@ftp.linux-mips.org> <20070713.003727.08076834.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070713.003727.08076834.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 13, 2007 at 12:37:27AM +0900, Atsushi Nemoto wrote:

> On Mon, 09 Jul 2007 15:08:15 +0100, linux-mips@linux-mips.org wrote:
> > Which will cut down the cost of RDHWR $29 which is used to obtain the
> > TLS pointer and so far being emulated in software down to a single cycle
> > operation.
> 
> Since cpu_has_userlocal is used in a critical path (switch_to),
> overriding in each cpu-feature-overrides.h might be expected.

Every sper^Wcycle is holy, as Monthy Python would say.

  Ralf
