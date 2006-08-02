Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2006 17:18:52 +0100 (BST)
Received: from p549F69D5.dip.t-dialin.net ([84.159.105.213]:44511 "EHLO
	p549F69D5.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133493AbWHBQSc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Aug 2006 17:18:32 +0100
Received: from mba.ocn.ne.jp ([210.190.142.172]:60368 "HELO smtp.mba.ocn.ne.jp")
	by lappi.linux-mips.net with SMTP id S1099951AbWHBP6j (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 Aug 2006 17:58:39 +0200
Received: from localhost (p8096-ipad213funabasi.chiba.ocn.ne.jp [124.85.73.96])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2F6F884EC; Thu,  3 Aug 2006 00:58:26 +0900 (JST)
Date:	Thu, 03 Aug 2006 01:00:00 +0900 (JST)
Message-Id: <20060803.010000.25909906.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 7/7] Allow unwind_stack() to return ra for leaf function
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44D0A3B0.40601@innova-card.com>
References: <44D07C97.2040008@innova-card.com>
	<20060802.202540.10544424.nemoto@toshiba-tops.co.jp>
	<44D0A3B0.40601@innova-card.com>
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
X-archive-position: 12161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 02 Aug 2006 15:08:00 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> does this updated patch make you really happy ? If so I'll resend the whole
> updated patchset.

Yes, looks good for me.

Just one comment: no need to do "pc = pc != ra ? ra : 0" anymore.
Just "pc = ra" is enough, isn't it?

---
Atsushi Nemoto
