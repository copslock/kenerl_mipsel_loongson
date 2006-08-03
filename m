Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2006 05:52:44 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:50204 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133359AbWHCEwf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Aug 2006 05:52:35 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 3 Aug 2006 13:52:34 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id B2ECD20474;
	Thu,  3 Aug 2006 13:52:32 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 9EB402045A;
	Thu,  3 Aug 2006 13:52:32 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k734qVW0024170;
	Thu, 3 Aug 2006 13:52:32 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 03 Aug 2006 13:52:31 +0900 (JST)
Message-Id: <20060803.135231.130240551.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 7/7] Allow unwind_stack() to return ra for leaf function
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44D0D942.5050809@innova-card.com>
References: <44D0A3B0.40601@innova-card.com>
	<20060803.010000.25909906.anemo@mba.ocn.ne.jp>
	<44D0D942.5050809@innova-card.com>
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
X-archive-position: 12165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 02 Aug 2006 18:56:34 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > Just one comment: no need to do "pc = pc != ra ? ra : 0" anymore.
> > Just "pc = ra" is enough, isn't it?
> 
> Well I let it just for cases where the caller does not reset ra
> after the first call. It should be safter. But I can remove it if
> you want.

OK, I see.  No problem.

---
Atsushi Nemoto
