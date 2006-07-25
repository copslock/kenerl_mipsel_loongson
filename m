Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2006 04:46:08 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:58577 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8126515AbWGYDp7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2006 04:45:59 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k6P3kJq9026153;
	Mon, 24 Jul 2006 23:46:20 -0400
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k6P3kJRt026152;
	Mon, 24 Jul 2006 23:46:19 -0400
Date:	Mon, 24 Jul 2006 23:46:19 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	hemanth.venkatesh@wipro.com.redhat.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Multiple page size support for AU1xxx
Message-ID: <20060725034619.GA22617@linux-mips.org>
References: <2156B1E923F1A147AABDF4D9FDEAB4CB09D650@blr-m2-msg.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2156B1E923F1A147AABDF4D9FDEAB4CB09D650@blr-m2-msg.wipro.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@denk.linux-mips.net.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 24, 2006 at 08:24:13PM +0530, hemanth.venkatesh@wipro.com wrote:

> Has anyone been able to configure and boot kernel with page sizes other
> that 4kb i.e. 16KB and 64KB on any AU1xxx based boards.

Currently only 16kB works and only for 64-bit kernels.  I'm planning to
fix that rsn.

64K pagesize is extremly large for embedded systems of the size of the
typical Alchemy system due to the memory overhead.

  Ralf
