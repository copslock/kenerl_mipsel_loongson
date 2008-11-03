Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Nov 2008 14:48:56 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:9183 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S23055173AbYKCOsy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 3 Nov 2008 14:48:54 +0000
Received: from localhost (p8106-ipad201funabasi.chiba.ocn.ne.jp [222.146.71.106])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E7EC0AF55; Mon,  3 Nov 2008 23:48:49 +0900 (JST)
Date:	Mon, 03 Nov 2008 23:48:56 +0900 (JST)
Message-Id: <20081103.234856.61509468.anemo@mba.ocn.ne.jp>
To:	n0-1@freewrt.org
Cc:	ralf@linux-mips.org, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: rb532: fix bit swapping in rb532_set_bit()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1225722625-19750-1-git-send-email-n0-1@freewrt.org>
References: <20081103142942.GA13461@nuty>
	<1225722625-19750-1-git-send-email-n0-1@freewrt.org>
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
X-archive-position: 21170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon,  3 Nov 2008 15:30:25 +0100, Phil Sutter <n0-1@freewrt.org> wrote:
> The algorithm works unconditionally. If bitval is one, the first line is
> a no op and the second line sets the bit at offset position. Vice versa,
> if bitval is zero, the first line clears the bit at offset position and
> the second line is a no op.

Well, the linux gpio framework uses 0 for low, _nonzero_ for high.
You should not assume the bitval is 0 or 1.

	val &= ~(!bitval << offset);   /* unset bit if bitval == 0 */
	val |= (!!bitval << offset);   /* set bit if bitval != 0 */

would be safe here.  Or you should ensure the bitval is 0 or 1
somewhere.

---
Atsushi Nemoto
