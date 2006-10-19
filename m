Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 10:15:16 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:7721 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037675AbWJSJPO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 10:15:14 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 19 Oct 2006 18:15:13 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 5231141BCF;
	Thu, 19 Oct 2006 18:15:10 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 451D820D22;
	Thu, 19 Oct 2006 18:15:10 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9J9F8W0070122;
	Thu, 19 Oct 2006 18:15:09 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 19 Oct 2006 18:15:08 +0900 (JST)
Message-Id: <20061019.181508.15248454.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org,
	fbuihuu@gmail.com
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <453739B2.1010705@innova-card.com>
References: <1160743146503-git-send-email-fbuihuu@gmail.com>
	<20061019.131352.41630930.nemoto@toshiba-tops.co.jp>
	<453739B2.1010705@innova-card.com>
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
X-archive-position: 13019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 19 Oct 2006 10:39:14 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > +#ifdef CONFIG_64BIT
> > +		/* HACK: Guess if the sign extension was forgotten */
> > +		if (initrd_start < XKPHYS) {
> > +			initrd_end -= initrd_start;
> > +			initrd_start = (int)initrd_start;
> > +			initrd_end += initrd_start;
> > +		}
> > +#endif
>  
> BTW, what about this condition:
> 
> 		if (initrd_start < PAGE_OFFSET) {
> 			...;
> 		}
> 
> that would work even on 32 bits kernel.

This does not work if PAGE_OFFSET was 0xffffffff80000000 and
initrd_start was 0x980000000XXXXXXX :-)

if ((long)initrd_start >= 0) {

would work.

---
Atsushi Nemoto
