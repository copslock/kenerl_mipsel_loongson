Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2007 14:36:33 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:53462 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023895AbXHCNga (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Aug 2007 14:36:30 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l73DaU3w020543;
	Fri, 3 Aug 2007 14:36:30 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l73DaTXw020542;
	Fri, 3 Aug 2007 14:36:29 +0100
Date:	Fri, 3 Aug 2007 14:36:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Christoph Hellwig <hch@lst.de>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH 4/5] Use -Werror on TX39/TX49 boards
Message-ID: <20070803133629.GB16519@linux-mips.org>
References: <20070802.233617.70476666.anemo@mba.ocn.ne.jp> <20070803132550.GA21454@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070803132550.GA21454@lst.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 03, 2007 at 03:25:50PM +0200, Christoph Hellwig wrote:

> Please don't.  Adding -Werror is a complete pain in the ass for people
> using new compilers or when we get things like __deprecated or
> __warn_unused warnings from headers.  We've dropped it again from
> the various placed that had introduced this.

It seems to crank up the the pain level to the point where people upgrade
their code :-)

  Ralf
