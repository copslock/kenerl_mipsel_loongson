Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Oct 2007 19:17:18 +0000 (GMT)
Received: from host62-210-dynamic.14-87-r.retail.telecomitalia.it ([87.14.210.62]:43501
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20023403AbXJ1TRJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 28 Oct 2007 19:17:09 +0000
Received: from eppesuig3 ([192.168.2.50])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1ImDd4-00015F-1B
	for linux-mips@linux-mips.org; Sun, 28 Oct 2007 20:17:01 +0100
Subject: 2.6.24-rc1 does not boot on SGI [was: Re: 2.4.24-rc1 does not boot
	on SGI]
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <20071029.000713.59464443.anemo@mba.ocn.ne.jp>
References: <1193468825.7474.6.camel@scarafaggio>
	 <20071029.000713.59464443.anemo@mba.ocn.ne.jp>
Content-Type: text/plain
Date:	Sun, 28 Oct 2007 20:17:11 +0100
Message-Id: <1193599031.14874.1.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno lun, 29/10/2007 alle 00.07 +0900, Atsushi Nemoto ha scritto:
> On Sat, 27 Oct 2007 09:07:05 +0200, Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org> wrote:
[...]
> > Does anyone have a suggestion about what to look for? I will start
> > looking at all diffs in arch/mips/sgi-ip32.
> 
> Could you try this one?
> 
> http://www.linux-mips.org/archives/linux-mips/2007-10/msg00431.html
> 
> I suppose currently all 64-bit platforms which use cevt-r4k.c are
> broken.

Nothing changed using this patch: the system does not boot. Currently I
suspect the reason is the change the IRQ handling because it is the main
change in arch/mips/sg-ip32.
