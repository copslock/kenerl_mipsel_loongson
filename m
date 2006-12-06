Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 01:39:30 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:45621 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20039130AbWLFBj0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Dec 2006 01:39:26 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 6 Dec 2006 10:39:25 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id C268E3EEB0;
	Wed,  6 Dec 2006 10:39:23 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id B689F20485;
	Wed,  6 Dec 2006 10:39:23 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id kB61dNW0084581;
	Wed, 6 Dec 2006 10:39:23 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 06 Dec 2006 10:39:23 +0900 (JST)
Message-Id: <20061206.103923.71086192.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061205195702.GA2097@linux-mips.org>
References: <20061206.012311.86891097.anemo@mba.ocn.ne.jp>
	<20061205194907.GA1088@linux-mips.org>
	<20061205195702.GA2097@linux-mips.org>
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
X-archive-position: 13359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 5 Dec 2006 19:57:02 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > > Import many updates from i386's i8259.c, especially genirq
> > > transitions.
> > 
> > With this patch applied Malta fails ...
> 
> Which meant I removed this patch from my tree for now.  Which means nothing
> is blocking Franck's patch anymore so I applied it with a trivial build fix
> to irq_cpu.c.

Ah ... could you tell me how Malta failed?

BTW, your additional irq_cpu.c might have another problem.  The
mips_mt_cpu_irq_controller have not used flow handler yet.  I did not
change it since I could not see which flow handler (handle_level_irq
or handle_percpu_irq) are suitable at the time.

---
Atsushi Nemoto
