Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 11:12:59 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:12182 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037868AbWLALMz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Dec 2006 11:12:55 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 1 Dec 2006 20:12:54 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id B026940022;
	Fri,  1 Dec 2006 20:12:52 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id A5DC63EEA7;
	Fri,  1 Dec 2006 20:12:52 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id kB1BCqW0064892;
	Fri, 1 Dec 2006 20:12:52 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 01 Dec 2006 20:12:52 +0900 (JST)
Message-Id: <20061201.201252.18306502.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Is _do_IRQ() not needed anymore ?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80612010303x2bedf5betb11959158b292965@mail.gmail.com>
References: <cda58cb80612010219p50334a6cj4a797dcd608376ed@mail.gmail.com>
	<20061201.194102.89066483.nemoto@toshiba-tops.co.jp>
	<cda58cb80612010303x2bedf5betb11959158b292965@mail.gmail.com>
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
X-archive-position: 13289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 1 Dec 2006 12:03:54 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > Also, if you selected GENERIC_HARDIRQS_NO__DO_IRQ, you can remove .end
> > handler.  But adding "#ifdef GENERIC_HARDIRQS_NO__DO_IRQ" for each
> > .end might be slightly ugly...
> 
> why not simply removing it since it won't be used anymore ?

Indeed.  If the irq chip was always used with flow handler we can
remove it.

---
Atsushi Nemoto
