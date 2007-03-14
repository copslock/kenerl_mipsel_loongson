Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2007 15:12:58 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:10958 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022446AbXCNPMx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Mar 2007 15:12:53 +0000
Received: from localhost (p2145-ipad30funabasi.chiba.ocn.ne.jp [221.184.77.145])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E6839C5C9; Thu, 15 Mar 2007 00:11:30 +0900 (JST)
Date:	Thu, 15 Mar 2007 00:11:29 +0900 (JST)
Message-Id: <20070315.001129.126139947.anemo@mba.ocn.ne.jp>
To:	jeff@garzik.org
Cc:	shemminger@linux-foundation.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, netdev@vger.kernel.org,
	sshtylyov@ru.mvista.com, akpm@linux-foundation.org
Subject: Re: [PATCH] tc35815: Fix an usage of streaming DMA API.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <45F7C797.4030509@garzik.org>
References: <20070313120418.554a3a43@freekitty>
	<20070314.100557.33857330.nemoto@toshiba-tops.co.jp>
	<45F7C797.4030509@garzik.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 14 Mar 2007 05:59:51 -0400, Jeff Garzik <jeff@garzik.org> wrote:
> > OK, Jeff, should I send a revised patch dropping this line?
> 
> Nah, there's no need to reject the patch on that basis.
> 
> You should send an additional patch, on top of all others you sent 
> recently, that completely removes the entire changelog from the driver 
> source code :)

OK, Done :)
---
Atsushi Nemoto
