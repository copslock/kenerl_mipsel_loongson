Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2004 15:01:25 +0000 (GMT)
Received: from verein.lst.de ([IPv6:::ffff:212.34.189.10]:58011 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8224863AbUAIPBZ>;
	Fri, 9 Jan 2004 15:01:25 +0000
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id i09F1Hst021565
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jan 2004 16:01:17 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id i09F1Brv021563;
	Fri, 9 Jan 2004 16:01:11 +0100
Date: Fri, 9 Jan 2004 16:01:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, ppopov@mvista.com,
	linux-mips@linux-mips.org
Subject: Re: defconfigs
Message-ID: <20040109150111.GA21531@lst.de>
References: <1072069822.1927.9.camel@localhost.localdomain> <Pine.LNX.4.55.0312221420510.27237@jurand.ds.pg.gda.pl> <20031222233316.48e4c0b5.yuasa@hh.iij4u.or.jp> <20040109085809.GB16940@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040109085809.GB16940@linux-mips.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
X-Scanned-By: MIMEDefang 2.33 (www . roaringpenguin . com / mimedefang)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Fri, Jan 09, 2004 at 09:58:09AM +0100, Ralf Baechle wrote:
> > I think it's means like arch/ppc/configs.
> 
> Well, I moved all the files to arch/mips/defconfigs/.  Guess I should
> shorten the names now that they're in a subdir, a patch for another day :-)

Well, the arch/$FOO/configs/ name gets picked up automatically by
make oldconfig, so I think it's the better choice..
