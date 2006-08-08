Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2006 17:03:58 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:37854 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20041289AbWHHQDz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2006 17:03:55 +0100
Received: from localhost (p7220-ipad30funabasi.chiba.ocn.ne.jp [221.184.82.220])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F400FA40E; Wed,  9 Aug 2006 01:03:48 +0900 (JST)
Date:	Wed, 09 Aug 2006 01:05:26 +0900 (JST)
Message-Id: <20060809.010526.18607898.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ths@networkno.de, linux-mips@linux-mips.org, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp
Subject: Re: [PATCH 6/6] setup.c: use early_param() for early command line
 parsing
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44D898FE.7080006@innova-card.com>
References: <1155041313139-git-send-email-vagabon.xyz@gmail.com>
	<20060808125604.GI29989@networkno.de>
	<44D898FE.7080006@innova-card.com>
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
X-archive-position: 12242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 08 Aug 2006 16:00:30 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> >> NOTE ! This patch also changes the initrd semantic. Old code
> >> was expecting "rd_start=xxx rd_size=xxx" which uses two
> >> parameters. Now the code expects "initrd=xxx@yyy" which is
> >> really simpler to parse and to use. No default config files
> >> use these parameters anyways but not sure for bootloader's
> >> users...
> > 
> > This code is there precisely because most mips bootloaders use
> > rd_start/rd_size.
> 
> OK, I guess we have to stick with this weird semantic...

Maybe you can add something like "initrdmem=xxx@yyy", keeping
"rd_start" and "rd_size" for the backward compatibility.  Just a
thought.

---
Atsushi Nemoto
