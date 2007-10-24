Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2007 16:12:59 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:19692 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20031475AbXJXPM5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Oct 2007 16:12:57 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9OFCpc1009989;
	Wed, 24 Oct 2007 16:12:51 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9OFCo7M009988;
	Wed, 24 Oct 2007 16:12:50 +0100
Date:	Wed, 24 Oct 2007 16:12:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc:	Alessandro Zummo <a.zummo@towertech.it>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [patch 1/2] rtc: release correct region in error path
Message-ID: <20071024151250.GA8684@linux-mips.org>
References: <20071023204843.442608289@ldl.fc.hp.com> <20071023205515.406778977@ldl.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071023205515.406778977@ldl.fc.hp.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 23, 2007 at 02:48:44PM -0600, Bjorn Helgaas wrote:

> Subject: [patch 1/2] rtc: release correct region in error path
> 
> The misc_register() error path always released an I/O port region,
> even if the region was memory-mapped (only mips uses memory-mapped RTC,
> as far as I can see).

Well, MIPS just like other sane architectures has no concept of ioports.
So if there ever is something that's called an ioport on MIPS then it's
really a memory location in a memory address range where other PCish
devices are living, too.  So typically those memory addresses are
translated to an actual ioport access by a PCI bridge.  There are a few
systems where this concept just apply easily such as DECstations, so
there we simply claim the device such as the RTC in this case is memory
mapped.

Anway:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
