Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2006 14:57:31 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:25054 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037526AbWHUN53 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 Aug 2006 14:57:29 +0100
Received: from localhost (p7064-ipad03funabasi.chiba.ocn.ne.jp [219.160.87.64])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 67DECAEA2; Mon, 21 Aug 2006 22:57:24 +0900 (JST)
Date:	Mon, 21 Aug 2006 22:59:10 +0900 (JST)
Message-Id: <20060821.225910.108307053.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] qemu does not have dcache aliases
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0608211340120.17504@blysk.ds.pg.gda.pl>
References: <20060820.003338.25478178.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0608211340120.17504@blysk.ds.pg.gda.pl>
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
X-archive-position: 12379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 21 Aug 2006 13:45:03 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>  Hmm, it looks like a bug in QEMU -- we should definitely implement them!

Well, the QEMU cpu has 2-way 2kB dcache... does not have aliasing
anyway. :-)

Or we can just remove cpu_has_dc_aliases from the file and use generic
definition.

---
Atsushi Nemoto
