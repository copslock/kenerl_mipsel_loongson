Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2007 14:07:39 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:24778 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023621AbXGMNHg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Jul 2007 14:07:36 +0100
Received: from localhost (p3184-ipad31funabasi.chiba.ocn.ne.jp [221.189.127.184])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8671AADEF; Fri, 13 Jul 2007 22:06:16 +0900 (JST)
Date:	Fri, 13 Jul 2007 22:07:11 +0900 (JST)
Message-Id: <20070713.220711.61510713.anemo@mba.ocn.ne.jp>
To:	post@pfrst.de
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Use NULL for pointer
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.21.0707130135090.1523-100000@Opal.Peter>
References: <20070713.014949.55147875.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.21.0707130135090.1523-100000@Opal.Peter>
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
X-archive-position: 15767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 13 Jul 2007 01:50:07 +0200 (CEST), post@pfrst.de wrote:
> Please excuse me, i couldn't restrain myself from commenting on this.
> It's a pity, that a weird warning (which gcc version with what settings
> did produce it ?) urges one to (re-)introduce this obsolescent macro.

The warning is produced by sparse, not gcc.

http://www.kernel.org/pub/software/devel/sparse/

I know C++ dislike NULL, but it seems kernel developpers like NULL for
a null pointer.  There is another way to convert a pointer to a bool:

		action = board_be_handler(regs, !!fixup);

It might satisfy both people, but might surprise other people a bit :)

---
Atsushi Nemoto
