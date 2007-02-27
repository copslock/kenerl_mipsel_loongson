Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2007 14:56:51 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:8165 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039154AbXB0O4p (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Feb 2007 14:56:45 +0000
Received: from localhost (p6238-ipad203funabasi.chiba.ocn.ne.jp [222.146.85.238])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C309AA00D; Tue, 27 Feb 2007 23:55:23 +0900 (JST)
Date:	Tue, 27 Feb 2007 23:55:23 +0900 (JST)
Message-Id: <20070227.235523.25910390.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	ralf@linux-mips.org, jeff@garzik.org,
	michal.k.k.piotrowski@gmail.com, pg@cs.stanford.edu,
	ahennessy@mvista.com, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: possible bug in net/tc35815.c in linux-2.6.19
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <45E33E13.7010007@ru.mvista.com>
References: <20070226102659.GA28439@linux-mips.org>
	<20070226.200554.125898248.nemoto@toshiba-tops.co.jp>
	<45E33E13.7010007@ru.mvista.com>
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
X-archive-position: 14256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 26 Feb 2007 23:07:47 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
>     Yeah, tc35815_1.c in our looks like the one in the CELF archive (what I 
> didn't get is why they decided to keep both drivers around?)

I think tc35815_1.c can just replace old tc35815.c.  New one lacks
tc35815_killall() which is currently called by arch/mips/jmr3927 code,
but there would be no point doing a such thing.  arch/mips/jmr3927
should be fixed.

>     I think everybody would be just thankful. :-)

OK, I'll prepare a patch after some cleanup.

---
Atsushi Nemoto
