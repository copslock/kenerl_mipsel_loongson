Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jun 2006 01:03:52 +0100 (BST)
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36230
	"EHLO sunset.davemloft.net") by ftp.linux-mips.org with ESMTP
	id S3686519AbWF3ADn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Jun 2006 01:03:43 +0100
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 7FD01AE422C;
	Thu, 29 Jun 2006 17:03:40 -0700 (PDT)
Date:	Thu, 29 Jun 2006 17:03:40 -0700 (PDT)
Message-Id: <20060629.170340.55510056.davem@davemloft.net>
To:	samuel@sortiz.org
Cc:	bunk@stusta.de, akpm@osdl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org, reiga@dspnet.fr.eu.org,
	irda-users@lists.sourceforge.net
Subject: Re: [PATCH 2/2] [IrDA] Fix the AU1000 FIR dependencies
From:	David Miller <davem@davemloft.net>
In-Reply-To: <20060630065607.GB4729@sortiz.org>
References: <20060629154148.GA19712@stusta.de>
	<20060630065607.GB4729@sortiz.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Samuel Ortiz <samuel@sortiz.org>
Date: Fri, 30 Jun 2006 09:56:07 +0300

> AU1000 FIR is broken, it should depend on SOC_AU1000.
> 
> Spotted by Jean-Luc Leger.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Signed-off-by: Samuel Ortiz <samuel@sortiz.org>

Applied, thanks.
