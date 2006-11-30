Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2006 00:56:55 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:28275 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037517AbWK3A4v (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Nov 2006 00:56:51 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 30 Nov 2006 09:56:49 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 370F223ED1;
	Thu, 30 Nov 2006 09:56:46 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 22BF820846;
	Thu, 30 Nov 2006 09:56:46 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id kAU0uhW0057256;
	Thu, 30 Nov 2006 09:56:44 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 30 Nov 2006 09:56:43 +0900 (JST)
Message-Id: <20061130.095643.74752511.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	m.kozlowski@tuxland.pl, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips tx4927 missing brace fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061129194346.GA20892@linux-mips.org>
References: <200611292030.36170.m.kozlowski@tuxland.pl>
	<20061129194346.GA20892@linux-mips.org>
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
X-archive-position: 13273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 29 Nov 2006 19:43:46 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Nov 29, 2006 at 08:30:35PM +0100, Mariusz Kozlowski wrote:
> 
> > 	This patch adds missing brace at the end of toshiba_rbtx4927_irq_isa_init().
> 
> Thanks Mariusz!  Applied,

Oh, that was my fault.  Thank you.  I see the fix was folded into
linux-queue tree.  Thanks.

---
Atsushi Nemoto
