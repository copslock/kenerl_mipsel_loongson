Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2007 02:41:31 +0100 (BST)
Received: from mail.onstor.com ([66.201.51.107]:14925 "EHLO mail.onstor.com")
	by ftp.linux-mips.org with ESMTP id S20022101AbXHIBl3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2007 02:41:29 +0100
Received: from onstor-exch02.onstor.net ([66.201.51.106]) by mail.onstor.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 8 Aug 2007 18:41:22 -0700
Received: from ripper.onstor.net ([10.0.0.42]) by onstor-exch02.onstor.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 8 Aug 2007 18:41:21 -0700
Date:	Wed, 8 Aug 2007 18:41:20 -0700
From:	Andrew Sharp <andy.sharp@onstor.com>
To:	linux-mips@linux-mips.org
Subject: Re: kexec - not happening on mipsel?
Message-ID: <20070808184120.40b6b5d5@ripper.onstor.net>
In-Reply-To: <20070808170846.7d395891@ripper.onstor.net>
References: <20070808170846.7d395891@ripper.onstor.net>
Organization: Onstor
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Aug 2007 01:41:21.0551 (UTC) FILETIME=[637409F0:01C7DA26]
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.sharp@onstor.com
Precedence: bulk
X-list: linux-mips

On Wed, 8 Aug 2007 17:08:46 -0700 Andrew Sharp <andy.sharp@onstor.com>
wrote:

> We could sure make use of kexec for quick reboots (it bloody takes
> forever for the PROM to set up ECC memory).  The config option is in
> Kconfig; I haven't checked the kernel source.  But the userspace
> package kexec-tools barfs on the mipsel arch in configure.

Answering my own question on this part at least, it didn't take long to
find this patch, so we'll see how that goes.

http://lists.infradead.org/pipermail/kexec/2007-June/000214.html

> Is anybody using this on MIPS?  Do the kernel portions work for
> anyone?
