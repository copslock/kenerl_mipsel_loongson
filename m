Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 15:49:43 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:7413 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022808AbXCZOtl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2007 15:49:41 +0100
Received: from localhost (p8030-ipad27funabasi.chiba.ocn.ne.jp [220.107.199.30])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EA8238BEC; Mon, 26 Mar 2007 23:48:21 +0900 (JST)
Date:	Mon, 26 Mar 2007 23:48:21 +0900 (JST)
Message-Id: <20070326.234821.30439266.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, kumba@gentoo.org, linux-mips@linux-mips.org,
	ths@networkno.de
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80703260654u4435b90axa28507f6c9011c00@mail.gmail.com>
References: <4606AA74.3070907@gentoo.org>
	<20070325221919.GA12088@linux-mips.org>
	<cda58cb80703260654u4435b90axa28507f6c9011c00@mail.gmail.com>
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
X-archive-position: 14697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 26 Mar 2007 15:54:03 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> You were asked several times why this patchset have not been
> considerated without any answers. So I have no clue why it's broken.

One thing I noticed recently: Your patchset dropped gcc test for
availability of -msym32, so may not work with gcc 3.x.

---
Atsushi Nemoto
