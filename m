Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2003 13:00:18 +0100 (BST)
Received: from p508B5EC1.dip.t-dialin.net ([IPv6:::ffff:80.139.94.193]:20403
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225204AbTDVMAS>; Tue, 22 Apr 2003 13:00:18 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3MC07Z18450;
	Tue, 22 Apr 2003 14:00:07 +0200
Date: Tue, 22 Apr 2003 14:00:07 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Juan Quintela <quintela@mandrakesoft.com>,
	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [patch] TANBAC TB0226(NEC VR4131) for v2.5
Message-ID: <20030422140007.C15285@linux-mips.org>
References: <20030422133642.A15285@linux-mips.org> <Pine.GSO.4.21.0304221338360.16017-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0304221338360.16017-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Tue, Apr 22, 2003 at 01:40:19PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 22, 2003 at 01:40:19PM +0200, Geert Uytterhoeven wrote:

> > I don't think there's much point in using ISO style initializers everywhere.
> > So far the convention is only to replace the GNU-style inializer.
> > We unfortunately have a few places where the code got inflated by at least
> > the factor of 3 because now some code uses the ISO initializers for
> > everything - for no good reason.
> 
> What if someone will change struct resource in the future?

For the generic case that concern may be true - but I don't think struct
resource will change any time soon.  Imagine fixing all the drivers ...

  Ralf
