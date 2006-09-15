Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2006 04:09:20 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:38605 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20027576AbWIODJQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Sep 2006 04:09:16 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 15 Sep 2006 12:09:15 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 762B52073D;
	Fri, 15 Sep 2006 12:09:08 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 6B5D5205D0;
	Fri, 15 Sep 2006 12:09:08 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k8F397W0015835;
	Fri, 15 Sep 2006 12:09:08 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 15 Sep 2006 12:09:07 +0900 (JST)
Message-Id: <20060915.120907.96686013.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, macro@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060914172805.GA1756@linux-mips.org>
References: <20060709.011259.92587435.anemo@mba.ocn.ne.jp>
	<20060710.234010.07457279.anemo@mba.ocn.ne.jp>
	<20060914172805.GA1756@linux-mips.org>
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
X-archive-position: 12576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 14 Sep 2006 18:28:05 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Add special short path for emulationg RDHWR which is used to support
> > TLS.  The handle_tlbl synthesizer takes a care for
> > cpu_has_vtag_icache.
> 
> I'm just wondering if we actually need such optimizations.  Have you ran
> any application benchmarks?

I've measured time of NPTL pthread_mutex_lock/pthread_mutex_unlock loop.

	pthread_mutex_init(&m, NULL);
	gettimeofday(&start, NULL);
	for (i = 0; i < 1000000; i++) {
		pthread_mutex_lock(&m);
		pthread_mutex_unlock(&m);
	}
	gettimeofday(&end, NULL);


Without optimization:
	0.826407 sec / 1000000 loop

With optimization:
	0.415667 sec / 1000000 loop

It would be worth to do.
---
Atsushi Nemoto
