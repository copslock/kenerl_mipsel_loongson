Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jun 2007 20:33:44 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:30098 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023046AbXFQTdm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 17 Jun 2007 20:33:42 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5HJPlaS003094;
	Sun, 17 Jun 2007 20:26:02 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5HJPf99003093;
	Sun, 17 Jun 2007 20:25:41 +0100
Date:	Sun, 17 Jun 2007 20:25:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] Implement clockevents for R4000-style cp0 timer
Message-ID: <20070617192540.GB2912@linux-mips.org>
References: <11818164024053-git-send-email-fbuihuu@gmail.com> <20070614.212913.82089068.nemoto@toshiba-tops.co.jp> <20070617000448.GA30807@linux-mips.org> <20070618.022314.108738340.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070618.022314.108738340.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 18, 2007 at 02:23:14AM +0900, Atsushi Nemoto wrote:

> Thanks, looks good to me except a few things.
> 
> >  arch/mips/momentum/jaguar_atx/setup.c  |    8 ++++-
> 
> Zombie? ;)

In 2.6.21 that zombie didn't yet have the stake in its heart ;-)

  Ralf
