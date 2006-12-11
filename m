Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2006 04:40:33 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:4696 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038448AbWLKEk3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Dec 2006 04:40:29 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 11 Dec 2006 13:40:28 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 9347641525;
	Mon, 11 Dec 2006 13:40:24 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 8659520327;
	Mon, 11 Dec 2006 13:40:24 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id kBB4eOW0007811;
	Mon, 11 Dec 2006 13:40:24 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 11 Dec 2006 13:40:24 +0900 (JST)
Message-Id: <20061211.134024.41628345.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] Fix negative buffer overflow in copy_from_user
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061211.011647.41196525.anemo@mba.ocn.ne.jp>
References: <20061211.011647.41196525.anemo@mba.ocn.ne.jp>
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
X-archive-position: 13425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 11 Dec 2006 01:16:47 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> If we passed an invalid _and_ unaligned source address to
> copy_from_user(), the fault handling code miscalculates a length of
> uncopied bytes and returns a value greater than original length.  This
> also causes an negative buffer overflow and overwrites some bytes just
> before the destination kernel buffer.
> 
> This can happen "src_unaligned" case in memcpy.S.  If the first load
> from source buffer was a LDFIRST/LDREST (L[WD][RL]) instruction, it
> raise an exception and the THREAD_BUADDR will be an aligned address so
> it will _smaller_ than its real target address.

Sorry, this is wrong!  Please ignore this patch.

In this case THREAD_BUADDR should be an _unaligned_ address.  On QEMU
THREAD_BUADDR was an _aligned_ address so it might be a QEMU bug ...

---
Atsushi Nemoto
