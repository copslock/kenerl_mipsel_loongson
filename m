Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 15:35:30 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:59618 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20044730AbWHKOf1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Aug 2006 15:35:27 +0100
Received: from localhost (p5235-ipad30funabasi.chiba.ocn.ne.jp [221.184.80.235])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9C94DFA6; Fri, 11 Aug 2006 23:35:19 +0900 (JST)
Date:	Fri, 11 Aug 2006 23:36:58 +0900 (JST)
Message-Id: <20060811.233658.41198724.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ths@networkno.de, linux-mips@linux-mips.org, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp
Subject: Re: [PATCH 6/6] setup.c: use early_param() for early command line
 parsing
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44DC338A.3070602@innova-card.com>
References: <44D99B02.1070406@innova-card.com>
	<20060809.232551.74752502.anemo@mba.ocn.ne.jp>
	<44DC338A.3070602@innova-card.com>
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
X-archive-position: 12281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 11 Aug 2006 09:36:42 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Well, I resent a new version (take #2) of the patchset that uses _only_
> "rd_xxx" semantic. I prefer not add some code which isn't going to be
> used. Mainly because only bootloaders use this parameter and I guess
> they never change the way they pass initrd address. And there won't be
> a lot of new bootloaders anyways.

I see.  OK for me.
---
Atsushi Nemoto
