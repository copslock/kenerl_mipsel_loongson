Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2004 08:58:19 +0000 (GMT)
Received: from p508B6890.dip.t-dialin.net ([IPv6:::ffff:80.139.104.144]:3984
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225266AbUAII6S>; Fri, 9 Jan 2004 08:58:18 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i098wDfY017184;
	Fri, 9 Jan 2004 09:58:13 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i098w9e1017180;
	Fri, 9 Jan 2004 09:58:09 +0100
Date: Fri, 9 Jan 2004 09:58:09 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, ppopov@mvista.com,
	linux-mips@linux-mips.org
Subject: Re: defconfigs
Message-ID: <20040109085809.GB16940@linux-mips.org>
References: <1072069822.1927.9.camel@localhost.localdomain> <Pine.LNX.4.55.0312221420510.27237@jurand.ds.pg.gda.pl> <20031222233316.48e4c0b5.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031222233316.48e4c0b5.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 22, 2003 at 11:33:16PM +0900, Yoichi Yuasa wrote:

> > > How about if I create an arch/mips/configs directory and move all
> > > defconfig files there?  I know we've talked about this in the past and I
> > > don't remember any good reasons for not doing it?
> > 
> >  Except the plain "defconfig" file wants to keep sitting in arch/mips to
> > be picked up by configuration scripts.
> 
> I think it's means like arch/ppc/configs.

Well, I moved all the files to arch/mips/defconfigs/.  Guess I should
shorten the names now that they're in a subdir, a patch for another day :-)

  Ralf
