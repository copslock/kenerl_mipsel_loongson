Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2009 11:31:17 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:59196 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493041AbZIWJbJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Sep 2009 11:31:09 +0200
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 23CD2E0804F;
	Wed, 23 Sep 2009 11:31:03 +0200 (CEST)
Received: from [213.228.1.107] (sakura.staff.proxad.net [213.228.1.107])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 3329DE08016;
	Wed, 23 Sep 2009 11:31:01 +0200 (CEST)
Subject: Re: [PATCH] MIPS: BCM63xx: Add PCMCIA & Cardbus support.
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	Wolfram Sang <w.sang@pengutronix.de>
Cc:	Greg Kroah-Hartman <gregkh@suse.de>, linux-mips@linux-mips.org,
	linux-pcmcia@lists.infradead.org,
	Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <20090919154755.GA27704@pengutronix.de>
References: <1253272891.1627.284.camel@sakura.staff.proxad.net>
	 <20090919154755.GA27704@pengutronix.de>
Content-Type: text/plain
Organization: Freebox
Date:	Wed, 23 Sep 2009 11:31:00 +0200
Message-Id: <1253698260.1627.391.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


On Sat, 2009-09-19 at 17:47 +0200, Wolfram Sang wrote:

> I can't make it for 2.6.32, but will try to get it queued for 2.6.33.
> What about the second FIXME in the driver BTW?

It should go away.

The timings are correct for slowest type of access (attribute memory if
I remember well).

At first I thought it would be possible to change the timings
dynamically to speedup other memory regions, but a driver may do
attribute memory access anytime without warning us, so we have to stick
with the slowest value.

I will resubmit the patch without the FIXME.

-- 
Maxime
