Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2003 13:58:47 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:44833
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225072AbTD1M6p>; Mon, 28 Apr 2003 13:58:45 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 28 Apr 2003 12:58:43 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h3SCwaNr037503;
	Mon, 28 Apr 2003 21:58:36 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Mon, 28 Apr 2003 22:04:58 +0900 (JST)
Message-Id: <20030428.220458.21935076.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: nemoto@toshiba-tops.co.jp, linux-mips@linux-mips.org
Subject: Re: c-tx39.c build fix
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030428131605.A23461@linux-mips.org>
References: <20030428.191304.71084037.nemoto@toshiba-tops.co.jp>
	<20030428131605.A23461@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 28 Apr 2003 13:16:05 +0200, Ralf Baechle <ralf@linux-mips.org> said:
>> +#define scache_size 0
>> +#define scache_way_size 0

ralf> Not beautyful ...  but as you can imagine c-tx39.c is another
ralf> candidate for eventual integration into c-r4k.c, so applied.

Thanks!

Isn't c-tx39.c too different to integrate into c-r4k.c?

TX3927(TX39H2)'s cache is almost r4k but TX3912(TX39H)'s cache is
more limited.  It does not support writeback, Hit_Invalidate_I,
Hit_Writeback_*, Index_Writeback_* operations.

And both TX39H2/TX39H do not support Create_Dirty_Excl_D so
r4k_clear_page/r4k_copy_page can not be used for any TX39XX.

---
Atsushi Nemoto
