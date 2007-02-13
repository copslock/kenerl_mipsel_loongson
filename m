Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 16:07:45 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:35787 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039266AbXBMQHi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Feb 2007 16:07:38 +0000
Received: from localhost (p7211-ipad32funabasi.chiba.ocn.ne.jp [221.189.139.211])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CBE46D31; Wed, 14 Feb 2007 01:06:15 +0900 (JST)
Date:	Wed, 14 Feb 2007 01:06:15 +0900 (JST)
Message-Id: <20070214.010615.101715999.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org
Subject: Re: More __get_user_asm_ll32 ...
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070213133251.GA7518@linux-mips.org>
References: <20070213133251.GA7518@linux-mips.org>
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
X-archive-position: 14074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 13 Feb 2007 13:32:51 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> __get_user_asm_ll32 contains a junk move %0, $0 left over from an older
> version of the code.  Ignoring fixups code and data this instruction
> inflates the normal path in __get_user() by 50% which may explain much of
> the size and performance you have meassures.  It also always clears
> the error return, iow. __get_user_asm_ll32(..., &<something 64-bit>)
> would never have returned an error.  ARGH.

Why is it clears the error return?  The "3:" label is just after the
junk move.

---
Atsushi Nemoto
