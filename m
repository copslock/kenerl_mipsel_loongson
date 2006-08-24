Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Aug 2006 16:10:40 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:15835 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038466AbWHXPKj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Aug 2006 16:10:39 +0100
Received: from localhost (p5213-ipad207funabasi.chiba.ocn.ne.jp [222.145.87.213])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A6B39A940; Fri, 25 Aug 2006 00:10:33 +0900 (JST)
Date:	Fri, 25 Aug 2006 00:12:21 +0900 (JST)
Message-Id: <20060825.001221.93019451.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	nigel@mips.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] fix cache coherency issues
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060824121205.GA22587@linux-mips.org>
References: <20060824111515.GA4490@linux-mips.org>
	<20060824.203838.07455316.nemoto@toshiba-tops.co.jp>
	<20060824121205.GA22587@linux-mips.org>
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
X-archive-position: 12426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 24 Aug 2006 13:12:05 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> I figured it was worth a try.  It means the process will start running with
> a hot copy of the COW page instead of a cold copy and I can use hit
> invalidates instead of hit wbinv on the kernel address of the to page.
> 
> Lmbenching now, stay tuned ...

Hmm, if we could invalidate _before_ copy_page() and writeback
(without invalidate) _after_ the copy, it might be worth.

---
Atsushi Nemoto
