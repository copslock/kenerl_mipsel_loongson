Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2006 10:11:41 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:49797 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037748AbWHRJLk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Aug 2006 10:11:40 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 18 Aug 2006 18:11:38 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 35A41202F1;
	Fri, 18 Aug 2006 18:11:37 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 281BC202D2;
	Fri, 18 Aug 2006 18:11:37 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k7I9BaW0089027;
	Fri, 18 Aug 2006 18:11:36 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 18 Aug 2006 18:11:36 +0900 (JST)
Message-Id: <20060818.181136.85412687.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove mfinfo[64] used by get_wchan()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44E57F39.2020009@innova-card.com>
References: <44E57161.5060104@innova-card.com>
	<20060818.171558.89065994.nemoto@toshiba-tops.co.jp>
	<44E57F39.2020009@innova-card.com>
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
X-archive-position: 12362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 18 Aug 2006 10:50:01 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Does something like this seem correct ? If an exception occured on a first
> instruction of a function, show_backtrace() will call get_frame_info()
> with info->func_size != 0 but very small. In this case it returns 1.

Why get_frame_info() will be called with info->func_size != 0 ?  The
offset of a _first_ instruction is 0, so "ofs" of this line in
unwind_stack() will be 0.

	info.func_size = ofs;	/* analyze from start to ofs */

---
Atsushi Nemoto
