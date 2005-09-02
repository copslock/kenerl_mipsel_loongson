Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2005 13:41:24 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:43782
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225325AbVIBMlB>; Fri, 2 Sep 2005 13:41:01 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 2 Sep 2005 12:49:03 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id B27D61FE03;
	Fri,  2 Sep 2005 21:48:59 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 9E5D41797B;
	Fri,  2 Sep 2005 21:48:59 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j82Cmxoj003054;
	Fri, 2 Sep 2005 21:48:59 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 02 Sep 2005 21:48:59 +0900 (JST)
Message-Id: <20050902.214859.122594668.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: custom ide driver causes "Badness in smp_call_function"
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050826141047.GA8777@linux-mips.org>
References: <20050825154249.GC2731@linux-mips.org>
	<20050825211218Z8225471-3678+7505@linux-mips.org>
	<20050826141047.GA8777@linux-mips.org>
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
X-archive-position: 8864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 26 Aug 2005 15:10:47 +0100, Ralf Baechle <ralf@linux-mips.org> said:
ralf> Try this patch below and let me know.  I would also like to ask
ralf> those people who used to suffer from aliases with IDE PIO to try
ralf> this patch.

I'm using CPU which suffer from dcache aliasing.
I tried this patch for IDE PIO and it seems work fine too.

Maybe Cobalt user can try it.  Anyone?  :-)

---
Atsushi Nemoto
