Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2006 15:25:27 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:24057 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037491AbWJLOZ0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Oct 2006 15:25:26 +0100
Received: from localhost (p1084-ipad31funabasi.chiba.ocn.ne.jp [221.189.125.84])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1FA42A42E; Thu, 12 Oct 2006 23:25:20 +0900 (JST)
Date:	Thu, 12 Oct 2006 23:27:37 +0900 (JST)
Message-Id: <20061012.232737.35471315.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org
Subject: Re: [PATCH 4/5] Introduce __pa_symbol()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <452E2DAC.9080207@innova-card.com>
References: <452D180D.9020700@innova-card.com>
	<20061012.184855.108739419.nemoto@toshiba-tops.co.jp>
	<452E2DAC.9080207@innova-card.com>
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
X-archive-position: 12918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 12 Oct 2006 13:57:32 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> No I don't have any example but you can take a look to
> 
> http://lkml.org/lkml/2006/8/23/175

Thanks!  Reading the thread, I remember "near" vs. "far" pointer issue
in DOS age ...

---
Atsushi Nemoto
