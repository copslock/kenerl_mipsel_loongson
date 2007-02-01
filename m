Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2007 14:32:48 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:62462 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038959AbXBAOcm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 1 Feb 2007 14:32:42 +0000
Received: from localhost (p5011-ipad301funabasi.chiba.ocn.ne.jp [122.17.255.11])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1FDDBB620; Thu,  1 Feb 2007 23:31:21 +0900 (JST)
Date:	Thu, 01 Feb 2007 23:31:20 +0900 (JST)
Message-Id: <20070201.233120.126142024.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	vagabon.xyz@gmail.com, dan@debian.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: RFC: Sentosa boot fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0702011233240.7161@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0701301713350.9231@blysk.ds.pg.gda.pl>
	<cda58cb80702010151x62e3b92ap18c63110f7fd4f0c@mail.gmail.com>
	<Pine.LNX.4.64N.0702011233240.7161@blysk.ds.pg.gda.pl>
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
X-archive-position: 13879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 1 Feb 2007 13:20:15 +0000 (GMT), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> > if CONFIG_64BITS and ${load-y} in CKSEG0
> >    cflags-y += -msym32
> > endif
> > 
> > what do you think ?
> 
>  I do not see enough of justification for -msym32 to be forced.  This will 
> also raise the minimum version of binutils required to 2.16 for the 
> affected platforms, which may be a little bit too aggressive.

Well, $(call cc-option,-msym32) can be used safely.  AFAIK -msym32 was
added to gcc 4.0 which was released on Apr 2005, and binutils 2.16 was
release on May 2005.  So if gcc accepted -msym32 we can assume
binutils accept too.

I think killing BUILD_ELF64 and adding -msym32 automatically are good
idea.  Also I do not think __pa_page_offset() is critical for
performance.

---
Atsushi Nemoto
