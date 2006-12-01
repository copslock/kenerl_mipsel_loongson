Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 15:22:23 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:58589 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038329AbWLAPWS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2006 15:22:18 +0000
Received: from localhost (p7250-ipad213funabasi.chiba.ocn.ne.jp [124.85.72.250])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4C9B6BFBB; Sat,  2 Dec 2006 00:22:14 +0900 (JST)
Date:	Sat, 02 Dec 2006 00:22:14 +0900 (JST)
Message-Id: <20061202.002214.51866784.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org
Subject: Re: Is _do_IRQ() not needed anymore ?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <45704569.8000807@ru.mvista.com>
References: <cda58cb80612010206r51d319a1x72105981d900068a@mail.gmail.com>
	<20061201.191049.63741937.nemoto@toshiba-tops.co.jp>
	<45704569.8000807@ru.mvista.com>
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
X-archive-position: 13301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 01 Dec 2006 18:08:25 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > You can use both irq_cpu and i8259 same time. :)
> 
>     What's wrong with 8259 I wonder? It's happily converted to genirq by other 
> arches...

Indeed.  I missed other arch's i8259.c had changed.  Maybe we should
update i8259.c entirely.

---
Atsushi Nemoto
