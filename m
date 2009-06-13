Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Jun 2009 17:27:47 +0200 (CEST)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36870 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1492350AbZFMP1j (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 13 Jun 2009 17:27:39 +0200
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by www.etchedpixels.co.uk (8.14.3/8.14.3) with ESMTP id n5DFS2A5018423;
	Sat, 13 Jun 2009 16:28:02 +0100
Date:	Sat, 13 Jun 2009 16:28:02 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	James Cloos <cloos@jhcloos.com>
Cc:	linux-kernel@vger.kernel.org,
	"Linux-MIPS" <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Takashi Iwai <tiwai@suse.de>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/8] add lib/gcd.c
Message-ID: <20090613162802.6c212505@lxorguk.ukuu.org.uk>
In-Reply-To: <m38wjwz5ur.fsf@lugabout.jhcloos.org>
References: <200906041615.10467.florian@openwrt.org>
	<m38wjwz5ur.fsf@lugabout.jhcloos.org>
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.14.7; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> Would the binary gcd algorithm not be a better fit for the kernel?
> 
> It avoids division, using only shifts and subtraction:

Time them both and see. I suspect on a lot of processors the divide based
one now wins. We also have fls() and ffs() which may mean some platforms
can implement the first two loops even better.

Could well be the shift based one is better for some processors only.
