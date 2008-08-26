Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 14:31:55 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:53498 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20031026AbYHZNbx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2008 14:31:53 +0100
Received: from localhost (p1241-ipad305funabasi.chiba.ocn.ne.jp [123.217.163.241])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E4A4EBE9F; Tue, 26 Aug 2008 22:31:49 +0900 (JST)
Date:	Tue, 26 Aug 2008 22:31:51 +0900 (JST)
Message-Id: <20080826.223151.119241970.anemo@mba.ocn.ne.jp>
To:	geert@linux-m68k.org
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Probe initrd header only if explicitly specified
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64.0808261527070.30735@anakin>
References: <20080826.221145.74565971.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64.0808261527070.30735@anakin>
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
X-archive-position: 20360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 26 Aug 2008 15:27:31 +0200 (CEST), Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > +		 * prepended to initrd and is made up by 8 bytes. The fisrt
>                                                                       ^^^^^
> 								      first
> (I know this typo existed before)

Thanks, I'll update soon.
---
Atsushi Nemoto
