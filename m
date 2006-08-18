Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2006 15:02:26 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:39406 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037786AbWHROCZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2006 15:02:25 +0100
Received: from localhost (p7196-ipad34funabasi.chiba.ocn.ne.jp [124.85.64.196])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DC312A2B4; Fri, 18 Aug 2006 23:02:19 +0900 (JST)
Date:	Fri, 18 Aug 2006 23:04:03 +0900 (JST)
Message-Id: <20060818.230403.25910276.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove mfinfo[64] used by get_wchan()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44E5AFD9.1050101@innova-card.com>
References: <44E57F39.2020009@innova-card.com>
	<20060818.181136.85412687.nemoto@toshiba-tops.co.jp>
	<44E5AFD9.1050101@innova-card.com>
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
X-archive-position: 12365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 18 Aug 2006 14:17:29 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > Why get_frame_info() will be called with info->func_size != 0 ?  The
> > offset of a _first_ instruction is 0, so "ofs" of this line in
> > unwind_stack() will be 0.
> > 
> > 	info.func_size = ofs;	/* analyze from start to ofs */
> > 
> 
> because in unwind_stack(), before the line you showed, we do:
> 
> 	if (!kallsyms_lookup(pc, &size, &ofs, &modname, namebuf))
> 		return 0;
> 	if (ofs == 0)
> 		return 0;

Oh I missed it.

> Maybe we should do instead:
> 
> 	if (!kallsyms_lookup(pc, &size, &ofs, &modname, namebuf))
> 		return 0;
> 	/* return ra if an exception occured at the first instruction */
> 	if (ofs == 0)
> 		return ra;

Sure.  I should be a right fix.  This part must be fixed anyway.

> And in any cases, if we pass info->func_size = 0 to get_frame_info(),
> then it will consider the function size as unknown.

I see.  You're right.

---
Atsushi Nemoto
