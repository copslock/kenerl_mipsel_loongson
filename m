Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 May 2006 12:29:01 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:5007 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133513AbWEJK2y (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 May 2006 12:28:54 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4AASrBx004197;
	Wed, 10 May 2006 11:28:53 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4AASq7h004196;
	Wed, 10 May 2006 11:28:52 +0100
Date:	Wed, 10 May 2006 11:28:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Martin Michlmayr <tbm@cyrius.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] [MIPS] create consistency in "system type" selection
Message-ID: <20060510102852.GA3193@linux-mips.org>
References: <20060509213453.GA32050@deprecation.cyrius.com> <Pine.LNX.4.62.0605101026450.17487@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0605101026450.17487@pademelon.sonytel.be>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 10, 2006 at 10:27:25AM +0200, Geert Uytterhoeven wrote:

> On Tue, 9 May 2006, Martin Michlmayr wrote:
> > The "system type" Kconfig options on MIPS are not consistent.  For
> > some platforms, only the name is listed while other entries are
> > prepended with "Support for".  Remove this as it doesn't make sense
> > when describing the "system type".  This is in line with how e.g.
> > ARM handles this.
> 
> I guess the `Support for' prefix came from the era you could compile one kernel
> that supported multiple systems.

You still can but they need to be lumped together into a single group
in the "System type" menu.  In reality it's not terribly interesting
and rarely tested.

  Ralf
