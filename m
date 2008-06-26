Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2008 13:12:49 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:64469 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20024995AbYFZMMr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jun 2008 13:12:47 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5QCBMQX005990;
	Thu, 26 Jun 2008 14:11:47 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5QCBL0Q005977;
	Thu, 26 Jun 2008 14:11:21 +0200
Date:	Thu, 26 Jun 2008 14:11:20 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Morten Larsen <mlarsen@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Bug in atomic_sub_if_positive
Message-ID: <20080626121120.GA5222@linux-mips.org>
References: <ADD7831BD377A74E9A1621D1EAAED18F0442AF00@NT-SJCA-0750.brcm.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ADD7831BD377A74E9A1621D1EAAED18F0442AF00@NT-SJCA-0750.brcm.ad.broadcom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 25, 2008 at 11:07:24PM -0700, Morten Larsen wrote:

> As far as I can tell the branch optimization fixes in 2.6.21 introduced
> a bug in atomic_sub_if_positive that causes it to return even when the
> sc instruction fails. The result is that e.g. down_trylock becomes
> unreliable as the semaphore counter is not always decremented.

I did play with a test program and can't reproduce the effect with my
assembler.  I have darm memories of gas immitating some obscure behaviour
of the IRIX assembler and I think it doesn't do so for all MIPS targets.

So I'm wandering what toolchain have you been using?

  Ralf
