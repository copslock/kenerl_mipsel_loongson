Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 May 2007 16:00:29 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:11213 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022991AbXEBPA1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 May 2007 16:00:27 +0100
Received: from localhost (p6152-ipad211funabasi.chiba.ocn.ne.jp [58.91.162.152])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 12F89A6BE; Thu,  3 May 2007 00:00:22 +0900 (JST)
Date:	Thu, 03 May 2007 00:00:27 +0900 (JST)
Message-Id: <20070503.000027.25909441.anemo@mba.ocn.ne.jp>
To:	ths@networkno.de
Cc:	linux-mips@linux-mips.org
Subject: Re: Some potential FPU emulator problem
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070501225214.GE30083@networkno.de>
References: <20070501225214.GE30083@networkno.de>
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
X-archive-position: 14961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 1 May 2007 23:52:14 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> [<80042ed0>] force_sig_info+0xa4/0xf8
> [<80017f1c>] do_tr+0xb4/0x134
> [<800111e0>] ret_from_exception+0x0/0x20
> [<80021dac>] ieee754sp_format+0x28/0x50c
> [<80027e14>] ieee754sp_fdp+0x94/0x3d0
> [<80020194>] fpu_emulator_cop1Handler+0x1334/0x1b40
> [<80017934>] do_cpu+0x344/0x380
> [<800111e0>] ret_from_exception+0x0/0x20

Is this kernel contain commit ba755f8ec80fdbf2b5212622eabf7355464c6327 ?
I suppose the fix might show you a little bit better result.

> Without this patch the same configuration boot fine. I don't know i
> f this just means one of the asserts is broken or if there is
> something wrong with the FPU emulation.

Perhaps the triggered assert() is the first one in ieee754sp_format(),
but I do not know if it was a proper test...

---
Atsushi Nemoto
