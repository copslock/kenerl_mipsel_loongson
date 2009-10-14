Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2009 01:35:13 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44091 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493697AbZJNXfJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Oct 2009 01:35:09 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9ENPJPN001147;
	Thu, 15 Oct 2009 01:30:40 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9ENPIKK001145;
	Thu, 15 Oct 2009 01:25:18 +0200
Date:	Thu, 15 Oct 2009 01:25:18 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shane McDonald <mcdonald.shane@gmail.com>
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] [MIPS] msp71xx: remove unused function
Message-ID: <20091014232518.GA621@linux-mips.org>
References: <1255546939-3302-1-git-send-email-dmitri.vorobiev@movial.com> <1255546939-3302-3-git-send-email-dmitri.vorobiev@movial.com> <b2b2f2320910141616p7b53c898gc4bc6a75713d4a8e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2b2f2320910141616p7b53c898gc4bc6a75713d4a8e@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 14, 2009 at 05:16:08PM -0600, Shane McDonald wrote:

> > Nobody calls the board-specific prom_getcmdline(), so let's remove it.
> >
> > Build-tested using msp71xx_defconfig.
> >
> > Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
> >
> >
> NAK.  It is called by the MSP71xx's Ethernet driver, whose code has not yet
> made it into the mainline (last submission
> http://www.linux-mips.org/archives/linux-mips/2007-05/msg00210.html).
> Believe it or not, getting that driver whipped into shape is something I'm
> slowly (very slowly) working on.

At a glance, it's not outrageously bad so I suggest you submit it to be
merged into drivers/staging it least it will no longer suffer the bitrot
that out of tree drivers suffer from.

  Ralf
