Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 22:48:05 +0000 (GMT)
Received: from pD9562327.dip.t-dialin.net ([IPv6:::ffff:217.86.35.39]:5678
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225214AbUKXWr6>; Wed, 24 Nov 2004 22:47:58 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iAOMjtAU025328;
	Wed, 24 Nov 2004 23:45:56 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iAOMjtfB025327;
	Wed, 24 Nov 2004 23:45:55 +0100
Date: Wed, 24 Nov 2004 23:45:55 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Manish Lachwani <mlachwani@mvista.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime
Message-ID: <20041124224555.GD22439@linux-mips.org>
References: <41A283BD.3080300@mvista.com> <Pine.LNX.4.58L.0411230036310.31113@blysk.ds.pg.gda.pl> <41A29DCF.8030308@mvista.com> <Pine.LNX.4.58L.0411232018390.19941@blysk.ds.pg.gda.pl> <20041124014057.GE902@rembrandt.csv.ica.uni-stuttgart.de> <20041124094423.GB21039@linux-mips.org> <Pine.LNX.4.58L.0411241451290.843@blysk.ds.pg.gda.pl> <Pine.LNX.4.58L.0411242138560.843@blysk.ds.pg.gda.pl> <20041124221240.GA24500@linux-mips.org> <Pine.LNX.4.58L.0411242237540.843@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0411242237540.843@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 24, 2004 at 10:39:56PM +0000, Maciej W. Rozycki wrote:

> > It's so easy to implement with serial console.  Best thing since sliced
> > bread :-)
> 
>  Yep, and some systems have an appropriate console output callback in the 
> firmware making it trivial.

Which unfortunately is becoming unusable fairly soon on many systems.
IP27: ARC is dead after the first TLB flush.  IP22: dead after the
external L2 controller was enabled etc.  On average I'm less than
pleased with firmware usability even for simple stuff such as printing ...

  Ralf
