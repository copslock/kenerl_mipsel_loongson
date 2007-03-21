Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2007 17:05:07 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:43467 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20021482AbXCURFC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2007 17:05:02 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id A27D5BBDAA;
	Wed, 21 Mar 2007 17:55:04 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1HU45p-0006z8-Ce; Wed, 21 Mar 2007 16:55:21 +0000
Date:	Wed, 21 Mar 2007 16:55:21 +0000
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Florian Fainelli <florian.fainelli@int-evry.fr>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix a warning in lib-64/dump_tlb.c
Message-ID: <20070321165521.GI2311@networkno.de>
References: <45FABA5A.5000007@int-evry.fr> <Pine.LNX.4.64N.0703211540520.2628@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0703211540520.2628@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Fri, 16 Mar 2007, Florian Fainelli wrote:
> 
> > This patch suppresses a warning in arch/mips/lib-64/dump_tlb.c
> > 
> > Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>
> > 
> > -----
> > diff --git a/arch/mips/lib-64/dump_tlb.c b/arch/mips/lib-64/dump_tlb.c
> > index 8232900..60a87c5 100644
> > --- a/arch/mips/lib-64/dump_tlb.c
> > +++ b/arch/mips/lib-64/dump_tlb.c
> > @@ -30,6 +30,7 @@ static inline const char *msk2str(unsigned int mask)
> >         case PM_64M:    return "64Mb";
> >         case PM_256M:   return "256Mb";
> >  #endif
> > +       default:        return NULL;
> >         }
> >  }
> 
>  I guess BUG() would be appropriate here.

AFAICS NULL is wrong, it could cause the printk to crash.


Thiemo
