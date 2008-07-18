Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2008 16:25:40 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:42713 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28587823AbYGRPZh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2008 16:25:37 +0100
Received: from localhost (p8181-ipad203funabasi.chiba.ocn.ne.jp [222.146.87.181])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0D993B464; Sat, 19 Jul 2008 00:25:30 +0900 (JST)
Date:	Sat, 19 Jul 2008 00:27:20 +0900 (JST)
Message-Id: <20080719.002720.25909000.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] Make pcibios_plat_dev_init weak
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080708.011410.41198497.anemo@mba.ocn.ne.jp>
References: <20080418.235357.25909447.anemo@mba.ocn.ne.jp>
	<20080708.011410.41198497.anemo@mba.ocn.ne.jp>
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
X-archive-position: 19888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 08 Jul 2008 01:14:10 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Most platforms do not need special pcibios_plat_dev_init.  Make it
> weak function and kill all empty instances.

Are there any chances for this patch (and other pci patches with
__weak) ?  If yes, I will update them against current git, othersize I
will drop them to trashbox.

---
Atsushi Nemoto
