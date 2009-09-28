Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Sep 2009 17:08:25 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:46192 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493415AbZI1PIT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 Sep 2009 17:08:19 +0200
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 5350CE081A6;
	Mon, 28 Sep 2009 17:08:12 +0200 (CEST)
Received: from [213.228.1.107] (sakura.staff.proxad.net [213.228.1.107])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 6A608E080A1;
	Mon, 28 Sep 2009 17:08:09 +0200 (CEST)
Subject: Re: [PATCH v3] MIPS: BCM63xx: Add PCMCIA & Cardbus support.
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Greg Kroah-Hartman <gregkh@suse.de>, linux-mips@linux-mips.org
In-Reply-To: <20090928134423.GA29791@linux-mips.org>
References: <1253272891.1627.284.camel@sakura.staff.proxad.net>
	 <20090923123143.GB3131@pengutronix.de>
	 <1253709915.1627.397.camel@sakura.staff.proxad.net>
	 <1253890476.1627.468.camel@sakura.staff.proxad.net>
	 <4ABCF1E7.4010304@ru.mvista.com>
	 <1254142183.1627.488.camel@sakura.staff.proxad.net>
	 <20090928134423.GA29791@linux-mips.org>
Content-Type: text/plain
Organization: Freebox
Date:	Mon, 28 Sep 2009 17:08:09 +0200
Message-Id: <1254150489.1627.503.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


On Mon, 2009-09-28 at 14:44 +0100, Ralf Baechle wrote:

> so with PCMCIA sorted this leaves only the two USB UHCI / EHCI patches.
> What is the status of these?

I got this review at first post:

http://www.spinics.net/lists/mips/msg32240.html

I addressed all comments, beside readl_be/writel_be, which I'm not sure
how to integrate correctly in mips generic code.

-- 
Maxime
