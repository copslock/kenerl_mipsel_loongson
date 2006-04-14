Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Apr 2006 04:02:24 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:43648 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133715AbWDNDCM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Apr 2006 04:02:12 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 14 Apr 2006 12:14:17 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id C3535207B3;
	Fri, 14 Apr 2006 12:14:15 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id AEA0D20257;
	Fri, 14 Apr 2006 12:14:15 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k3E3EF4D071113;
	Fri, 14 Apr 2006 12:14:15 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 14 Apr 2006 12:14:15 +0900 (JST)
Message-Id: <20060414.121415.130240785.nemoto@toshiba-tops.co.jp>
To:	geoffrey.levand@am.sony.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] local_r4k_flush_cache_page fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <443F111C.2000302@am.sony.com>
References: <20060201.000356.25911337.anemo@mba.ocn.ne.jp>
	<20060313.182303.115641770.nemoto@toshiba-tops.co.jp>
	<443F111C.2000302@am.sony.com>
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
X-archive-position: 11095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 13 Apr 2006 20:03:56 -0700, Geoff Levand <geoffrey.levand@am.sony.com> wrote:
> Nemoto-san,
> 
> Your changes caused me some problems with linux-2.6.16.1 on tx4937:

Yes, it's my mistake.  I posted a patch on 4 Apr and the fix is in
linux-mips.org git tree.  (both master and linux-2.6.16-stable
branch).

---
Atsushi Nemoto
