Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2005 05:43:08 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:6950 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8133441AbVLEFml (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Dec 2005 05:42:41 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 5 Dec 2005 05:43:23 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id D80851F70C;
	Mon,  5 Dec 2005 14:43:19 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id C36BA1F1AB;
	Mon,  5 Dec 2005 14:43:19 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id jB55hJ4D035220;
	Mon, 5 Dec 2005 14:43:19 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 05 Dec 2005 14:43:19 +0900 (JST)
Message-Id: <20051205.144319.126575575.nemoto@toshiba-tops.co.jp>
To:	maillist@jg555.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Cobalt IDE Patch
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4393CE3B.20303@jg555.com>
References: <4393CE3B.20303@jg555.com>
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
X-archive-position: 9589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Sun, 04 Dec 2005 21:20:59 -0800, Jim Gifford <maillist@jg555.com> said:
jim> This is Peter Horton's IDE patch for the Cobalt. From the notes
jim> in Peter's file.

I suppose this patch is not required anymore since current
asm-mips/mach-generic/ide.h takes care of dcache aliases.

If Cobalt's IDE did not work with with the generic ide.h, it should be
fixed instead of adding one more ide.h.

---
Atsushi Nemoto
