Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2007 10:40:06 +0000 (GMT)
Received: from out002.atlarge.net ([129.41.63.60]:58173 "EHLO
	out002.atlarge.net") by ftp.linux-mips.org with ESMTP
	id S20022276AbXCLKj5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Mar 2007 10:39:57 +0000
Received: from hpmailfe-01.atlarge.net ([10.100.60.156]) by out002.atlarge.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 12 Mar 2007 05:37:31 -0500
Received: from localhost ([213.250.36.225]) by hpmailfe-01.atlarge.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 12 Mar 2007 05:37:31 -0500
Date:	Mon, 12 Mar 2007 11:39:27 +0100
From:	Domen Puncer <domen.puncer@telargo.com>
To:	Marco Braga <marco.braga@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Trouble with sound/mips/au1x00.c AC97 driver
Message-ID: <20070312103927.GC14658@moe.telargo.com>
References: <20070307104930.GD25248@dusktilldawn.nl> <d459bb380703082322r18879381ma4c57149a8b7adfe@mail.gmail.com> <45F350E9.3020208@cooper-street.com> <d459bb380703120157wb3dde00p4c232e300e82fd3d@mail.gmail.com> <d459bb380703120259r53889966xd8af623ff01ef297@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d459bb380703120259r53889966xd8af623ff01ef297@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-OriginalArrivalTime: 12 Mar 2007 10:37:31.0689 (UTC) FILETIME=[70630990:01C76492]
Return-Path: <domen.puncer@telargo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@telargo.com
Precedence: bulk
X-list: linux-mips

On 12/03/07 10:59 +0100, Marco Braga wrote:
> Hello,
> 
> I've added to: "snd_au1000_ac97_new" the lines:
> 
> au1000->ac97_ioport->config = AC97C_SG | AC97C_SYNC;
> udelay(100);
> au1000->ac97_ioport->config = 0x0;
> 
> after the cold reset, as you suggested. Sadly this did not solve the
> problem.
> 
> It seems that the only solution I have at the moment is to add a longer
> delay between hard reset and warm reset. I've changed the "udelay(10)" to a
> "mdelay(250)" (I know, it is a huge delay) but now the module is loaded
> perfectly every time. Now I'll try to reduce the delay and find the min.
> I don't know if this issue is related to our board or if you can explain it.
> 

Hi!

It might be ignorance on my part, but aren't au_sync()'s needed here?


	Domen
