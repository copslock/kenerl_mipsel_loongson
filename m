Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 13:27:13 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:46761 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S28578417AbYFLM1L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jun 2008 13:27:11 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5CCQmle017976;
	Thu, 12 Jun 2008 13:26:49 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5CCQkmL017897;
	Thu, 12 Jun 2008 13:26:46 +0100
Date:	Thu, 12 Jun 2008 13:26:46 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org, sshtylyov@ru.mvista.com,
	drzeus@drzeus.cx, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] Alchemy: register mmc platform device for
	db1200/pb1200 boards.
Message-ID: <20080612122646.GA9493@linux-mips.org>
References: <20080609063521.GA8724@roarinelk.homelinux.net> <20080609063702.GC8724@roarinelk.homelinux.net> <20080612090206.GB21601@linux-mips.org> <20080612101839.GC21601@linux-mips.org> <20080612121828.GA24603@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080612121828.GA24603@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 12, 2008 at 02:18:28PM +0200, Manuel Lauss wrote:

> Hi Ralf, Pierre,
> 
> On Thu, Jun 12, 2008 at 11:18:39AM +0100, Ralf Baechle wrote:
> > On Thu, Jun 12, 2008 at 10:02:06AM +0100, Ralf Baechle wrote:
> > 
> > I cleaned the numerals for the DMA constants with below patch which now
> > is in the 2.6.27 patch queue.
> 
> Here's a new version of [PATCH 2/8], against those changes.

Thanks, looking good, thus:

Acked-by: Ralf Baechl <ralf@linux-mips.org>

Pierre, feel free to merge these MIPS bits into your tree.  The whole
series should probably go upstream together.

  Ralf
