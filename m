Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 17:27:05 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:42183 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225241AbSLKR1E>; Wed, 11 Dec 2002 17:27:04 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA27467;
	Wed, 11 Dec 2002 18:27:13 +0100 (MET)
Date: Wed, 11 Dec 2002 18:27:13 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Malta board patch
In-Reply-To: <20021211090405.B6755@mvista.com>
Message-ID: <Pine.GSO.3.96.1021211182238.22157M-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 11 Dec 2002, Jun Sun wrote:

> >  		irq = *(volatile u32 *)(KSEG1ADDR(BONITO_PCICFG_BASE));
> > +		__asm__ __volatile__(
> > +			".set\tnoreorder\n\t"
> > +			".set\tnoat\n\t"
> > +			"sync\n\t"
> > +			".set\tat\n\t"
> > +			".set\treorder");
> >  		irq &= 0xff;
> >  		BONITO_PCIMAP_CFG = 0;
> >  		break;
> 
> Would a higher level macro such as __sync or fast_mb be better here?

 Fixed by Ralf in the CVS already. :-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
