Received:  by oss.sgi.com id <S554088AbRAQPrd>;
	Wed, 17 Jan 2001 07:47:33 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:14321 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S554085AbRAQPrL>; Wed, 17 Jan 2001 07:47:11 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S868141AbRAQPpW>; Wed, 17 Jan 2001 13:45:22 -0200
Date:	Wed, 17 Jan 2001 13:45:22 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:	Ian Chilton <ian@ichilton.co.uk>, linux-mips@oss.sgi.com
Subject: Re: Kernel Report - 010117 (2.4.0)
Message-ID: <20010117134521.A903@bacchus.dhis.org>
References: <20010117125603.A29302@woody.ichilton.co.uk> <Pine.GSO.3.96.1010117150114.29693B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010117150114.29693B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jan 17, 2001 at 03:15:23PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 17, 2001 at 03:15:23PM +0100, Maciej W. Rozycki wrote:

>  The double output looks like a problem with printk.  Ralf, I recall you
> made a few changes related to printk on SGI recently -- could you please
> look into it?

Yes, it's fairly obvious which change is causing it.  It's less obvious
why it happens.  I use the same strategy for the Momentum Ocelot CP7000
and Origin systems and don't get double output.  Will look into it.

  Ralf
