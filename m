Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Aug 2009 22:26:46 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:40798 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493265AbZHaU0j (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Aug 2009 22:26:39 +0200
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 17BCFE080F7;
	Mon, 31 Aug 2009 22:26:32 +0200 (CEST)
Received: from [213.228.1.107] (sakura.staff.proxad.net [213.228.1.107])
	by smtp6-g21.free.fr (Postfix) with ESMTP id E751FE080C7;
	Mon, 31 Aug 2009 22:26:29 +0200 (CEST)
Subject: Re: [PATCH 2/2] bcm63xx: only set the proper GPIO overlay settings
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	Florian Fainelli <florian@openwrt.org>
Cc:	ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <200908312028.10931.florian@openwrt.org>
References: <200908312028.10931.florian@openwrt.org>
Content-Type: text/plain
Organization: Freebox
Date:	Mon, 31 Aug 2009 22:26:29 +0200
Message-Id: <1251750389.10420.24.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


On Mon, 2009-08-31 at 20:28 +0200, Florian Fainelli wrote:

> This patch makes the GPIO pin multiplexing configuration
> read the initial GPIO mode register value instead of
> setting it initially to 0, then setting the correct
> bits, this is safer.

I disagree, now we get working or not working devices depending on the
CFE version used, for which we don't have any public source code nor
changelog.

I cleared the register for that purpose.

If a particular pin muxing config is needed for some board, we should
add this to the board specific struct instead.

-- 
Maxime
