Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 16:36:39 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:49867 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022566AbXGLPgg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Jul 2007 16:36:36 +0100
Received: from localhost (p7217-ipad201funabasi.chiba.ocn.ne.jp [222.146.70.217])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 29C84120B; Fri, 13 Jul 2007 00:36:33 +0900 (JST)
Date:	Fri, 13 Jul 2007 00:37:27 +0900 (JST)
Message-Id: <20070713.003727.08076834.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [MIPS] Enable support for the userlocal hardware register
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20023433AbXGIOIU/20070709140820Z+13176@ftp.linux-mips.org>
References: <S20023433AbXGIOIU/20070709140820Z+13176@ftp.linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 09 Jul 2007 15:08:15 +0100, linux-mips@linux-mips.org wrote:
> Which will cut down the cost of RDHWR $29 which is used to obtain the
> TLS pointer and so far being emulated in software down to a single cycle
> operation.

Since cpu_has_userlocal is used in a critical path (switch_to),
overriding in each cpu-feature-overrides.h might be expected.

---
Atsushi Nemoto
