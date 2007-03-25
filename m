Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2007 18:08:27 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:29438 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022647AbXCYRIZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Mar 2007 18:08:25 +0100
Received: from localhost (p7179-ipad25funabasi.chiba.ocn.ne.jp [220.104.85.179])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 93041B821; Mon, 26 Mar 2007 02:07:05 +0900 (JST)
Date:	Mon, 26 Mar 2007 02:07:05 +0900 (JST)
Message-Id: <20070326.020705.63742150.anemo@mba.ocn.ne.jp>
To:	kumba@gentoo.org
Cc:	linux-mips@linux-mips.org, ths@networkno.de, ralf@linux-mips.org
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4606AA74.3070907@gentoo.org>
References: <46062400.8080307@gentoo.org>
	<20070326.011000.75185255.anemo@mba.ocn.ne.jp>
	<4606AA74.3070907@gentoo.org>
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
X-archive-position: 14676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 25 Mar 2007 12:59:32 -0400, Kumba <kumba@gentoo.org> wrote:
> > So I think Franck's approach, which enables -msym32 and defines
> > KBUILD_64BIT_SYM32 automatically if load-y was CKSEG0, is better.  Are
> > there any problem with his patchset?
> 
> I missed the other two additions to this patch, which is probably why it didn't 
> work :)  Taken as a whole, they also boot my O2 now.

Thanks, good news!

And Ralf's number shows that we can use -msym32 even for IP27.
Another good news.

---
Atsushi Nemoto
