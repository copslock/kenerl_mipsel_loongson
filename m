Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2003 12:54:45 +0000 (GMT)
Received: from p508B705C.dip.t-dialin.net ([IPv6:::ffff:80.139.112.92]:45186
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225973AbTACMyo>; Fri, 3 Jan 2003 12:54:44 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h03CsNN07917;
	Fri, 3 Jan 2003 13:54:23 +0100
Date: Fri, 3 Jan 2003 13:54:23 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Juan Quintela <quintela@mandrakesoft.com>,
	mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: fix possible buffer overflow problem in promlib
Message-ID: <20030103135422.A7796@linux-mips.org>
References: <m2hecrbb3p.fsf@demo.mitica> <Pine.GSO.4.21.0301022047090.4873-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0301022047090.4873-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Thu, Jan 02, 2003 at 08:47:49PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 02, 2003 at 08:47:49PM +0100, Geert Uytterhoeven wrote:

> On 2 Jan 2003, Juan Quintela wrote:
> >         as the issue about prom.h is still not clear, please aply the
> >         trivial part.
> 
> >  void prom_printf(char *fmt, ...)
> >  {
> >  	va_list args;
> > -	char ppbuf[1024];
> > +	char ppbuf[BUFSIZE];
> 
> What about making ppbuf static, to reduce stack usage?

By the time when prom_printf() is called stack overflow is not really a
consideration anymore, something fatal has happened before.

prom_printf() is our own variant of early_print() so eventually should
be replaced by that anyway.

  Ralf
