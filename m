Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2007 15:14:25 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:2797 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021922AbXFYOOW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 25 Jun 2007 15:14:22 +0100
Received: from localhost (p3129-ipad201funabasi.chiba.ocn.ne.jp [222.146.66.129])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DB3BDB589; Mon, 25 Jun 2007 23:14:18 +0900 (JST)
Date:	Mon, 25 Jun 2007 23:15:02 +0900 (JST)
Message-Id: <20070625.231502.69024828.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, sshtylyov@ru.mvista.com,
	mlachwani@mvista.com
Subject: Re: [PATCH 3/4] rbtx4938: Fix secondary PCIC and glue internal NICs
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070625002822.GD5814@linux-mips.org>
References: <20070622.232219.48807177.anemo@mba.ocn.ne.jp>
	<20070625002822.GD5814@linux-mips.org>
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
X-archive-position: 15531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 25 Jun 2007 02:28:22 +0200, Ralf Baechle <ralf@linux-mips.org> wrote:
> <jgarzik> Ralf: probably not...  :)
> <jgarzik> Ralf: dev->open() assumes dev->dev_addr[] is filled in, when interface goes up, and each NIC driver should use that and write the MAC address in dev->dev_addr[] to its RX filter / MAC address registers
> <jgarzik> Ralf: the default value should be filled in before netdev is registers
> <jgarzik> registered
> <jgarzik> Ralf: well, ->open() is just the manifestation of interface-up operation, with all the notifications that that entails.  At that point, NIC driver should not be touching dev->dev_addr[], because it may have already been supplied by the user via ifconfig, when the interface was down.
> <jgarzik> Ralf: dev->dev_addr[] should definitely be filled in before the call to register_netdev()

OK, I'll go another approach.  For now candidate is passing the
dev_addr via special platform_device.  Hopefully it would be
acceptable ...

---
Atsushi Nemoto
