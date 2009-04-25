Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Apr 2009 10:00:54 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:46504 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20021746AbZDYJAv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 25 Apr 2009 10:00:51 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3P90n6J028659;
	Sat, 25 Apr 2009 11:00:50 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3P90n7j028656;
	Sat, 25 Apr 2009 11:00:49 +0200
Date:	Sat, 25 Apr 2009 11:00:49 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP27: Fix clash with NMI_OFFSET from hardirq.h
Message-ID: <20090425090049.GB15043@linux-mips.org>
References: <20090421213112.33937C32C0@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090421213112.33937C32C0@solo.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 21, 2009 at 11:31:12PM +0200, Thomas Bogendoerfer wrote:

> There was already a define for NMI_OFFSET in asm/sn/addr.h, which now
> clashes with linux/hardirq.h. Rename the one in sn/addr.h to fix IP27
> builds..
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Applied.  Thanks,

  Ralf
