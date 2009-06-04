Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 16:28:47 +0100 (WEST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:52219 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20022422AbZFDP2k (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Jun 2009 16:28:40 +0100
Received: from localhost (p7097-ipad209funabasi.chiba.ocn.ne.jp [58.88.118.97])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 898E9AA7B; Fri,  5 Jun 2009 00:28:33 +0900 (JST)
Date:	Fri, 05 Jun 2009 00:28:33 +0900 (JST)
Message-Id: <20090605.002833.39155438.anemo@mba.ocn.ne.jp>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	apatard@mandriva.com, yanh@lemote.com, zhangfx@lemote.com,
	pavel@ucw.cz, wuzj@lemote.com, huhb@lemote.com
Subject: Re: [PATCH-v2] Hibernation Support in mips system
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <9c9bc070f3c272c41254304537e9dec398245b94.1244118419.git.wuzj@lemote.com>
References: <9c9bc070f3c272c41254304537e9dec398245b94.1244118419.git.wuzj@lemote.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu,  4 Jun 2009 20:27:10 +0800, wuzhangjin@gmail.com wrote:
> From: Wu Zhangjin <wuzj@lemote.com>
> 
> This is pulled from the to-mips branch of
> http://dev.lemote.com/code/linux_loongson, the original author is Hu
> Hongbing from www.lemote.com

I have successfully suspended to disk on malta qemu.  Thanks!

---
Atsushi Nemoto
