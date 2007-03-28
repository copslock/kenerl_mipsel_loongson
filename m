Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 16:15:57 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:43996 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023091AbXC1PPv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2007 16:15:51 +0100
Received: from localhost (p4133-ipad207funabasi.chiba.ocn.ne.jp [222.145.86.133])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CD924C5D8; Thu, 29 Mar 2007 00:14:29 +0900 (JST)
Date:	Thu, 29 Mar 2007 00:14:30 +0900 (JST)
Message-Id: <20070329.001430.27955371.anemo@mba.ocn.ne.jp>
To:	ilya@total-knowledge.com
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <46095A60.5070605@total-knowledge.com>
References: <46086A90.7070402@gentoo.org>
	<20070327.235310.128618679.anemo@mba.ocn.ne.jp>
	<46095A60.5070605@total-knowledge.com>
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
X-archive-position: 14754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 27 Mar 2007 10:54:40 -0700, "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com> wrote:
> Because we are too lazy to get HIGHMEM working in order to get
> support for all of its memory. Not to mention that HIGHMEM is Evil(TM).

Oh I see.  The 64-bit kernel should be a right thing.
---
Atsushi Nemoto
