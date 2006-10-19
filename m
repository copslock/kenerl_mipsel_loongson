Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 11:30:57 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:10489 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037750AbWJSKaz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 11:30:55 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 19 Oct 2006 19:30:54 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id ACCDC4138C;
	Thu, 19 Oct 2006 19:30:51 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id A017E201D2;
	Thu, 19 Oct 2006 19:30:51 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9JAUoW0070371;
	Thu, 19 Oct 2006 19:30:50 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 19 Oct 2006 19:30:50 +0900 (JST)
Message-Id: <20061019.193050.39153762.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org,
	fbuihuu@gmail.com
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <45374B41.6060008@innova-card.com>
References: <453739B2.1010705@innova-card.com>
	<20061019.181508.15248454.nemoto@toshiba-tops.co.jp>
	<45374B41.6060008@innova-card.com>
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
X-archive-position: 13022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 19 Oct 2006 11:54:09 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > This does not work if PAGE_OFFSET was 0xffffffff80000000 and
> > initrd_start was 0x980000000XXXXXXX :-)
> > 
> 
> I think we should terminate this patch pretty quickly because
> it's going to make me mad ;)
> 
> How can PAGE_OFFSET be in CKSEG0 segment and initrd_start be
> in XKPHYS ?

If we passed a XKPHYS address to "rd_start=" option.  Bad usage :-)

> With the current code we can say:
> 
>   - If PAGE_OFFSET is in CKSEG0, that means that all kernel
>     virtual address must be in CKSEG0.
>   - If PAGE_OFFSET is in XKPHYS, that means that _after_ booting
>     process all kernel virtual address will be in XKPHYS. But we
>     allow CKSEG0 virtual address during boot for the reasons
>     we know.
>
> What woud give __pa(initrd_start) in your example ?
> 
> __pa(initrd_start) -> 0x980000000XXXXXXX - 0xffffffff80000000
> 
> which is wrong...Does your example come from a real use case ?

It's wrong indeed.  But I can not see good way to handle such terrible
usage.  So ... let's ignore it.  I'm OK, are you ?

---
Atsushi Nemoto
