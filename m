Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Aug 2009 01:31:40 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:57122 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493163AbZHGXbd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Aug 2009 01:31:33 +0200
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id A0CFFE08089;
	Sat,  8 Aug 2009 01:31:25 +0200 (CEST)
Received: from [127.0.0.1] (sakura.staff.proxad.net [213.228.1.107])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 619B9E08017;
	Sat,  8 Aug 2009 01:31:22 +0200 (CEST)
Subject: Re: [PATCH 0/8] New BCM63xx SoC support and devices registration
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <200908072346.15278.florian@openwrt.org>
References: <200908072346.15278.florian@openwrt.org>
Content-Type: text/plain
Date:	Sat, 08 Aug 2009 01:31:21 +0200
Message-Id: <1249687881.29189.68.camel@kero>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


On Fri, 2009-08-07 at 23:46 +0200, Florian Fainelli wrote:

Hi Florian,

> The following 8 patches apply on top of the patch entitled "bcm63xx:
> fix build failures when CONFIG_PCI is disabled"

Nice work, ack for the whole serie.

I don't have any 6338 nor 6345 hardware, so I'll trust you for doing
some testing if that's needed in the future. Please try to compile with
and without cpu runtime detection because it's quite easy to forget to
fill the registers set for each case.

> Ralf, Maxime sent a patch series on June 3rd which would be great to
> merge so that I can rebase my serie on that one

Yup, that would be great :)

-- 
Maxime
