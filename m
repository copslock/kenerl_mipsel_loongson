Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2008 11:03:41 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:34412 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20026726AbYGXKDj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 Jul 2008 11:03:39 +0100
Received: from no.name.available by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [213.58.128.207]) with ESMTP; Thu, 24 Jul 2008 19:03:37 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 5D1014552A;
	Thu, 24 Jul 2008 19:03:32 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 50FE842BBE;
	Thu, 24 Jul 2008 19:03:32 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id m6OA3Vfl097725;
	Thu, 24 Jul 2008 19:03:31 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 24 Jul 2008 19:03:30 +0900 (JST)
Message-Id: <20080724.190330.84217039.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	mano@roarinelk.homelinux.net, linux-mips@linux-mips.org
Subject: Re: 2.6.26-gitX: insane number of section headers
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080716105927.GA8206@linux-mips.org>
References: <20080716075246.GA3184@roarinelk.homelinux.net>
	<20080716081532.GB3184@roarinelk.homelinux.net>
	<20080716105927.GA8206@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.1 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 16 Jul 2008 11:59:27 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > I see Ralf added -ffunction-sections with commit
> > 372a775f50347f5c1dd87752b16e5c05ea965790.
> 
> I consider that an experimental commit.  It's meant to solve the problems
> we're having on a few very large compilation units with the limited length
> of branches.  But if the cure turns out to be worse than the illness I'm
> ready to pull it again.
> 
> A more proper patchset should modify the linker scripts to avoid the
> excessive large number of sections you've noticed.  Somebody else is
> currently working on a patchset to allow the --gc-sections ld option so
> I decieded to take the path of least resistance for now.

With this commit, the _etext symbol appeared in middle of text area.
I got _etext=0x80108438 and _text=0x80100000, but my kernel is much
bigger, of course.

Reverting the commit solved the problem.  I'm using gcc 4.3.1 and
binutils 2.18.

---
Atsushi Nemoto
