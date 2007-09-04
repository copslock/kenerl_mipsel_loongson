Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 13:50:15 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:26533 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024740AbXIDMuN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Sep 2007 13:50:13 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l84CoC3P016651;
	Tue, 4 Sep 2007 13:50:12 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l84CoAZL016650;
	Tue, 4 Sep 2007 13:50:10 +0100
Date:	Tue, 4 Sep 2007 13:50:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Chris Dearman <chris@mips.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [MIPS] SMTC: Fix crash on bootup with idebus= command line
	argument.
Message-ID: <20070904125010.GA15630@linux-mips.org>
References: <S20024438AbXHGQ1m/20070807162742Z+2733@ftp.linux-mips.org> <20070904.000501.41013092.anemo@mba.ocn.ne.jp> <46DC2D2E.8080408@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46DC2D2E.8080408@mips.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 03, 2007 at 04:50:06PM +0100, Chris Dearman wrote:

> Atsushi Nemoto wrote:
> >Why pci_get_class() in ide_default_io_base() cause crash on SMTC?
> 
> The bug wasn't really SMTC specific, it was just that it showed up on 
> SMTC builds. The failure was caused by the early parsing of the 
> idebus=xx argument. The argument parser ended up calling
> pci_scan that unconditionally enabled interrupts prematurely.

Which at the time did also happen for x86 - it just happened to be a
harmless bug there.

  Ralf
