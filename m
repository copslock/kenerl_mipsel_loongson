Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jul 2004 02:34:44 +0100 (BST)
Received: from [IPv6:::ffff:202.230.225.5] ([IPv6:::ffff:202.230.225.5]:61725
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225766AbUGOBei>; Thu, 15 Jul 2004 02:34:38 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 15 Jul 2004 01:34:37 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 721E1239E50; Thu, 15 Jul 2004 10:36:39 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i6F1YSwB080186;
	Thu, 15 Jul 2004 10:34:28 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 15 Jul 2004 10:34:44 +0900 (JST)
Message-Id: <20040715.103444.70224080.nemoto@toshiba-tops.co.jp>
To: dom@mips.com
Cc: ralf@linux-mips.org, KevinK@mips.com, theansweriz42@hotmail.com,
	linux-mips@linux-mips.org
Subject: Re: Strange, strange occurence
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <16629.24775.778491.754688@arsenal.mips.com>
References: <00ba01c46823$3729b200$0deca8c0@Ulysses>
	<20040713003317.GA26715@linux-mips.org>
	<16629.24775.778491.754688@arsenal.mips.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 14 Jul 2004 17:35:19 +0100, Dominic Sweetman <dom@mips.com> said:
dom> 2. Arrange to skip those indexes when zapping the cache, then do
dom> something weird to invalidate that handful of lines.  You could
dom> do that by running uncached, but you could also do it just by
dom> using some auxiliary routine which is known to be more than a
dom> cache line but much less than a whole I-cache span distant, so
dom> can't possibly alias to the same thing...

dom> This is fiddly, but not terribly difficult and should have a
dom> negligible performance impact.

Yes.  The cache routines for TX49XX surely do it (2 phase
invalidating).  Please look at tx49_blast_icache32() in c-r4k.c.

---
Atsushi Nemoto
