Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2009 21:29:43 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55460
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492906AbZGFT3g (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2009 21:29:36 +0200
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id C3680C8C485;
	Mon,  6 Jul 2009 12:22:38 -0700 (PDT)
Date:	Mon, 06 Jul 2009 12:22:38 -0700 (PDT)
Message-Id: <20090706.122238.212724277.davem@davemloft.net>
To:	bzolnier@gmail.com
Cc:	wuzhangjin@gmail.com, jeff.chua.linux@gmail.com,
	etienne.basset@numericable.fr, rjw@sisk.pl,
	linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org
Subject: Re: [Bug #13663] suspend to ram regression (IDE related)
From:	David Miller <davem@davemloft.net>
In-Reply-To: <200907061658.00936.bzolnier@gmail.com>
References: <200907031508.47891.bzolnier@gmail.com>
	<1246635096.16890.6.camel@falcon>
	<200907061658.00936.bzolnier@gmail.com>
X-Mailer: Mew version 6.2.51 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 6 Jul 2009 16:57:59 +0200

>> I think it's better to revert this commit:
>>  a1317f714af7aed60ddc182d0122477cbe36ee9b ("ide: improve handling of
>> Power Management requests")
>  
> I completely agree and I've already requested this a week ago
> (this commit was not meant for going straight to -rc tree anyway).

I'll revert this today and push that to Linus.
