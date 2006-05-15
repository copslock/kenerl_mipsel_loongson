Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2006 03:07:14 +0200 (CEST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:23233 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133747AbWEOBHH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 May 2006 03:07:07 +0200
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 15 May 2006 10:07:05 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 31F0A203DA;
	Mon, 15 May 2006 10:07:00 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 1DB3C1FF09;
	Mon, 15 May 2006 10:07:00 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k4F16x4D026239;
	Mon, 15 May 2006 10:06:59 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 15 May 2006 10:06:59 +0900 (JST)
Message-Id: <20060515.100659.126574393.nemoto@toshiba-tops.co.jp>
To:	jamiller1110@cox.net
Cc:	linux-mips@linux-mips.org
Subject: Re: Instruction error with cache opcode
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4467796E.8060000@mountolympos.net>
References: <446735C6.2080306@mountolympos.net>
	<002a01c67761$253e97f0$0202a8c0@Ulysses>
	<4467796E.8060000@mountolympos.net>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 14 May 2006 14:39:42 -0400, John Miller <jamiller1110@cox.net> wrote:
> I included asm/cacheops.h from the kernel tree, it is defined there as :
> 
> #define Index_Store_Tag_I	0x08

Then how about Fill_I ?

---
Atsushi Nemoto
