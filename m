Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2007 13:35:44 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:2284 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022370AbXHIMfm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Aug 2007 13:35:42 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l79CZUVv014500;
	Thu, 9 Aug 2007 13:35:30 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l79CZUs7014499;
	Thu, 9 Aug 2007 13:35:30 +0100
Date:	Thu, 9 Aug 2007 13:35:30 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Sharp <andy.sharp@onstor.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: kexec - not happening on mipsel?
Message-ID: <20070809123530.GA14183@linux-mips.org>
References: <20070808170846.7d395891@ripper.onstor.net> <20070808184120.40b6b5d5@ripper.onstor.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070808184120.40b6b5d5@ripper.onstor.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 08, 2007 at 06:41:20PM -0700, Andrew Sharp wrote:

> > We could sure make use of kexec for quick reboots (it bloody takes
> > forever for the PROM to set up ECC memory).  The config option is in
> > Kconfig; I haven't checked the kernel source.  But the userspace
> > package kexec-tools barfs on the mipsel arch in configure.
> 
> Answering my own question on this part at least, it didn't take long to
> find this patch, so we'll see how that goes.
> 
> http://lists.infradead.org/pipermail/kexec/2007-June/000214.html
> 
> > Is anybody using this on MIPS?  Do the kernel portions work for
> > anyone?

I recently noticed the kernel part was fairly broken, did (if ever) only
work for 32-bit machines.  I fixed what I could but I don't have the
necessary test setup.  See

  http://www.linux-mips.org/git?p=linux.git;a=commit;h=bb73f9d8ee3133800da546832ca7f09d3f27695e

  Ralf
