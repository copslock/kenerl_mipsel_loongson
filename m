Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 16:46:34 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:15587 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022838AbXCZPqc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2007 16:46:32 +0100
Received: from localhost (p8030-ipad27funabasi.chiba.ocn.ne.jp [220.107.199.30])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BA6E19567; Tue, 27 Mar 2007 00:45:11 +0900 (JST)
Date:	Tue, 27 Mar 2007 00:45:11 +0900 (JST)
Message-Id: <20070327.004511.31449250.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, kumba@gentoo.org, linux-mips@linux-mips.org,
	ths@networkno.de
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80703260831t576ff7c5wef1e34e3367e7c45@mail.gmail.com>
References: <cda58cb80703260654u4435b90axa28507f6c9011c00@mail.gmail.com>
	<20070326.234821.30439266.anemo@mba.ocn.ne.jp>
	<cda58cb80703260831t576ff7c5wef1e34e3367e7c45@mail.gmail.com>
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
X-archive-position: 14699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 26 Mar 2007 17:31:18 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> I suspect you're asking why I did not do this:

Yes.

> I remove the call to cc-option because this function removes
> _silently_ '-msym32' option if it's not supported by the compiler. IOW
> it's really not what we want.
> 
> IIRC I haven't found an other function like 'cc-option-strict' which
> makes a compilation error in case.
> 
> So I assumed that the compiler will complain if it doesn't understand
> this option. But it may be incorrect. If so I can add an error message
> in Kbuild or add a new Kbuild helper. But I'd like to understand
> what's wrong with it before.

I think dropping gcc 3.x support for 64-bit kernel is not what we
wanted.  And -msym32 is just an optimization and kernel should be
buildable without it.  So "remove -msym32 silently" is not so bad, I
suppose.

"If you used newer compiler, you can get better result" is natural
thing, isn't it? ;)
---
Atsushi Nemoto
