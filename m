Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 08:55:13 +0000 (GMT)
Received: from pD9562327.dip.t-dialin.net ([IPv6:::ffff:217.86.35.39]:39715
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224989AbUKXIzJ>; Wed, 24 Nov 2004 08:55:09 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iAO8quMM020527;
	Wed, 24 Nov 2004 09:52:56 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iAO8qp9u020526;
	Wed, 24 Nov 2004 09:52:51 +0100
Date: Wed, 24 Nov 2004 09:52:51 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Manish Lachwani <mlachwani@mvista.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime
Message-ID: <20041124085251.GA20500@linux-mips.org>
References: <20041121170242.GR20986@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.4.61.0411212048520.26374@waterleaf.sonytel.be> <20041121203757.GS20986@rembrandt.csv.ica.uni-stuttgart.de> <20041122070117.GB25433@linux-mips.org> <41A283BD.3080300@mvista.com> <Pine.LNX.4.58L.0411230036310.31113@blysk.ds.pg.gda.pl> <41A29DCF.8030308@mvista.com> <Pine.LNX.4.58L.0411232018390.19941@blysk.ds.pg.gda.pl> <20041124021644.GF902@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124021644.GF902@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 24, 2004 at 03:16:44AM +0100, Thiemo Seufer wrote:

> > -#define i_ssnop(buf) i_sll(buf, 0, 2, 1)
> > +#define i_ssnop(buf) i_sll(buf, 0, 0, 1)
> 
> Just FYI, I took the ssnop definition from _ssnop in
> include/asm-mips/hazards.h, which is different from SSNOP in
> include/asm-mips/asm.h. I hope the difference is not meant to
> mean more than a typo. :-)

It was a typo.  As a shift instruction it may have kept semantics that
way but not as a superscalar nop ...

  Ralf
