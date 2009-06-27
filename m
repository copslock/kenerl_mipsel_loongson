Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jun 2009 18:16:12 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:58288 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492678AbZF0QQF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Jun 2009 18:16:05 +0200
Received: from localhost (p8220-ipad202funabasi.chiba.ocn.ne.jp [222.146.79.220])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5E27480B8; Sun, 28 Jun 2009 01:11:43 +0900 (JST)
Date:	Sun, 28 Jun 2009 01:11:44 +0900 (JST)
Message-Id: <20090628.011144.85691440.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	KKylheku@zeugmasystems.com, aurelien@aurel32.net,
	linux-mips@linux-mips.org
Subject: Re: Broadcom Swarm support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20090628.010906.115909054.anemo@mba.ocn.ne.jp>
References: <20090627.225933.208964286.anemo@mba.ocn.ne.jp>
	<20090627154811.GA22264@linux-mips.org>
	<20090628.010906.115909054.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 28 Jun 2009 01:09:06 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Then, flush_cache_range or flush_cache_page should be called then the
                                                               ~~~~ when
> page was unmmapped, right?  How about flush_cache_mm?  It does not
> flush icache currently.

Oops, excuse me for my poor writing.

---
Atsushi Nemoto
