Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 09:49:10 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:38505 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20039798AbWJJItH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Oct 2006 09:49:07 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 10 Oct 2006 17:49:05 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id A87D84194C;
	Tue, 10 Oct 2006 17:49:02 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 9B134418D8;
	Tue, 10 Oct 2006 17:49:02 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9A8n1W0025808;
	Tue, 10 Oct 2006 17:49:01 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 10 Oct 2006 17:49:01 +0900 (JST)
Message-Id: <20061010.174901.25477190.nemoto@toshiba-tops.co.jp>
To:	ths@networkno.de
Cc:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] setup.c: introduce __pa_symbol() and get ride of
 CPHYSADDR()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061009165920.GC18308@networkno.de>
References: <20061009145817.GB18308@networkno.de>
	<20061010.005142.03977034.anemo@mba.ocn.ne.jp>
	<20061009165920.GC18308@networkno.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 9 Oct 2006 17:59:20 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > Just for clarification: IIRC this optimization needs somewhat
> > up-to-date binutils/gcc and is not enabled on current lmo kernel,
> > right?
> 
> For old toolchains there used to be a gruesome hack (which AFAIR broke
> at some point), for modern toolchains there's -msym32.

Hmm, I found that the -msym32 is enabled if BUILD_ELF64 was not
selected, since 2.6.17.  But does CONFIG_BUILD_ELF64=n really work for
modules?  While MAP_BASE is 0xc000000000000000 for most 64-bit
platforms, I suppose modules should not be compiled with -msym32.

---
Atsushi Nemoto
