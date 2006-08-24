Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Aug 2006 02:15:41 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:47169 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037823AbWHXBPj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 Aug 2006 02:15:39 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 24 Aug 2006 10:15:37 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id BC51520496;
	Thu, 24 Aug 2006 10:15:31 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id A95492000B;
	Thu, 24 Aug 2006 10:15:31 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k7O1FVW0014298;
	Thu, 24 Aug 2006 10:15:31 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 24 Aug 2006 10:15:31 +0900 (JST)
Message-Id: <20060824.101531.07643963.nemoto@toshiba-tops.co.jp>
To:	nigel@mips.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fix cache coherency issues
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44EC87C9.8010402@mips.com>
References: <20060523.003424.104640954.anemo@mba.ocn.ne.jp>
	<20060824.003130.25910593.anemo@mba.ocn.ne.jp>
	<44EC87C9.8010402@mips.com>
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
X-archive-position: 12422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 23 Aug 2006 17:52:25 +0100, Nigel Stephens <nigel@mips.com> wrote:
> Doesn't tlbidx need to be declared as a signed int, else the compiler
> could optimize away this comparison.

You are right.  I'll fix it.  Thanks.

---
Atsushi Nemoto
