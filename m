Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Jul 2008 16:05:38 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:12242 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28583437AbYGZPFb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 26 Jul 2008 16:05:31 +0100
Received: from localhost (p6083-ipad307funabasi.chiba.ocn.ne.jp [123.217.184.83])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0CE76AC55; Sun, 27 Jul 2008 00:05:26 +0900 (JST)
Date:	Sun, 27 Jul 2008 00:07:21 +0900 (JST)
Message-Id: <20080727.000721.108121385.anemo@mba.ocn.ne.jp>
To:	jason.wessel@windriver.com
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] kgdb: kgdboc serial_txx9 I/O module
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <488A0D6E.8090105@windriver.com>
References: <20080725.234914.41630045.anemo@mba.ocn.ne.jp>
	<488A0D6E.8090105@windriver.com>
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
X-archive-position: 19982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 25 Jul 2008 12:29:18 -0500, Jason Wessel <jason.wessel@windriver.com> wrote:
> > Implement the serial polling hooks for the serial_txx9 uart for use
> > with kgdboc.
> 
> Looks fine to me.
> 
> I pulled this into the kgdb-next branch, which I am working with Ralf to
> merge.

Thanks, excellent!

---
Atsushi Nemoto
