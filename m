Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Mar 2004 13:41:16 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:13265 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225625AbUC0NlN>; Sat, 27 Mar 2004 13:41:13 +0000
Received: from localhost (p6128-ipad25funabasi.chiba.ocn.ne.jp [220.104.84.128])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2488864F4; Sat, 27 Mar 2004 22:41:06 +0900 (JST)
Date: Sat, 27 Mar 2004 22:49:52 +0900 (JST)
Message-Id: <20040327.224952.74755860.anemo@mba.ocn.ne.jp>
To: pdh@colonel-panic.org
Cc: phorton@bitbox.co.uk, linux-mips@linux-mips.org
Subject: Re: missing flush_dcache_page call in 2.4 kernel
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040326184317.GA3661@skeleton-jack>
References: <4062F1A1.9070005@bitbox.co.uk>
	<20040326.122258.41628012.nemoto@toshiba-tops.co.jp>
	<20040326184317.GA3661@skeleton-jack>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 26 Mar 2004 18:43:17 +0000, Peter Horton <pdh@colonel-panic.org> said:

>> I'm quite sure that it's a kernel bug and may cause problems if any
>> PIO block device (PIO ide, ide-cs, mtdblock, etc.) are used on CPUs
>> which have d-cache aliases (not only MIPS).  We need a correct fix
>> ...

pdh> True. A proper fix would flush the relevant page after PIO
pdh> transfers into the page cache / swap pages. Unfortunately this
pdh> would require a hook in the generic kernel.

I found somewhat long discussions in linux-kernel ML.

Subject: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at least))
http://www.ussg.iu.edu/hypermail/linux/kernel/0305.2/1205.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0305.3/0151.html

Still I do not understand whole story on the thread, David S. Miller
said that architecture defined IDE insw/outsw macro should do the
flushing in this case, if I understand correctly.  Definitely sparc64
__ide_insw do it.  Hmm ...

---
Atsushi Nemoto
