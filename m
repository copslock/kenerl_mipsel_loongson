Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2006 16:52:42 +0200 (CEST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:29682 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133865AbWEWOwe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 May 2006 16:52:34 +0200
Received: from localhost (p6133-ipad03funabasi.chiba.ocn.ne.jp [219.160.86.133])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B2AB4B44F; Tue, 23 May 2006 23:52:30 +0900 (JST)
Date:	Tue, 23 May 2006 23:53:20 +0900 (JST)
Message-Id: <20060523.235320.39154614.anemo@mba.ocn.ne.jp>
To:	mchitale@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: oprofile for mips
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <d096a3ee0605230133l60a8b5uc74fad7e479752e@mail.gmail.com>
References: <d096a3ee0605230133l60a8b5uc74fad7e479752e@mail.gmail.com>
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
X-archive-position: 11525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 23 May 2006 14:03:22 +0530, "Mayuresh Chitale" <mchitale@gmail.com> wrote:
> I am trying to cross compile oprofile for mips. I get an error:
> 
> configure: error: bfd library not found when configuring.

As shown in the error message, you need libbfd to compile oprofile.
The libbfd is provided by binutils (or some other tools).  While you
need objdump to run oprofile (see opcontrol script), you must have
MIPS native binutils anyway.

---
Atsushi Nemoto
