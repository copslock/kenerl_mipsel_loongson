Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 13:53:35 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:28149 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20029942AbYANNx1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Jan 2008 13:53:27 +0000
Received: from localhost (p1181-ipad210funabasi.chiba.ocn.ne.jp [58.88.120.181])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4270D8F11; Mon, 14 Jan 2008 22:53:23 +0900 (JST)
Date:	Mon, 14 Jan 2008 22:53:18 +0900 (JST)
Message-Id: <20080114.225318.63132741.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] prom_free_prom_memory for QEMU
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080114133701.GA16555@linux-mips.org>
References: <20080114.212253.126142719.anemo@mba.ocn.ne.jp>
	<20080114133701.GA16555@linux-mips.org>
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
X-archive-position: 18021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 14 Jan 2008 13:37:01 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> I was actually planning to remove the Qemu platform for 2.6.25.  The
> Malta emulation has become so good that there is no more point in having
> the underfeatured synthetic platform that CONFIG_QEMU is.
> 
> Objections?

The Qemu platform is one of officially supported platforms by Debian.
If Debian did not support the Malta yet, I hope qemu alive.

---
Atsushi Nemoto
