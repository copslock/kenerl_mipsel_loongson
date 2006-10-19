Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 12:00:31 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:1851 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037802AbWJSLA2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 12:00:28 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 19 Oct 2006 20:00:24 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id C3FF720D22;
	Thu, 19 Oct 2006 20:00:20 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id B992A2093B;
	Thu, 19 Oct 2006 20:00:20 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9JB0KW0070511;
	Thu, 19 Oct 2006 20:00:20 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 19 Oct 2006 20:00:20 +0900 (JST)
Message-Id: <20061019.200020.108120300.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org,
	fbuihuu@gmail.com
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <453758AF.2060109@innova-card.com>
References: <45374B41.6060008@innova-card.com>
	<20061019.193050.39153762.nemoto@toshiba-tops.co.jp>
	<453758AF.2060109@innova-card.com>
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
X-archive-position: 13024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 19 Oct 2006 12:51:27 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > If we passed a XKPHYS address to "rd_start=" option.  Bad usage :-)
> 
> ok so testing initrd_start against PAGE_OFFSET (instead of XKPHYS)
> is good check since we catch such bad usages. Do you agree ?

Yes.

> > It's wrong indeed.  But I can not see good way to handle such terrible
> > usage.  So ... let's ignore it.  I'm OK, are you ?
> 
> why do we need to handle them anyway ?
> 
> PAGE_OFFSET in XKPHYS means that the kernel runs in XKPHYS address
> space. We allow at boot time kernel address to be in CKSEG0 because
> we have a good reason to handle that. It allows to get a kernel
> smaller and faster at compile time.
> 
> PAGE_OFFSET in CKSEG0 means that the kernel runs in CKSEG0 address
> space. This means also that kernel can't handle XKPHYS address. But
> how would the kernel get addresses in XKPHYS (except user bad usages) ?

Sure.  No reason.  Excuse me for such a bad example ;)

---
Atsushi Nemoto
