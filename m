Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2003 14:30:01 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:56655
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225978AbTACOaA>; Fri, 3 Jan 2003 14:30:00 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 18USpg-000fgY-00; Fri, 03 Jan 2003 15:29:56 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 18USpg-0006ej-00; Fri, 03 Jan 2003 15:29:56 +0100
Date: Fri, 3 Jan 2003 15:29:56 +0100
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Juan Quintela <quintela@mandrakesoft.com>,
	mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: fix possible buffer overflow problem in promlib
Message-ID: <20030103142956.GI31256@rembrandt.csv.ica.uni-stuttgart.de>
References: <m2hecrbb3p.fsf@demo.mitica> <Pine.GSO.4.21.0301022047090.4873-100000@vervain.sonytel.be> <20030103135422.A7796@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030103135422.A7796@linux-mips.org>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Jan 02, 2003 at 08:47:49PM +0100, Geert Uytterhoeven wrote:
> 
> > On 2 Jan 2003, Juan Quintela wrote:
> > >         as the issue about prom.h is still not clear, please aply the
> > >         trivial part.
> > 
> > >  void prom_printf(char *fmt, ...)
> > >  {
> > >  	va_list args;
> > > -	char ppbuf[1024];
> > > +	char ppbuf[BUFSIZE];
> > 
> > What about making ppbuf static, to reduce stack usage?
> 
> By the time when prom_printf() is called stack overflow is not really a
> consideration anymore, something fatal has happened before.

I don't think printing e.g. "LINUX started..." indicates something fatal. :-)


Thiemo
