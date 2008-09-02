Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Sep 2008 14:45:08 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:20457 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20035932AbYIBNpG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Sep 2008 14:45:06 +0100
Received: from localhost (p4152-ipad313funabasi.chiba.ocn.ne.jp [123.217.230.152])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 118AAB599; Tue,  2 Sep 2008 22:45:02 +0900 (JST)
Date:	Tue, 02 Sep 2008 22:45:07 +0900 (JST)
Message-Id: <20080902.224507.128619319.anemo@mba.ocn.ne.jp>
To:	Geert.Uytterhoeven@sonycom.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 3/6] TXx9: IOC LED support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64.0809011821170.5424@anakin>
References: <1220275361-5001-3-git-send-email-anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64.0809011821170.5424@anakin>
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
X-archive-position: 20405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 1 Sep 2008 18:28:29 +0200 (CEST), Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> If I'm correct LED4 and LED5 are not connected to the IOC, but to the
> PIO of the TX4927. Do you have a driver for those LEDs, too?
> Perhaps I just missed it, I only applied this single patch.

Done ;)

Note that the patch depends on some patches in linux-queue tree, but
it would be simple enough so that you can apply it manually.

---
Atsushi Nemoto
