Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2008 10:23:59 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:2266 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20044285AbYFPJX4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jun 2008 10:23:56 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5G9NZkL006421;
	Mon, 16 Jun 2008 10:23:36 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5G9NYxQ006408;
	Mon, 16 Jun 2008 10:23:34 +0100
Date:	Mon, 16 Jun 2008 10:23:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Laird <daniel.j.laird@nxp.com>
Cc:	Florian Fainelli <florian.fainelli@telecomint.eu>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] : Add support for =?utf-8?Q?NX?=
	=?utf-8?Q?P_PNX833x_=28STB222=2F5=29_into_linux_kernel=E2=80=8F?=
	(UPDATE)
Message-ID: <20080616092333.GA10004@linux-mips.org>
References: <64660ef00806160138i7a5ba93cu926d112625ee401d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64660ef00806160138i7a5ba93cu926d112625ee401d@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 16, 2008 at 09:38:42AM +0100, Daniel Laird wrote:

> Once again comments appreciated, however there does not seem to be a
> conclusion to changes I should make to my (Updated) patch.
> 
> Does this means the patch is acceptable as it stands? Or is further
> rework required?

On of the things I was wondering is if it makes sense to apply your patch
without having applied the "Vectored Interrupts and timers for MIPS 4KC"
first?

  Ralf
