Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Feb 2009 16:53:30 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:44241 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21103570AbZBHQx0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 8 Feb 2009 16:53:26 +0000
Received: from localhost (p1245-ipad401funabasi.chiba.ocn.ne.jp [123.217.235.245])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 453BAA7F2; Mon,  9 Feb 2009 01:53:19 +0900 (JST)
Date:	Mon, 09 Feb 2009 01:53:21 +0900 (JST)
Message-Id: <20090209.015321.25909754.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH] ide: Add tx4938ide driver (v2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <498EC790.9070403@ru.mvista.com>
References: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
	<498EC5BA.4080002@ru.mvista.com>
	<498EC790.9070403@ru.mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 08 Feb 2009 14:52:48 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >> +    __ide_flush_dcache_range((unsigned long)buf, count * 2);
> >> +}
> >
> >   Atsushi, does TX49 really suffer from the issue that these flushes 
> > are trying to address?
> 
>    Well, looking thru the TX4939 thread, it appears that I've asked this 
> question already. Isn't this related to VIVT caches?

No, TX49 has VIPT cache.  It is related to D-cache aliasing on PIO.
My first attempt to fix this issue goes back to 2004:

http://www.linux-mips.org/archives/linux-mips/2004-03/msg00185.html

And more generic lengthy discussion can be found on (as mentioned in
the previous tx4939 thread):

http://lkml.org/lkml/2006/1/13/156

---
Atsushi Nemoto
