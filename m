Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Aug 2006 12:38:47 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:16392 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038550AbWHXLip (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 Aug 2006 12:38:45 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 24 Aug 2006 20:38:43 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id DBB20203F3;
	Thu, 24 Aug 2006 20:38:38 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id C8CAE20332;
	Thu, 24 Aug 2006 20:38:38 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k7OBccW0016834;
	Thu, 24 Aug 2006 20:38:38 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 24 Aug 2006 20:38:38 +0900 (JST)
Message-Id: <20060824.203838.07455316.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	nigel@mips.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] fix cache coherency issues
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060824111515.GA4490@linux-mips.org>
References: <44EC87C9.8010402@mips.com>
	<20060824.101531.07643963.nemoto@toshiba-tops.co.jp>
	<20060824111515.GA4490@linux-mips.org>
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
X-archive-position: 12424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 24 Aug 2006 12:15:15 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> Your patch also still contains copy_user_page().  The only user of it used
> to be copy_user_highpage() so after our rewrite it can go away.  I've
> already applied both fixes to my working version of the patch.

Yes, it is intentional.  I keep copy_user_page() just because it is
described in cachetlb.txt and exported.

Of course we can remove it.  I do not care :-) Also I wondered we
should export copy_user_highpage() or not ...

> Your patch only maps the source page.  I'm trying to map the destination
> page also and I'm hitting a few issues with it.

If you wanted to map the destination, you must writeback the dcache
via kernel mapping first.  The dcache can contain dirty data for the
page by previous usage.  And if the page was executable, we must flush
the destination page after copy_page() (via coherent mapping) anyway
for I/D coherency.

So now I think mapping the destination is not worth to do.

---
Atsushi Nemoto
