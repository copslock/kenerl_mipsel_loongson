Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2007 09:52:50 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:30146 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021395AbXIRIws (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Sep 2007 09:52:48 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8I8qkWl026808;
	Tue, 18 Sep 2007 09:52:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8I8qkvW026807;
	Tue, 18 Sep 2007 09:52:46 +0100
Date:	Tue, 18 Sep 2007 09:52:46 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Steve Graham <stgraham2000@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: O2 RM7000 Issues
Message-ID: <20070918085246.GC26585@linux-mips.org>
References: <4687DCE2.8070302@gentoo.org> <468825BE.6090001@gmx.net> <50451.70.107.91.207.1183381723.squirrel@webmail.wesleyan.edu> <20070704152729.GA2925@linux-mips.org> <20070704192208.GA7873@linux-mips.org> <469C8600.7090208@niisi.msk.ru> <20070717122711.GA19977@linux-mips.org> <12746880.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12746880.post@talk.nabble.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 17, 2007 at 04:04:52PM -0700, Steve Graham wrote:

> I am having a similar problem where complicated bash scripts on boot randomly
> throw SIGILL.  I am running on a PMC MSP8510 platform - E9000 core.  I have
> applied the patch to "war.h" mentioned in this thread and that did greatly
> reduce the number of occurences of this problem but has not fixed it.  I was
> getting at least 2 illegal instructions every boot and now I can boot
> without any problems about 90% of the time.
> 
> Does the patch you mention below apply to the E9000 core as well?

Not to my knowledge - but I'm lacking any halfwayrecent errata information
for the RM9000 series, maybe somebody from PMC can jump in?

  Ralf
