Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2007 15:05:56 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:58579 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022399AbXIKOFr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2007 15:05:47 +0100
Received: from localhost (p2093-ipad32funabasi.chiba.ocn.ne.jp [221.189.134.93])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 75066C997; Tue, 11 Sep 2007 23:05:42 +0900 (JST)
Date:	Tue, 11 Sep 2007 23:07:12 +0900 (JST)
Message-Id: <20070911.230712.39152979.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [MIPS] SMTC: Fix crash on bootup with idebus= command line
 argument.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0709111431240.30365@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709101406091.25038@blysk.ds.pg.gda.pl>
	<20070911.001819.126573631.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0709111431240.30365@blysk.ds.pg.gda.pl>
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
X-archive-position: 16456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 11 Sep 2007 14:40:57 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> > And how about this patch?  Does this fix the problem on SWARM?
> > http://www.linux-mips.org/archives/linux-mips/2007-09/msg00036.html
> 
>  Thanks a lot -- it makes things work for my SWARM as expected.  But 
> doesn't it break systems where there actually is a PCI-(E)ISA bridge and a 
> legacy IDE interface?

Yes, it would breaks such systems, but that is exactly we have been
doing for years, isn't it?

And if such a platform was really exists, mach-specific ide.h could be
used as final workaround.

---
Atsushi Nemoto
