Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 17:20:18 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:14791 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225241AbSLKRUR>; Wed, 11 Dec 2002 17:20:17 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA27314;
	Wed, 11 Dec 2002 18:20:30 +0100 (MET)
Date: Wed, 11 Dec 2002 18:20:30 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: linux-mips@linux-mips.org
Subject: Re: IDE module problem
In-Reply-To: <20021211084914.A6755@mvista.com>
Message-ID: <Pine.GSO.3.96.1021211181032.22157L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 11 Dec 2002, Jun Sun wrote:

> > > This is because arch/mips/lib/Makefile says:
> > > 
> > > obj-$(CONFIG_IDE)               += ide-std.o ide-no.o
> > [...]
> > > 3) use some smart trick in Makefile so that we include those
> > > two files only if CONFIG_IDE is 'y' or 'm'.  (How?)
> > 
> >  obj-$(CONFIG_IDE_MODULE)
> 
> This does not work.  Apparently, CONFIG_IDE_MODULE is not created 
> for makefile part.

 Indeed -- my fault.  Variables such as $(CONFIG_IDE) are four-state and
for the module case they are simply set to "m".  But then you can use
"ifeq ($(CONFIG_IDE),m)".  Another approach is to invent an additional
variable automatically set to "y" whenever CONFIG_IDE is enabled. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
