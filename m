Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Aug 2006 15:09:56 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:2267 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038460AbWHSOJy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 19 Aug 2006 15:09:54 +0100
Received: from localhost (p4121-ipad212funabasi.chiba.ocn.ne.jp [58.91.168.121])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1FCB7A9F7; Sat, 19 Aug 2006 23:09:48 +0900 (JST)
Date:	Sat, 19 Aug 2006 23:11:32 +0900 (JST)
Message-Id: <20060819.231132.25910211.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	mlachwani@mvista.com
Subject: Re: [PATCH] TX49 has write buffer
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44E64687.7000704@ru.mvista.com>
References: <44E64687.7000704@ru.mvista.com>
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
X-archive-position: 12372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 19 Aug 2006 03:00:23 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> TX49 CPUs have a write buffer, so we need to select CPU_HAS_WB -- otherwise 
> all Toshiba RBTX49xx kernels fail to build.

TX49 CPUs also have a SYNC instruction which flushes a write buffer.
I think it is enough and wbflush() have been abused in
arch/mips/tx4927/ and arch/mips/tx4938/ codes.

There is old thread about this issue:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=Pine.GSO.3.96.1030415161611.13254H-100000%40delta.ds2.pg.gda.pl

---
Atsushi Nemoto
