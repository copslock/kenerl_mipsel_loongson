Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jun 2009 14:00:49 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:56856 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492816AbZFYMAm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Jun 2009 14:00:42 +0200
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 50F7EE08142;
	Thu, 25 Jun 2009 13:56:56 +0200 (CEST)
Received: from [213.228.1.107] (sakura.staff.proxad.net [213.228.1.107])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 627C2E0813A;
	Thu, 25 Jun 2009 13:56:54 +0200 (CEST)
Subject: Re: [PATCH] Make Broadcom SoC naming options consistent
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org
In-Reply-To: <20090625114258.GA32558@linux-mips.org>
References: <200906251034.32811.florian@openwrt.org>
	 <20090625114258.GA32558@linux-mips.org>
Content-Type: text/plain
Organization: Freebox
Date:	Thu, 25 Jun 2009 13:56:13 +0200
Message-Id: <1245930973.30592.63.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


On Thu, 2009-06-25 at 12:42 +0100, Ralf Baechle wrote:

> Thanks.  Patch applied nad tree respun against -rc1.  With the AR7
> stuff finally merged this makes the BCM stuff the longest pending to
> be merged ...

I'm considering removing non MIPS stuff (ethernet, usb, pcmcia) from the
patchset for the moment. Getting ACKs from all subsystems on the same
merge window is too difficult.

That way you could merge the CPU support in your tree, and the drivers
could go via subsystems trees on the next merge window.

What do you think ?

-- 
Maxime
