Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2007 18:10:39 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:24001 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021933AbXD1RKi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Apr 2007 18:10:38 +0100
Received: from localhost (p7147-ipad204funabasi.chiba.ocn.ne.jp [222.146.94.147])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7E73CB5FC; Sun, 29 Apr 2007 02:10:34 +0900 (JST)
Date:	Sun, 29 Apr 2007 02:10:37 +0900 (JST)
Message-Id: <20070429.021037.41179188.anemo@mba.ocn.ne.jp>
To:	akpm@linux-foundation.org
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org, jeff@garzik.org,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com
Subject: Re: [PATCH 2/3] ne: MIPS: Use platform_driver for ne on RBTX49XX
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070428010414.2ba43a30.akpm@linux-foundation.org>
References: <20070425.015549.108742168.anemo@mba.ocn.ne.jp>
	<20070428010414.2ba43a30.akpm@linux-foundation.org>
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
X-archive-position: 14941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 28 Apr 2007 01:04:14 -0700, Andrew Morton <akpm@linux-foundation.org> wrote:
> platform_device_register_simple() copies *res by value, so I believe we can
> make res[] static __initdata.  This way we don't need to evaluate the array
> on the stack at runtime, and the data gets discarded after initcalls have
> run.
> 
> Can you please review and test the below?  I had a go but wasn't able to
> fumble my way to a suitable config (I hope):

It looks OK.  I will merge your fix to updated patch.  Thank you.

And the lack of its defconfig should be fixed anyway, but it should be
another story ...

---
Atsushi Nemoto
