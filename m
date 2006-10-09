Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2006 16:49:40 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:36329 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039682AbWJIPtf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Oct 2006 16:49:35 +0100
Received: from localhost (p4240-ipad02funabasi.chiba.ocn.ne.jp [61.207.151.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 618C6AF92; Tue, 10 Oct 2006 00:49:27 +0900 (JST)
Date:	Tue, 10 Oct 2006 00:51:42 +0900 (JST)
Message-Id: <20061010.005142.03977034.anemo@mba.ocn.ne.jp>
To:	ths@networkno.de
Cc:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] setup.c: introduce __pa_symbol() and get ride of
 CPHYSADDR()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061009145817.GB18308@networkno.de>
References: <20061009132131.GA18308@networkno.de>
	<452A5BEA.2060500@innova-card.com>
	<20061009145817.GB18308@networkno.de>
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
X-archive-position: 12851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 9 Oct 2006 15:58:17 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > do you mean "it allows to use only 2 'lui' instructions to load
> > a symbol address into a register" ?
> 
> It allows a 2-instruction "lui ; addiu" sequence instead of a
> 6-instruction "lui ; lui ; addiu ; addiu ; dsll32 ; addu" sequence.

Just for clarification: IIRC this optimization needs somewhat
up-to-date binutils/gcc and is not enabled on current lmo kernel,
right?

---
Atsushi Nemoto
