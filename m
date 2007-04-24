Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2007 18:03:59 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:60125 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021440AbXDXRD5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Apr 2007 18:03:57 +0100
Received: from localhost (p3087-ipad201funabasi.chiba.ocn.ne.jp [222.146.66.87])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 35E95AB65; Wed, 25 Apr 2007 02:03:54 +0900 (JST)
Date:	Wed, 25 Apr 2007 02:03:55 +0900 (JST)
Message-Id: <20070425.020355.70477311.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	netdev@vger.kernel.org, jeff@garzik.org, ralf@linux-mips.org,
	sshtylyov@ru.mvista.com
Subject: Re: [PATCH 2/3] ne: MIPS: Use platform_driver for ne on RBTX49XX
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070425.015549.108742168.anemo@mba.ocn.ne.jp>
References: <20070425.015549.108742168.anemo@mba.ocn.ne.jp>
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
X-archive-position: 14906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 25 Apr 2007 01:55:49 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> This patch lets RBTX49XX boards use generic platform_driver interface
> for the ne driver.

This patch obsolates a patch I send on 1 Mar.

> Subject: [PATCH] Fix broken RBTX4927 support in ne.c
> Message-Id: <20070301.012223.129448787.anemo@mba.ocn.ne.jp>
> Date: 	Thu, 01 Mar 2007 01:22:23 +0900 (JST)

I revoke this old patch if new patch was acceptable.

---
Atsushi Nemoto
