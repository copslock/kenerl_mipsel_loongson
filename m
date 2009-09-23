Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2009 14:45:32 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:46061 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492958AbZIWMp0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Sep 2009 14:45:26 +0200
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id C6E11E0808D;
	Wed, 23 Sep 2009 14:45:18 +0200 (CEST)
Received: from [213.228.1.107] (sakura.staff.proxad.net [213.228.1.107])
	by smtp6-g21.free.fr (Postfix) with ESMTP id D49D4E080E2;
	Wed, 23 Sep 2009 14:45:15 +0200 (CEST)
Subject: Re: [PATCH] MIPS: BCM63xx: Add PCMCIA & Cardbus support.
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	Wolfram Sang <w.sang@pengutronix.de>
Cc:	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-pcmcia@lists.infradead.org, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <20090923123143.GB3131@pengutronix.de>
References: <1253272891.1627.284.camel@sakura.staff.proxad.net>
	 <20090923123143.GB3131@pengutronix.de>
Content-Type: text/plain
Organization: Freebox
Date:	Wed, 23 Sep 2009 14:45:15 +0200
Message-Id: <1253709915.1627.397.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


On Wed, 2009-09-23 at 14:31 +0200, Wolfram Sang wrote:

> Okay, here is a fast review. If you fix the mentioned points (or give me good
> reasons why not ;)), then you might add my
> 
> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
> 
> I am fine with Ralf picking this up.

Agreed on all your points and will fix them. Thanks.

Ralf, please give me a couple of days to fix this and I will send you an
updated patch.

-- 
Maxime
