Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Nov 2009 18:19:31 +0100 (CET)
Received: from mba.ocn.ne.jp ([122.28.14.163]:52685 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492879AbZKGRTY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 7 Nov 2009 18:19:24 +0100
Received: from localhost (p6079-ipad307funabasi.chiba.ocn.ne.jp [123.217.184.79])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5C7D671C8; Sun,  8 Nov 2009 02:19:15 +0900 (JST)
Date:	Sun, 08 Nov 2009 02:19:14 +0900 (JST)
Message-Id: <20091108.021914.11603096.anemo@mba.ocn.ne.jp>
To:	dmitri.vorobiev@gmail.com
Cc:	macro@linux-mips.org, ddaney@caviumnetworks.com,
	linux-mips@linux-mips.org
Subject: Re: COMMAND_LINE_SIZE and CONFIG_FRAME_WARN
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <90edad820911061017y373cf1ale5f10b742d633b7d@mail.gmail.com>
References: <90edad820911060923w6cd59c5dh57d123b6bc9d4219@mail.gmail.com>
	<alpine.LFD.2.00.0911061726150.9725@eddie.linux-mips.org>
	<90edad820911061017y373cf1ale5f10b742d633b7d@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 6 Nov 2009 20:17:06 +0200, Dmitri Vorobiev <dmitri.vorobiev@gmail.com> wrote:
> I believe that Atsushi-san was talking about the MIPS code only.
> Indeed, he mentioned CL_SIZE, which used to be a MIPS-specific alias
> to COMMAND_LINE_SIZE.

Yes, and I think static array is safest option now.

MIPS might be able to use large stack on early bootstrap stage, but
this assumption looks slightly fragile for me.

And excessive zero-initialized __initdata size will not be a problem
especially if vmlinux is compressed.

Thank you everyone, I will post a patch soon.

---
Atsushi Nemoto
