Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Dec 2006 16:53:36 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:39925 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037479AbWLCQxb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 3 Dec 2006 16:53:31 +0000
Received: from localhost (p6165-ipad201funabasi.chiba.ocn.ne.jp [222.146.69.165])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id CBF0CC0CE
	for <linux-mips@linux-mips.org>; Mon,  4 Dec 2006 01:53:27 +0900 (JST)
Date:	Mon, 04 Dec 2006 01:53:27 +0900 (JST)
Message-Id: <20061204.015327.36921579.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Use conditional traps for BUG_ON on MIPS II and better.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20037651AbWK3BXW/20061130012322Z+10503@ftp.linux-mips.org>
References: <S20037651AbWK3BXW/20061130012322Z+10503@ftp.linux-mips.org>
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
X-archive-position: 13330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 30 Nov 2006 01:23:17 +0000, linux-mips@linux-mips.org wrote:
> Author: Ralf Baechle <ralf@linux-mips.org> Mon Oct 16 01:38:50 2006 +0100
> Commit: 17243c78ae5f25c8901da05ca4eab0968dddb16f
> Gitweb: http://www.linux-mips.org/g/linux/17243c78
> Branch: master
> 
> This shaves of around 4kB and a few cycles for the average kernel that
> has CONFIG_BUG enabled.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

It seems this commit break QEMU kernel ...  or QEMU can not interpret
the TNE instruction correctly?

---
Atsushi Nemoto
