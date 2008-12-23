Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2008 14:39:16 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:7083 "EHLO
	mail.linux-mips.net") by ftp.linux-mips.org with ESMTP
	id S24207611AbYLWOjM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Dec 2008 14:39:12 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.14.2/8.13.1) with ESMTP id mBNEdBIW006486;
	Tue, 23 Dec 2008 15:39:11 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.14.2/8.14.2/Submit) id mBNEd9oD006485;
	Tue, 23 Dec 2008 15:39:09 +0100
Date:	Tue, 23 Dec 2008 15:39:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/2] Alchemy: provide cpu feature overrides.
Message-ID: <20081223143909.GD5981@linux-mips.org>
References: <1229973668-18182-1-git-send-email-mano@roarinelk.homelinux.net> <1229973668-18182-2-git-send-email-mano@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1229973668-18182-2-git-send-email-mano@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 22, 2008 at 08:21:08PM +0100, Manuel Lauss wrote:

> Add cpu feature override constants for Alchemy.
> 
> Code generated for Alchemy does not use all MIPS32r1 features.  Add cpu
> feature overrides tailored for Alchemy chips and help GCC create better
> code.  As a nice sideeffect the size of the resulting kernel is reduced
> by a few kilobytes (~200kB for a non-modular db1200 devboard build).

The enormous size difference is probably 99% due to atomic and bitops
which exist in LL/SC and non-LL/SC versions and without the header gcc
will expand the inline function each time.  That will hurt, also
performance.  Also the big size difference suggests that we may want to
outline some or all of these functions.

  Ralf
