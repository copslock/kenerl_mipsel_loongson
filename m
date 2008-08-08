Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2008 18:56:20 +0100 (BST)
Received: from mailrelay002.isp.belgacom.be ([195.238.6.175]:54332 "EHLO
	mailrelay002.isp.belgacom.be") by ftp.linux-mips.org with ESMTP
	id S28580793AbYHHR4L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 Aug 2008 18:56:11 +0100
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnkFAJ8lnEhR8DtG/2dsb2JhbACBXKs6
Received: from 70.59-240-81.adsl-dyn.isp.belgacom.be (HELO infomag.iguana.be) ([81.240.59.70])
  by relay.skynet.be with ESMTP; 08 Aug 2008 19:56:05 +0200
Received: from infomag.iguana.be (localhost.localdomain [127.0.0.1])
	by infomag.iguana.be (8.13.8/8.12.11) with ESMTP id m78Hu54s013247;
	Fri, 8 Aug 2008 19:56:05 +0200
Received: (from wim@localhost)
	by infomag.iguana.be (8.13.8/8.13.8/Submit) id m78Hu5ZJ013246;
	Fri, 8 Aug 2008 19:56:05 +0200
Date:	Fri, 8 Aug 2008 19:56:05 +0200
From:	Wim Van Sebroeck <wim@iguana.be>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	Alan Cox <alan@redhat.com>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [2.6 patch] fix watchdog/txx9wdt.c compilation
Message-ID: <20080808175605.GE2773@infomag.infomag.iguana.be>
References: <20080808151846.GA14495@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080808151846.GA14495@cs181140183.pp.htv.fi>
User-Agent: Mutt/1.4.2.1i
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi Adrian,

> This patch fixes the following compile error caused by
> commit 8dc244f7deac4c0e95ce0ffd26f494bb6e1534c0
> ([WATCHDOG 48/57] txx9: Fix locking, switch to unlocked_ioctl):

Will also be added.

Kind regards,
Wim.
