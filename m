Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2007 09:07:26 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:2701 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022668AbXENIHW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 May 2007 09:07:22 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 14 May 2007 17:07:21 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 5F35342170;
	Mon, 14 May 2007 17:07:19 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 52C69204C3;
	Mon, 14 May 2007 17:07:19 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l4E87GW0098805;
	Mon, 14 May 2007 17:07:18 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 14 May 2007 17:07:16 +0900 (JST)
Message-Id: <20070514.170716.18313509.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
Subject: Re: [PATCH] MIPS: Run checksyscalls for N32 and O32 ABI
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80705140055r1c3d8431v7be5f805d7dea1db@mail.gmail.com>
References: <cda58cb80705140023w2829d86y662e6fa957b3734c@mail.gmail.com>
	<20070514.164650.126759873.nemoto@toshiba-tops.co.jp>
	<cda58cb80705140055r1c3d8431v7be5f805d7dea1db@mail.gmail.com>
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
X-archive-position: 15057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 14 May 2007 09:55:01 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > Without that, fresh build will fail because missing-syscalls target
> > requires include/asm, etc.
> 
> yes but from top makefile, we already have this depedency:
> 
>         $ grep archprepare: Makefile
>         archprepare: prepare1 scripts_basic

Yes, and arch Makefile is included _before_ the line.  So "make" will
try to build arch-missing-syscalls before prepare1.

We must tell "make" to build prepare1 _before_ arch-missing-syscalls.

---
Atsushi Nemoto
