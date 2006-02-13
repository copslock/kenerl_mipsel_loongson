Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2006 04:32:46 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:64718 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133354AbWBMEcf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Feb 2006 04:32:35 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 13 Feb 2006 13:38:48 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 5BE1F20379;
	Mon, 13 Feb 2006 13:38:46 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 500F62035E;
	Mon, 13 Feb 2006 13:38:46 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k1D4cj4D069638;
	Mon, 13 Feb 2006 13:38:45 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 13 Feb 2006 13:38:45 +0900 (JST)
Message-Id: <20060213.133845.15247873.nemoto@toshiba-tops.co.jp>
To:	kumba@gentoo.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.X] Early console for Cobalt
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <43F008B1.7070103@gentoo.org>
References: <20060212171025.GB1562@colonel-panic.org>
	<20060213.114359.07641583.nemoto@toshiba-tops.co.jp>
	<43F008B1.7070103@gentoo.org>
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
X-archive-position: 10414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Sun, 12 Feb 2006 23:18:57 -0500, Kumba <kumba@gentoo.org> said:
kumba> I already tried getting early printk to work....Either it
kumba> wasn't initializing early enough for my needs, I was enabling
kumba> it incorrectly, or it just doesn't work on Cobalt.  This does
kumba> work, however, and already pointed out one obvious flaw I have
kumba> in a patch I've been using on Cobalt (setting
kumba> cpu_scache_line_size to > 0 when cobalt lacks an scache).

Well, I do not have any objection to cobalt/console.c itself.  I just
mean let's use CONFIG_EARLY_PRINTK symbol instead of
CONFIG_COBALT_EARLY_CONSOLE (and add some other tweaks such as
implementing disable_early_printk()).

---
Atsushi Nemoto
