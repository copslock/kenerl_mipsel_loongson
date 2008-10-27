Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 11:39:56 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:41928 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22494051AbYJ0Ljt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2008 11:39:49 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9RBdmkI013231;
	Mon, 27 Oct 2008 11:39:49 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9RBdm5v013229;
	Mon, 27 Oct 2008 11:39:48 GMT
Date:	Mon, 27 Oct 2008 11:39:48 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] DS1286: kill BKL
Message-ID: <20081027113948.GA13085@linux-mips.org>
References: <1225106948-30550-1-git-send-email-dmitri.vorobiev@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1225106948-30550-1-git-send-email-dmitri.vorobiev@movial.fi>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 27, 2008 at 01:29:08PM +0200, Dmitri Vorobiev wrote:

> Using the Big Kernel Lock in the open() method of the DS1286
> RTC driver is redundant, because the driver makes use of it's
> own spinlock to guarantee serialized access. This patch kills
> the redundant BKL calls.

I'm about to kill the BKL in the driver even more thoroughly - by killing
the entire driver.

  Ralf
