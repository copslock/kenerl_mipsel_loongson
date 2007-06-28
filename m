Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2007 16:03:36 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:14306 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022665AbXF1PDb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 Jun 2007 16:03:31 +0100
Received: from localhost (p2089-ipad207funabasi.chiba.ocn.ne.jp [222.145.84.89])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7E9C5B6B2; Fri, 29 Jun 2007 00:03:28 +0900 (JST)
Date:	Fri, 29 Jun 2007 00:04:14 +0900 (JST)
Message-Id: <20070629.000414.14979024.anemo@mba.ocn.ne.jp>
To:	jeff@garzik.org
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	sshtylyov@ru.mvista.com, mlachwani@mvista.com
Subject: Re: [PATCH 3/4] rbtx4938: Fix secondary PCIC and glue internal NICs
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4683CB96.9090609@garzik.org>
References: <20070625.231502.69024828.anemo@mba.ocn.ne.jp>
	<20070628.230050.27955707.anemo@mba.ocn.ne.jp>
	<4683CB96.9090609@garzik.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 28 Jun 2007 10:54:14 -0400, Jeff Garzik <jeff@garzik.org> wrote:
> Seems to sane to me, by my quick read.
> 
> My only comment is:  if invalid MAC address, generate a random one using 
> get_random_bytes() like some other net drivers do, rather than just failing.
> 
> Users should be able to use the NIC even if the MAC is invalid -- after 
> all, they can set one using ifconfig even if it is not available at 
> driver load time.

Thank you for quick review!  I will update my patch with
get_random_bytes(). (maybe tomorrow ...)

---
Atsushi Nemoto
