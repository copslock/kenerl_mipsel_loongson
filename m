Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2004 11:57:32 +0100 (BST)
Received: from p508B72ED.dip.t-dialin.net ([IPv6:::ffff:80.139.114.237]:44308
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225528AbUGHK5G>; Thu, 8 Jul 2004 11:57:06 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i68Aup7n030958;
	Thu, 8 Jul 2004 12:56:51 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i68AuonB030957;
	Thu, 8 Jul 2004 12:56:50 +0200
Date: Thu, 8 Jul 2004 12:56:50 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS getdomainname() off by 1;
Message-ID: <20040708105650.GE17133@linux-mips.org>
References: <20040531202101.4ace5e95.rddunlap@osdl.org> <20040708004951.GA17045@linux-mips.org> <Pine.GSO.4.58.0407081045470.12221@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0407081045470.12221@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 08, 2004 at 10:46:19AM +0200, Geert Uytterhoeven wrote:

> > > Does sysirix.c need to limit <len> to 63 instead of 64 for some
> > > reason?
> >
> > I would know why - and it has other bugs also, so I removed it by the
> > normal Linux getdomainname(2) for SysV flavour syscalls, too.
> 
> I saw you even removed it from 2.0. Woow! ;-)

Yep :-)  But whoever is still runing 2.0 on MIPS must be suffering from a
suicidal tendences.  Too many bugs left unfixed.

  Ralf
