Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2006 10:07:46 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:47248 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20039128AbWJPJHo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Oct 2006 10:07:44 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 16 Oct 2006 18:07:43 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 3E1BB4186A;
	Mon, 16 Oct 2006 18:07:41 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 330434185E;
	Mon, 16 Oct 2006 18:07:41 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9G97eW0051719;
	Mon, 16 Oct 2006 18:07:40 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 16 Oct 2006 18:07:40 +0900 (JST)
Message-Id: <20061016.180740.88700024.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <45334765.6000805@innova-card.com>
References: <45333CC1.3090704@innova-card.com>
	<20061016.171046.55511403.nemoto@toshiba-tops.co.jp>
	<45334765.6000805@innova-card.com>
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
X-archive-position: 12960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 16 Oct 2006 10:48:37 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> thanks but it doesn't explain anything either...Anyways what about this
> patch on top of the previous one ?

> +	initrd_header = __va(PAGE_ALIGN(__pa_symbol(&_end) + sizeof(u32) * 2 + 1));

This breaks the addinitrd.  You mean this perhaps?

initrd_header = __va(PAGE_ALIGN(__pa_symbol(&_end) + sizeof(u32) * 2)) - sizeof(u32) * 2;


BTW, I'm a bit uncomfortable with current automatic initrd detection.
Now we have rd_start= option.  If I enabled BLK_DEV_INITRD and did
pass nfsroot= instead of rd_start= option, I want kernel do not search
initrd_header at all.  Note that in this case current kernel might
misdetect initrd_header from garbage beyond "_end".

I think something like CONFIG_INITRD_AUTODETECT to control this
behaviour is useful.  What do you think?

---
Atsushi Nemoto
