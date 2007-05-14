Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2007 14:29:50 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:20711 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023032AbXENN3r (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 May 2007 14:29:47 +0100
Received: from localhost (p6091-ipad25funabasi.chiba.ocn.ne.jp [220.104.84.91])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E1B09A549; Mon, 14 May 2007 22:29:39 +0900 (JST)
Date:	Mon, 14 May 2007 22:29:54 +0900 (JST)
Message-Id: <20070514.222954.69026129.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
Subject: Re: [PATCH] MIPS: Run checksyscalls for N32 and O32 ABI
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80705140332i79e8396braa008ddf878fb177@mail.gmail.com>
References: <cda58cb80705140055r1c3d8431v7be5f805d7dea1db@mail.gmail.com>
	<20070514.170716.18313509.nemoto@toshiba-tops.co.jp>
	<cda58cb80705140332i79e8396braa008ddf878fb177@mail.gmail.com>
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
X-archive-position: 15060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 14 May 2007 12:32:51 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> It seems that we can't rely on the order of the execution of megerd
> prerequisites...

Hmm, alphabetical order or something?  Anyway, adding the prerequisite
for arch-missing-syscalls should work though it seems a bit ugly.
---
Atsushi Nemoto
