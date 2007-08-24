Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Aug 2007 12:08:37 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:11421 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024498AbXHXLHb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Aug 2007 12:07:31 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7OB7UnJ006839;
	Fri, 24 Aug 2007 12:07:30 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7OB7T7h006838;
	Fri, 24 Aug 2007 12:07:29 +0100
Date:	Fri, 24 Aug 2007 12:07:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sunil Amitkumar Janki <devel.sjanki@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Kernel 2.6.23-rc3 build error
Message-ID: <20070824110729.GA4321@linux-mips.org>
References: <46CB0876.5030508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46CB0876.5030508@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 21, 2007 at 05:44:54PM +0200, Sunil Amitkumar Janki wrote:

> >ERROR: "free_dma" [drivers/scsi/qlogicfas.ko] undefined!
> >ERROR: "free_dma" [drivers/scsi/pas16.ko] undefined!
> >ERROR: "free_dma" [drivers/scsi/NCR53c406a.ko] undefined!
> >ERROR: "request_dma" [drivers/net/tokenring/skisa.ko] undefined!
> >ERROR: "free_dma" [drivers/net/tokenring/skisa.ko] undefined!
> >ERROR: "request_dma" [drivers/net/tokenring/proteon.ko] undefined!
> >ERROR: "free_dma" [drivers/net/tokenring/proteon.ko] undefined!

Seems some sort of generic issue, looking into that now.

> >ERROR: "__cmpdi2" [drivers/md/dm-snapshot.ko] undefined!

The __cmpdi2 one is the interesting one.  Which version of gcc are you
using?  And if you still have it, could you send me your .config file?

  Ralf
