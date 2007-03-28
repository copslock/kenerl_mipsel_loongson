Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 16:26:17 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:36565 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023097AbXC1P0M (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2007 16:26:12 +0100
Received: from localhost (p4133-ipad207funabasi.chiba.ocn.ne.jp [222.145.86.133])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F344EC660; Thu, 29 Mar 2007 00:24:52 +0900 (JST)
Date:	Thu, 29 Mar 2007 00:24:53 +0900 (JST)
Message-Id: <20070329.002453.18311528.anemo@mba.ocn.ne.jp>
To:	kumba@gentoo.org
Cc:	linux-mips@linux-mips.org, ths@networkno.de, ralf@linux-mips.org
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <460A6CED.1070308@gentoo.org>
References: <46086A90.7070402@gentoo.org>
	<20070327.235310.128618679.anemo@mba.ocn.ne.jp>
	<460A6CED.1070308@gentoo.org>
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
X-archive-position: 14757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 28 Mar 2007 09:26:05 -0400, Kumba <kumba@gentoo.org> wrote:
> Well, what's the need to use the move/lui/ld sequence over 
> move/lui/daddui/dsll/daddui/dsll//ld anyways?  I'll have to warm the Indy up and 
> try a 64bit kernel there I guess, to see if it exhibits similar issues with this 
> segment of code.

Just an optimization.  For CKSEG0 symbol, a LUI instruction can fill
high 32-bit by sign-extention.  Either code should work for CKSEG0
kernel.

---
Atsushi Nemoto
