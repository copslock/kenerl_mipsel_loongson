Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2007 16:02:25 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:43764 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021819AbXKFQCQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2007 16:02:16 +0000
Received: from localhost (p4065-ipad306funabasi.chiba.ocn.ne.jp [123.217.174.65])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 274188A69; Wed,  7 Nov 2007 01:00:56 +0900 (JST)
Date:	Wed, 07 Nov 2007 01:02:59 +0900 (JST)
Message-Id: <20071107.010259.25478892.anemo@mba.ocn.ne.jp>
To:	ddaney@avtrex.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: WAIT vs. tickless kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <47308F36.2070200@avtrex.com>
References: <20071103.014649.122254137.anemo@mba.ocn.ne.jp>
	<20071107.003925.74752709.anemo@mba.ocn.ne.jp>
	<47308F36.2070200@avtrex.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 06 Nov 2007 07:58:46 -0800, David Daney <ddaney@avtrex.com> wrote:
> > +	.set	mips0
> > +	/* end of rollback region (the region size must be power of two) */
> > +	.set	pop
> >   
> 
> The .set mips0 is redundant as .set pop immediately follows.

Oh yes.  I'll drop it on next revision.  Thanks.

---
Atsushi Nemoto
